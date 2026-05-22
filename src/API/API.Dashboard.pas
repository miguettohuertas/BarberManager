unit API.Dashboard;

interface

procedure RegistrarRotas;

implementation

uses
  System.SysUtils, System.JSON, System.DateUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  Horse,
  API.Conexao;

function FixUTF8(const S: string): string;
begin
  Result := TEncoding.UTF8.GetString(TEncoding.ANSI.GetBytes(S));
end;

procedure RotaKPIs(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: TFDQuery;
  DataParam: string;
  Resp: TJSONObject;
begin
  try
    DataParam := Req.Query.Field('data').AsString;
    if DataParam = '' then
      DataParam := FormatDateTime('yyyy-mm-dd', Date);

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;
      Query.SQL.Text :=
        'SELECT ' +
        '  COALESCE(SUM(CASE WHEN STATUS = ''CONCLUIDO'' THEN VALOR_COBRADO ELSE 0 END), 0) AS FATURAMENTO, ' +
        '  COUNT(*) AS TOTAL, ' +
        '  COUNT(CASE WHEN STATUS = ''PENDENTE'' THEN 1 END) AS PENDENTES, ' +
        '  COUNT(CASE WHEN STATUS = ''CANCELADO'' THEN 1 END) AS CANCELAMENTOS, ' +
        '  COUNT(CASE WHEN STATUS = ''EM_ANDAMENTO'' THEN 1 END) AS EM_ANDAMENTO, ' +
        '  COALESCE(SUM(CASE WHEN STATUS = ''PENDENTE'' THEN VALOR_COBRADO ELSE 0 END), 0) AS VALOR_PENDENTES, ' +
        '  COALESCE(AVG(CASE WHEN STATUS = ''CONCLUIDO'' THEN VALOR_COBRADO END), 0) AS TICKET_MEDIO, ' +
        '  COALESCE(SUM(CASE WHEN STATUS = ''CANCELADO'' THEN VALOR_COBRADO ELSE 0 END), 0) AS VALOR_CANCELAMENTOS ' +
        'FROM TB_AGENDAMENTOS ' +
        'WHERE DT_AGENDAMENTO = :DATA';
      Query.ParamByName('DATA').AsString := DataParam;
      Query.Open;

      Resp := TJSONObject.Create;
      try
        Resp.AddPair('faturamento',        TJSONNumber.Create(Query.FieldByName('FATURAMENTO').AsFloat));
        Resp.AddPair('total',              TJSONNumber.Create(Query.FieldByName('TOTAL').AsInteger));
        Resp.AddPair('pendentes',          TJSONNumber.Create(Query.FieldByName('PENDENTES').AsInteger));
        Resp.AddPair('cancelamentos',      TJSONNumber.Create(Query.FieldByName('CANCELAMENTOS').AsInteger));
        Resp.AddPair('emAndamento',        TJSONNumber.Create(Query.FieldByName('EM_ANDAMENTO').AsInteger));
        Resp.AddPair('valorPendentes',     TJSONNumber.Create(Query.FieldByName('VALOR_PENDENTES').AsFloat));
        Resp.AddPair('ticketMedio',        TJSONNumber.Create(Query.FieldByName('TICKET_MEDIO').AsFloat));
        Resp.AddPair('valorCancelamentos', TJSONNumber.Create(Query.FieldByName('VALOR_CANCELAMENTOS').AsFloat));
        Resp.AddPair('data', DataParam);
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

procedure RotaTimeline(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: TFDQuery;
  DataParam, BuscaParam, SQL: string;
  Lista: TJSONArray;
  Item: TJSONObject;
begin
  try
    DataParam  := Req.Query.Field('data').AsString;
    BuscaParam := Req.Query.Field('busca').AsString;

    if DataParam = '' then
      DataParam := FormatDateTime('yyyy-mm-dd', Date);

    SQL :=
      'SELECT A.ID, A.DT_AGENDAMENTO, A.HR_INICIO, A.HR_FIM, A.STATUS, A.VALOR_COBRADO, ' +
      '  U.NOME_COMPLETO AS NOME_CLIENTE, ' +
      '  S.NOME AS NOME_SERVICO, ' +
      '  B_U.NOME_COMPLETO AS NOME_BARBEIRO ' +
      'FROM TB_AGENDAMENTOS A ' +
      'JOIN TB_USUARIOS U ON U.ID = A.CLIENTE_ID ' +
      'JOIN TB_SERVICOS S ON S.ID = A.SERVICO_ID ' +
      'JOIN TB_BARBEIROS B ON B.ID = A.BARBEIRO_ID ' +
      'JOIN TB_USUARIOS B_U ON B_U.ID = B.USUARIO_ID ' +
      'WHERE A.DT_AGENDAMENTO = :DATA';

    if BuscaParam <> '' then
      SQL := SQL +
        ' AND (UPPER(U.NOME_COMPLETO) CONTAINING UPPER(:BUSCA) OR ' +
        '      UPPER(S.NOME) CONTAINING UPPER(:BUSCA))';

    SQL := SQL + ' ORDER BY A.HR_INICIO ROWS 20';

    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection;
      Query.SQL.Text := SQL;
      Query.ParamByName('DATA').AsString := DataParam;
      if BuscaParam <> '' then
        Query.ParamByName('BUSCA').AsString := BuscaParam;
      Query.Open;

      Lista := TJSONArray.Create;
      try
        while not Query.EOF do
        begin
          Item := TJSONObject.Create;
          Item.AddPair('id',           TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
          Item.AddPair('data',         Query.FieldByName('DT_AGENDAMENTO').AsString);
          Item.AddPair('horaInicio',   Query.FieldByName('HR_INICIO').AsString);
          Item.AddPair('horaFim',      Query.FieldByName('HR_FIM').AsString);
          Item.AddPair('status',       Query.FieldByName('STATUS').AsString);
          Item.AddPair('valor',        TJSONNumber.Create(Query.FieldByName('VALOR_COBRADO').AsFloat));
          Item.AddPair('cliente',      FixUTF8(Query.FieldByName('NOME_CLIENTE').AsString));
          Item.AddPair('servico',      FixUTF8(Query.FieldByName('NOME_SERVICO').AsString));
          Item.AddPair('barbeiro',     FixUTF8(Query.FieldByName('NOME_BARBEIRO').AsString));
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

procedure RegistrarRotas;
begin
  THorse.Get('/api/dashboard/kpis',     RotaKPIs);
  THorse.Get('/api/dashboard/timeline', RotaTimeline);
end;

end.
