unit API.Clientes;

interface

procedure RegistrarRotas;

implementation

uses
  System.SysUtils, System.JSON,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  Horse,
  API.Conexao;

procedure RotaListar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: TFDQuery;
  BuscaParam, SQL: string;
  Lista: TJSONArray;
  Item: TJSONObject;
begin
  try
    BuscaParam := Req.Query.Field('busca').AsString;

    SQL :=
      'SELECT ID, NOME_COMPLETO, EMAIL, ATIVO, DT_CADASTRO ' +
      'FROM TB_USUARIOS ' +
      'WHERE PERFIL = ''CLIENTE''';

    if BuscaParam <> '' then
      SQL := SQL +
        ' AND (UPPER(NOME_COMPLETO) CONTAINING UPPER(:BUSCA) OR ' +
        '      UPPER(EMAIL) CONTAINING UPPER(:BUSCA))';

    SQL := SQL + ' ORDER BY NOME_COMPLETO';

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;
      Query.SQL.Text := SQL;
      if BuscaParam <> '' then
        Query.ParamByName('BUSCA').AsString := BuscaParam;
      Query.Open;

      Lista := TJSONArray.Create;
      try
        while not Query.EOF do
        begin
          Item := TJSONObject.Create;
          Item.AddPair('id',          TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
          Item.AddPair('nome',        Query.FieldByName('NOME_COMPLETO').AsString);
          Item.AddPair('email',       Query.FieldByName('EMAIL').AsString);
          Item.AddPair('ativo',       TJSONBool.Create(Query.FieldByName('ATIVO').AsInteger = 1));
          Item.AddPair('dtCadastro',  Query.FieldByName('DT_CADASTRO').AsString);
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
        'UPDATE TB_USUARIOS ' +
        'SET ATIVO = (CASE WHEN ATIVO = 1 THEN 0 ELSE 1 END) ' +
        'WHERE ID = :ID AND PERFIL = ''CLIENTE''';
      Query.ParamByName('ID').AsInteger := ID;
      Query.ExecSQL;
      Res.ContentType('application/json; charset=utf-8').Status(200)
        .Send('{"mensagem":"Status do cliente atualizado"}');
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
  THorse.Get('/api/clientes',              RotaListar);
  THorse.Put('/api/clientes/:id/toggle',   RotaToggle);
end;

end.
