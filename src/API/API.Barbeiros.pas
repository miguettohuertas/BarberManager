unit API.Barbeiros;

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
  Lista: TJSONArray;
  Item: TJSONObject;
begin
  try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;
      Query.SQL.Text :=
        'SELECT b.ID AS ID_BARBEIRO, u.NOME_COMPLETO AS NOME, b.CARGO, b.AVALIACAO_MEDIA ' +
        'FROM TB_BARBEIROS b ' +
        'JOIN TB_USUARIOS u ON b.USUARIO_ID = u.ID ' +
        'WHERE b.ATIVO = 1 ' +
        'ORDER BY u.NOME_COMPLETO';
      Query.Open;
      Lista := TJSONArray.Create;
      try
        while not Query.EOF do
        begin
          Item := TJSONObject.Create;
          Item.AddPair('id',             TJSONNumber.Create(Query.FieldByName('ID_BARBEIRO').AsInteger));
          Item.AddPair('nome',           Query.FieldByName('NOME').AsString);
          Item.AddPair('cargo',          Query.FieldByName('CARGO').AsString);
          Item.AddPair('avaliacaoMedia', TJSONNumber.Create(Query.FieldByName('AVALIACAO_MEDIA').AsFloat));
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
      Res.ContentType('application/json; charset=utf-8').Status(500)
        .Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RegistrarRotas;
begin
  THorse.Get('/api/barbeiros', RotaListar);
end;

end.
