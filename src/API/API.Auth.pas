unit API.Auth;

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

function ValidarEmail(const Email: string): Boolean;
begin
  Result := (Pos('@', Email) > 0) and (Pos('.', Email) > 0);
end;

procedure RotaLogin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Body: TJSONObject;
  Email, Senha: string;
  Query: TFDQuery;
  Resp: TJSONObject;
begin
  try
    Body := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    if not Assigned(Body) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"JSON inválido"}');
      Exit;
    end;
    try
      Email := Body.GetValue<string>('email', '');
      Senha := Body.GetValue<string>('senha', '');
    finally
      Body.Free;
    end;

    if (Email = '') or (Senha = '') then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"Email e senha obrigatórios"}');
      Exit;
    end;

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;
      Query.SQL.Text :=
        'SELECT ID, NOME_COMPLETO, EMAIL, PERFIL FROM TB_USUARIOS ' +
        'WHERE EMAIL = :EMAIL AND SENHA_HASH = :HASH AND ATIVO = 1';
      Query.ParamByName('EMAIL').AsString := Email;
      Query.ParamByName('HASH').AsString := HashSenha(Senha);
      Query.Open;

      if Query.IsEmpty then
      begin
        Res.ContentType('application/json; charset=utf-8').Status(401).Send('{"erro":"Email ou senha inválidos"}');
        Exit;
      end;

      Resp := TJSONObject.Create;
      try
        Resp.AddPair('id', TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
        Resp.AddPair('nome', Query.FieldByName('NOME_COMPLETO').AsString);
        Resp.AddPair('email', Query.FieldByName('EMAIL').AsString);
        Resp.AddPair('perfil', Query.FieldByName('PERFIL').AsString);
        Res.ContentType('application/json; charset=utf-8').Status(200).Send(Resp.ToString);
      finally
        Resp.Free;
      end;
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RotaCadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Body: TJSONObject;
  Nome, Email, Senha: string;
  Query: TFDQuery;
begin
  try
    Body := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    if not Assigned(Body) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"JSON inválido"}');
      Exit;
    end;
    try
      Nome  := Body.GetValue<string>('nome', '');
      Email := Body.GetValue<string>('email', '');
      Senha := Body.GetValue<string>('senha', '');
    finally
      Body.Free;
    end;

    if Nome = '' then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"Nome obrigatório"}');
      Exit;
    end;
    if not ValidarEmail(Email) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"Email inválido"}');
      Exit;
    end;
    if Length(Senha) < 6 then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"Senha deve ter no mínimo 6 caracteres"}');
      Exit;
    end;

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;

      Query.SQL.Text :=
        'SELECT COUNT(*) FROM TB_USUARIOS WHERE EMAIL = :EMAIL';
      Query.ParamByName('EMAIL').AsString := Email;
      Query.Open;
      if Query.Fields[0].AsInteger > 0 then
      begin
        Res.ContentType('application/json; charset=utf-8').Status(409).Send('{"erro":"Email já cadastrado"}');
        Exit;
      end;
      Query.Close;

      Query.SQL.Text :=
        'INSERT INTO TB_USUARIOS (NOME_COMPLETO, EMAIL, SENHA_HASH, PERFIL, ATIVO) ' +
        'VALUES (:NOME, :EMAIL, :HASH, ''CLIENTE'', 1)';
      Query.ParamByName('NOME').AsString  := Nome;
      Query.ParamByName('EMAIL').AsString := Email;
      Query.ParamByName('HASH').AsString  := HashSenha(Senha);
      Query.ExecSQL;

      Res.ContentType('application/json; charset=utf-8').Status(201)
        .Send('{"mensagem":"Cadastro realizado com sucesso"}');
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RegistrarRotas;
begin
  THorse.Post('/api/auth/login',    RotaLogin);
  THorse.Post('/api/auth/cadastro', RotaCadastro);
end;

end.
