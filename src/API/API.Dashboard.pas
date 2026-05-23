unit API.Dashboard;

interface

procedure RegistrarRotas;

implementation

uses
  System.SysUtils, System.JSON, System.DateUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  Horse,
  API.Conexao;

procedure RotaKPIs(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  DataParam: string;
  Resp: TJSONObject;
begin
  try
    DataParam := Req.Query.Field('data').AsString;
    if DataParam = '' then
      DataParam := FormatDateTime('yyyy-mm-dd', Date);

    Conn := CreateConnection;
    try
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Conn;
        Query.SQL.Text :=
          'SELECT ' +
          '  COALESCE(Q.FATURAMENTO, 0) AS FATURAMENTO, ' +
          '  COALESCE(Q.TOTAL, 0) AS TOTAL, ' +
          '  COALESCE(Q.PENDENTES, 0) AS PENDENTES, ' +
          '  COALESCE(Q.CANCELAMENTOS, 0) AS CANCELAMENTOS, ' +
          '  COALESCE(Q.EM_ANDAMENTO, 0) AS EM_ANDAMENTO, ' +
          '  COALESCE(Q.VALOR_PENDENTES, 0) AS VALOR_PENDENTES, ' +
          '  COALESCE(Q.TICKET_MEDIO, 0) AS TICKET_MEDIO, ' +
          '  COALESCE(Q.VALOR_CANCELAMENTOS, 0) AS VALOR_CANCELAMENTOS ' +
          'FROM (' +
          '  SELECT ' +
          '    SUM(CASE WHEN STATUS=''CONCLUIDO'' THEN VALOR_COBRADO ELSE 0 END) AS FATURAMENTO, ' +
          '    COUNT(*) AS TOTAL, ' +
          '    SUM(CASE WHEN STATUS=''PENDENTE'' THEN 1 ELSE 0 END) AS PENDENTES, ' +
          '    SUM(CASE WHEN STATUS=''CANCELADO'' THEN 1 ELSE 0 END) AS CANCELAMENTOS, ' +
          '    SUM(CASE WHEN STATUS=''EM_ANDAMENTO'' THEN 1 ELSE 0 END) AS EM_ANDAMENTO, ' +
          '    SUM(CASE WHEN STATUS=''PENDENTE'' THEN VALOR_COBRADO ELSE 0 END) AS VALOR_PENDENTES, ' +
          '    AVG(CASE WHEN STATUS=''CONCLUIDO'' THEN VALOR_COBRADO END) AS TICKET_MEDIO, ' +
          '    SUM(CASE WHEN STATUS=''CANCELADO'' THEN VALOR_COBRADO ELSE 0 END) AS VALOR_CANCELAMENTOS ' +
          '  FROM TB_AGENDAMENTOS ' +
          '  WHERE DT_AGENDAMENTO = :DATA' +
          ') Q';
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
    finally
      Conn.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RotaTimeline(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
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
      'SELECT A.ID, A.DT_AGENDAMENTO, CAST(A.HR_INICIO AS VARCHAR(13)) AS HR_INICIO, CAST(A.HR_FIM AS VARCHAR(13)) AS HR_FIM, A.STATUS, A.VALOR_COBRADO, ' +
      '  COALESCE(U.NOME_COMPLETO, '''') AS NOME_CLIENTE, ' +
      '  COALESCE(S.NOME, '''') AS NOME_SERVICO, ' +
      '  COALESCE(B_U.NOME_COMPLETO, '''') AS NOME_BARBEIRO ' +
      'FROM TB_AGENDAMENTOS A ' +
      'LEFT JOIN TB_USUARIOS U ON U.ID = A.CLIENTE_ID ' +
      'LEFT JOIN TB_SERVICOS S ON S.ID = A.SERVICO_ID ' +
      'LEFT JOIN TB_BARBEIROS B ON B.ID = A.BARBEIRO_ID ' +
      'LEFT JOIN TB_USUARIOS B_U ON B_U.ID = B.USUARIO_ID ' +
      'WHERE A.DT_AGENDAMENTO = :DATA';

    if BuscaParam <> '' then
      SQL := SQL +
        ' AND (UPPER(U.NOME_COMPLETO) CONTAINING UPPER(:BUSCA) OR ' +
        '      UPPER(S.NOME) CONTAINING UPPER(:BUSCA))';

    SQL := SQL + ' ORDER BY A.HR_INICIO ROWS 20';

    Conn := CreateConnection;
    try
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Conn;
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
            Item.AddPair('id',         TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
            Item.AddPair('data',       Query.FieldByName('DT_AGENDAMENTO').AsString);
            Item.AddPair('horaInicio', Query.FieldByName('HR_INICIO').AsString);
            Item.AddPair('horaFim',    Query.FieldByName('HR_FIM').AsString);
            Item.AddPair('status',     Query.FieldByName('STATUS').AsString);
            Item.AddPair('valor',      TJSONNumber.Create(Query.FieldByName('VALOR_COBRADO').AsFloat));
            Item.AddPair('cliente',    Query.FieldByName('NOME_CLIENTE').AsString);
            Item.AddPair('servico',    Query.FieldByName('NOME_SERVICO').AsString);
            Item.AddPair('barbeiro',   Query.FieldByName('NOME_BARBEIRO').AsString);
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
    finally
      Conn.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RotaFinanceiro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
const
  MESES: array[1..12] of string = (
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');
var
  Conn: TFDConnection;
  Q1, Q2: TFDQuery;
  Mes, Ano: Integer;
  FatTotal, FatConc, TicketMedio: Double;
  Total, Concluidos, Cancelados, Pendentes: Integer;
  Resp: TJSONObject;
  PorDia: TJSONArray;
  Item: TJSONObject;
begin
  try
    Mes := StrToIntDef(Req.Query.Field('mes').AsString, MonthOf(Date));
    Ano := StrToIntDef(Req.Query.Field('ano').AsString, YearOf(Date));
    if (Mes < 1) or (Mes > 12) then Mes := MonthOf(Date);
    if Ano < 2000 then Ano := YearOf(Date);

    Conn := CreateConnection;
    try
      Q1 := TFDQuery.Create(nil);
      try
        Q1.Connection := Conn;
        Q1.SQL.Text :=
          'SELECT ' +
          '  COALESCE(Q.TOTAL, 0) AS TOTAL, ' +
          '  COALESCE(Q.CONCLUIDOS, 0) AS CONCLUIDOS, ' +
          '  COALESCE(Q.CANCELADOS, 0) AS CANCELADOS, ' +
          '  COALESCE(Q.PENDENTES, 0) AS PENDENTES, ' +
          '  COALESCE(Q.FAT_CONC, 0) AS FAT_CONC, ' +
          '  COALESCE(Q.FAT_TOTAL, 0) AS FAT_TOTAL ' +
          'FROM RDB$DATABASE ' +
          'LEFT JOIN (' +
          '  SELECT COUNT(*) AS TOTAL, ' +
          '    SUM(CASE WHEN STATUS=''CONCLUIDO'' THEN 1 ELSE 0 END) AS CONCLUIDOS, ' +
          '    SUM(CASE WHEN STATUS=''CANCELADO'' THEN 1 ELSE 0 END) AS CANCELADOS, ' +
          '    SUM(CASE WHEN STATUS=''PENDENTE'' OR STATUS=''EM_ANDAMENTO'' THEN 1 ELSE 0 END) AS PENDENTES, ' +
          '    SUM(CASE WHEN STATUS=''CONCLUIDO'' THEN VALOR_COBRADO ELSE 0 END) AS FAT_CONC, ' +
          '    SUM(VALOR_COBRADO) AS FAT_TOTAL ' +
          '  FROM TB_AGENDAMENTOS ' +
          '  WHERE EXTRACT(MONTH FROM DT_AGENDAMENTO) = :MES ' +
          '  AND EXTRACT(YEAR FROM DT_AGENDAMENTO) = :ANO' +
          ') Q ON 1=1';
        Q1.ParamByName('MES').AsInteger := Mes;
        Q1.ParamByName('ANO').AsInteger := Ano;
        Q1.Open;
        Total      := Q1.FieldByName('TOTAL').AsInteger;
        Concluidos := Q1.FieldByName('CONCLUIDOS').AsInteger;
        Cancelados := Q1.FieldByName('CANCELADOS').AsInteger;
        Pendentes  := Q1.FieldByName('PENDENTES').AsInteger;
        FatConc    := Q1.FieldByName('FAT_CONC').AsFloat;
        FatTotal   := Q1.FieldByName('FAT_TOTAL').AsFloat;
      finally
        Q1.Free;
      end;

      if Concluidos > 0 then
        TicketMedio := FatConc / Concluidos
      else
        TicketMedio := 0;

      PorDia := TJSONArray.Create;
      try
        Q2 := TFDQuery.Create(nil);
        try
          Q2.Connection := Conn;
          Q2.SQL.Text :=
            'SELECT EXTRACT(DAY FROM DT_AGENDAMENTO) AS DIA, ' +
            '  COALESCE(SUM(CASE WHEN STATUS=''CONCLUIDO'' THEN VALOR_COBRADO ELSE 0 END), 0) AS VALOR, ' +
            '  COUNT(*) AS TOTAL ' +
            'FROM TB_AGENDAMENTOS ' +
            'WHERE EXTRACT(MONTH FROM DT_AGENDAMENTO) = :MES ' +
            'AND EXTRACT(YEAR FROM DT_AGENDAMENTO) = :ANO ' +
            'GROUP BY 1 ORDER BY 1';
          Q2.ParamByName('MES').AsInteger := Mes;
          Q2.ParamByName('ANO').AsInteger := Ano;
          Q2.Open;
          while not Q2.EOF do
          begin
            Item := TJSONObject.Create;
            Item.AddPair('dia',   FormatFloat('00', Q2.FieldByName('DIA').AsFloat));
            Item.AddPair('valor', TJSONNumber.Create(Q2.FieldByName('VALOR').AsFloat));
            Item.AddPair('total', TJSONNumber.Create(Q2.FieldByName('TOTAL').AsInteger));
            PorDia.AddElement(Item);
            Q2.Next;
          end;
        finally
          Q2.Free;
        end;

        Resp := TJSONObject.Create;
        try
          Resp.AddPair('faturamentoTotal',     TJSONNumber.Create(FatTotal));
          Resp.AddPair('faturamentoConcluido', TJSONNumber.Create(FatConc));
          Resp.AddPair('totalAgendamentos',    TJSONNumber.Create(Total));
          Resp.AddPair('concluidos',           TJSONNumber.Create(Concluidos));
          Resp.AddPair('cancelados',           TJSONNumber.Create(Cancelados));
          Resp.AddPair('pendentes',            TJSONNumber.Create(Pendentes));
          Resp.AddPair('ticketMedio',          TJSONNumber.Create(TicketMedio));
          Resp.AddPair('mes',                  MESES[Mes] + ' ' + IntToStr(Ano));
          Resp.AddPair('porDia',               PorDia);
          PorDia := nil;
          Res.ContentType('application/json; charset=utf-8').Status(200).Send(Resp.ToString);
        finally
          Resp.Free;
        end;
      finally
        PorDia.Free;
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
  THorse.Get('/api/dashboard/kpis',     RotaKPIs);
  THorse.Get('/api/dashboard/timeline', RotaTimeline);
  THorse.Get('/api/financeiro',         RotaFinanceiro);
end;

end.
