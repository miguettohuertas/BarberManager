unit API.Servicos;

interface

procedure RegistrarRotas;

implementation

uses
  System.SysUtils, System.JSON,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  Horse,
  API.Conexao;

function FixUTF8(const S: string): string;
begin
  Result := TEncoding.UTF8.GetString(TEncoding.ANSI.GetBytes(S));
end;

procedure RotaListar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: TFDQuery;
  AtivoParam, CategoriaParam, BuscaParam, SQL: string;
  Lista: TJSONArray;
  Item: TJSONObject;
begin
  try
    AtivoParam    := Req.Query.Field('ativo').AsString;
    CategoriaParam := Req.Query.Field('categoria').AsString;
    BuscaParam    := Req.Query.Field('busca').AsString;

    SQL :=
      'SELECT S.ID, S.NOME, S.DESCRICAO, S.PRECO, S.DURACAO_MIN, ' +
      '  S.BADGE, S.ATIVO, C.NOME AS CATEGORIA ' +
      'FROM TB_SERVICOS S ' +
      'LEFT JOIN TB_CATEGORIAS C ON C.ID = S.CATEGORIA_ID ' +
      'WHERE 1=1';

    if AtivoParam <> '' then
      SQL := SQL + ' AND S.ATIVO = :ATIVO';
    if CategoriaParam <> '' then
      SQL := SQL + ' AND UPPER(C.NOME) CONTAINING UPPER(:CATEGORIA)';
    if BuscaParam <> '' then
      SQL := SQL + ' AND UPPER(S.NOME) CONTAINING UPPER(:BUSCA)';

    SQL := SQL + ' ORDER BY S.NOME';

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;
      Query.SQL.Text := SQL;
      if AtivoParam <> '' then
        Query.ParamByName('ATIVO').AsInteger := StrToIntDef(AtivoParam, 1);
      if CategoriaParam <> '' then
        Query.ParamByName('CATEGORIA').AsString := CategoriaParam;
      if BuscaParam <> '' then
        Query.ParamByName('BUSCA').AsString := BuscaParam;
      Query.FetchOptions.AutoFetchAll := True;
      Query.ResourceOptions.SilentMode := True;
      Query.Open;

      Lista := TJSONArray.Create;
      try
        while not Query.EOF do
        begin
          Item := TJSONObject.Create;
          Item.AddPair('id',          TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
          Item.AddPair('nome',        FixUTF8(Query.FieldByName('NOME').AsString));
          Item.AddPair('descricao',   FixUTF8(Query.FieldByName('DESCRICAO').AsString));
          Item.AddPair('preco',       TJSONNumber.Create(Query.FieldByName('PRECO').AsFloat));
          Item.AddPair('duracaoMin',  TJSONNumber.Create(Query.FieldByName('DURACAO_MIN').AsInteger));
          Item.AddPair('badge',       FixUTF8(Query.FieldByName('BADGE').AsString));
          Item.AddPair('ativo',       TJSONBool.Create(Query.FieldByName('ATIVO').AsInteger = 1));
          Item.AddPair('categoria',   FixUTF8(Query.FieldByName('CATEGORIA').AsString));
          Lista.AddElement(Item);
          Query.Next;
        end;
        Res.ContentType('application/json; charset=utf-8').Status(200).Send(Lista.ToString);
      finally
        Lista.Free;
      end;
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RotaCriar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Body: TJSONObject;
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
      if Body.GetValue<string>('nome', '') = '' then
      begin
        Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"Nome obrigatório"}');
        Exit;
      end;

      Query := TFDQuery.Create(nil);
      try
        Query.Connection := FDConnection;
        Query.SQL.Text :=
          'INSERT INTO TB_SERVICOS (NOME, DESCRICAO, PRECO, DURACAO_MIN, CATEGORIA_ID, BADGE, ATIVO) ' +
          'VALUES (:NOME, :DESC, :PRECO, :DUR, :CAT, :BADGE, 1)';
        Query.ParamByName('NOME').AsString  := Body.GetValue<string>('nome', '');
        Query.ParamByName('DESC').AsString  := Body.GetValue<string>('descricao', '');
        Query.ParamByName('PRECO').AsFloat  := Body.GetValue<Double>('preco', 0);
        Query.ParamByName('DUR').AsInteger  := Body.GetValue<Integer>('duracaoMin', 0);
        Query.ParamByName('CAT').AsInteger  := Body.GetValue<Integer>('categoriaId', 0);
        Query.ParamByName('BADGE').AsString := Body.GetValue<string>('badge', '');
        Query.ExecSQL;
        Res.ContentType('application/json; charset=utf-8').Status(201)
          .Send('{"mensagem":"Serviço criado com sucesso"}');
      finally
        Query.Free;
      end;
    finally
      Body.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RotaAtualizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Body: TJSONObject;
  Query: TFDQuery;
  ID: Integer;
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
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := FDConnection;
        Query.SQL.Text :=
          'UPDATE TB_SERVICOS SET ' +
          '  NOME = :NOME, DESCRICAO = :DESC, PRECO = :PRECO, ' +
          '  DURACAO_MIN = :DUR, CATEGORIA_ID = :CAT, BADGE = :BADGE ' +
          'WHERE ID = :ID';
        Query.ParamByName('NOME').AsString  := Body.GetValue<string>('nome', '');
        Query.ParamByName('DESC').AsString  := Body.GetValue<string>('descricao', '');
        Query.ParamByName('PRECO').AsFloat  := Body.GetValue<Double>('preco', 0);
        Query.ParamByName('DUR').AsInteger  := Body.GetValue<Integer>('duracaoMin', 0);
        Query.ParamByName('CAT').AsInteger  := Body.GetValue<Integer>('categoriaId', 0);
        Query.ParamByName('BADGE').AsString := Body.GetValue<string>('badge', '');
        Query.ParamByName('ID').AsInteger   := ID;
        Query.ExecSQL;
        Res.ContentType('application/json; charset=utf-8').Status(200)
          .Send('{"mensagem":"Serviço atualizado"}');
      finally
        Query.Free;
      end;
    finally
      Body.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RotaDeletar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: TFDQuery;
  ID: Integer;
begin
  try
    ID := StrToIntDef(Req.Params.Field('id').AsString, 0);
    if ID = 0 then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"ID inválido"}');
      Exit;
    end;

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;
      Query.SQL.Text := 'DELETE FROM TB_SERVICOS WHERE ID = :ID';
      Query.ParamByName('ID').AsInteger := ID;
      Query.ExecSQL;
      Res.ContentType('application/json; charset=utf-8').Status(200)
        .Send('{"mensagem":"Serviço removido"}');
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RotaToggle(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: TFDQuery;
  ID: Integer;
begin
  try
    ID := StrToIntDef(Req.Params.Field('id').AsString, 0);
    if ID = 0 then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"ID inválido"}');
      Exit;
    end;

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;
      Query.SQL.Text :=
        'UPDATE TB_SERVICOS SET ATIVO = (CASE WHEN ATIVO = 1 THEN 0 ELSE 1 END) ' +
        'WHERE ID = :ID';
      Query.ParamByName('ID').AsInteger := ID;
      Query.ExecSQL;
      Res.ContentType('application/json; charset=utf-8').Status(200)
        .Send('{"mensagem":"Status atualizado"}');
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
  THorse.Get('/api/servicos',              RotaListar);
  THorse.Post('/api/servicos',             RotaCriar);
  THorse.Put('/api/servicos/:id',          RotaAtualizar);
  THorse.Delete('/api/servicos/:id',       RotaDeletar);
  THorse.Put('/api/servicos/:id/toggle',   RotaToggle);
end;

end.
