unit API.Usuarios;

interface

procedure RegistrarRotas;

implementation

uses
  System.SysUtils, System.JSON, System.Hash,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  Horse,
  API.Conexao;

function HashSenha(const Senha: string): string;
begin
  Result := UpperCase(THashSHA2.GetHashString(Senha, THashSHA2.TSHA2Version.SHA256));
end;

procedure RotaObter(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  ID: Integer;
  Resp: TJSONObject;
begin
  try
    ID := StrToIntDef(Req.Params.Field('id').AsString, 0);
    if ID = 0 then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"ID inválido"}');
      Exit;
    end;

    Conn := CreateConnection;
    try
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Conn;
        Query.SQL.Text :=
          'SELECT ID, NOME_COMPLETO, EMAIL, PERFIL, COALESCE(TELEFONE, '''') AS TELEFONE ' +
          'FROM TB_USUARIOS WHERE ID = :ID AND ATIVO = 1';
        Query.ParamByName('ID').AsInteger := ID;
        Query.Open;

        if Query.IsEmpty then
        begin
          Res.ContentType('application/json; charset=utf-8').Status(404)
            .Send('{"erro":"Utilizador não encontrado"}');
          Exit;
        end;

        Resp := TJSONObject.Create;
        try
          Resp.AddPair('id',       TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
          Resp.AddPair('nome',     Query.FieldByName('NOME_COMPLETO').AsString);
          Resp.AddPair('email',    Query.FieldByName('EMAIL').AsString);
          Resp.AddPair('perfil',   Query.FieldByName('PERFIL').AsString);
          Resp.AddPair('telefone', Query.FieldByName('TELEFONE').AsString);
          Res.ContentType('application/json; charset=utf-8').Status(200).Send(Resp.ToString);
        finally
          Resp.Free;
        end;
      finally
        Query.Free;
      end;
    finally
      Conn.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RotaAtualizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Body: TJSONObject;
  Query: TFDQuery;
  Resp: TJSONObject;
  ID: Integer;
  Nome, Email, Telefone, Senha: string;
begin
  try
    ID := StrToIntDef(Req.Params.Field('id').AsString, 0);
    if ID = 0 then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"ID inválido"}');
      Exit;
    end;

    Body := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    if not Assigned(Body) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"JSON inválido"}');
      Exit;
    end;
    try
      Nome     := Trim(Body.GetValue<string>('nome', ''));
      Email    := Trim(Body.GetValue<string>('email', ''));
      Telefone := Trim(Body.GetValue<string>('telefone', ''));
      Senha    := Body.GetValue<string>('senha', '');
    finally
      Body.Free;
    end;

    if Nome = '' then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"Nome obrigatório"}');
      Exit;
    end;
    if (Email = '') or (Pos('@', Email) = 0) or (Pos('.', Email) = 0) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"Email inválido"}');
      Exit;
    end;
    if (Senha <> '') and (Length(Senha) < 6) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400)
        .Send('{"erro":"Senha deve ter no mínimo 6 caracteres"}');
      Exit;
    end;

    Conn := CreateConnection;
    try
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Conn;

        Query.SQL.Text :=
          'SELECT COUNT(*) FROM TB_USUARIOS WHERE EMAIL = :EMAIL AND ID <> :ID';
        Query.ParamByName('EMAIL').AsString := Email;
        Query.ParamByName('ID').AsInteger   := ID;
        Query.Open;
        if Query.Fields[0].AsInteger > 0 then
        begin
          Res.ContentType('application/json; charset=utf-8').Status(409)
            .Send('{"erro":"Email já utilizado por outro utilizador"}');
          Exit;
        end;
        Query.Close;

        if Senha <> '' then
        begin
          Query.SQL.Text :=
            'UPDATE TB_USUARIOS ' +
            'SET NOME_COMPLETO=:NOME, EMAIL=:EMAIL, TELEFONE=:TEL, SENHA_HASH=:HASH ' +
            'WHERE ID=:ID';
          Query.ParamByName('HASH').AsString := HashSenha(Senha);
        end
        else
        begin
          Query.SQL.Text :=
            'UPDATE TB_USUARIOS ' +
            'SET NOME_COMPLETO=:NOME, EMAIL=:EMAIL, TELEFONE=:TEL ' +
            'WHERE ID=:ID';
        end;
        Query.ParamByName('NOME').AsString  := Nome;
        Query.ParamByName('EMAIL').AsString := Email;
        Query.ParamByName('TEL').AsString   := Telefone;
        Query.ParamByName('ID').AsInteger   := ID;
        Query.ExecSQL;

        Resp := TJSONObject.Create;
        try
          Resp.AddPair('id',       TJSONNumber.Create(ID));
          Resp.AddPair('nome',     Nome);
          Resp.AddPair('email',    Email);
          Resp.AddPair('telefone', Telefone);
          Res.ContentType('application/json; charset=utf-8').Status(200).Send(Resp.ToString);
        finally
          Resp.Free;
        end;
      finally
        Query.Free;
      end;
    finally
      Conn.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RegistrarRotas;
begin
  THorse.Get('/api/usuarios/:id', RotaObter);
  THorse.Put('/api/usuarios/:id', RotaAtualizar);
end;

end.
