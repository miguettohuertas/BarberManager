unit API.Agendamentos;

interface

procedure RegistrarRotas;

implementation

uses
  System.SysUtils, System.JSON, System.DateUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  Horse,
  API.Conexao;

procedure RotaListar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  StatusParam, DataParam, ClienteParam, SQL: string;
  Lista: TJSONArray;
  Item: TJSONObject;
begin
  try
    StatusParam  := Req.Query.Field('status').AsString;
    DataParam    := Req.Query.Field('data').AsString;
    ClienteParam := Req.Query.Field('clienteId').AsString;

    SQL :=
      'SELECT A.ID, A.DT_AGENDAMENTO, CAST(A.HR_INICIO AS VARCHAR(13)) AS HR_INICIO, CAST(A.HR_FIM AS VARCHAR(13)) AS HR_FIM, A.STATUS, ' +
      '  COALESCE(A.VALOR_COBRADO, 0) AS VALOR_COBRADO, ' +
      '  A.BARBEIRO_ID, ' +
      '  COALESCE(U.NOME_COMPLETO, '''') AS NOME_CLIENTE, U.EMAIL AS EMAIL_CLIENTE, ' +
      '  COALESCE(S.NOME, '''') AS NOME_SERVICO, COALESCE(S.PRECO, 0) AS PRECO, S.DURACAO_MIN, ' +
      '  COALESCE(B_U.NOME_COMPLETO, '''') AS NOME_BARBEIRO ' +
      'FROM TB_AGENDAMENTOS A ' +
      'LEFT JOIN TB_USUARIOS U ON U.ID = A.CLIENTE_ID ' +
      'LEFT JOIN TB_SERVICOS S ON S.ID = A.SERVICO_ID ' +
      'LEFT JOIN TB_BARBEIROS B ON B.ID = A.BARBEIRO_ID ' +
      'LEFT JOIN TB_USUARIOS B_U ON B_U.ID = B.USUARIO_ID ' +
      'WHERE 1=1';

    if StatusParam <> '' then
      SQL := SQL + ' AND A.STATUS = :STATUS';
    if DataParam <> '' then
      SQL := SQL + ' AND A.DT_AGENDAMENTO = :DATA';
    if ClienteParam <> '' then
      SQL := SQL + ' AND A.CLIENTE_ID = :CLIENTE_ID';

    SQL := SQL + ' ORDER BY A.DT_AGENDAMENTO DESC, A.HR_INICIO';

    Conn := CreateConnection;
    try
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Conn;
        Query.SQL.Text := SQL;
        if StatusParam <> '' then
          Query.ParamByName('STATUS').AsString := StatusParam;
        if DataParam <> '' then
          Query.ParamByName('DATA').AsString := DataParam;
        if ClienteParam <> '' then
          Query.ParamByName('CLIENTE_ID').AsInteger := StrToIntDef(ClienteParam, 0);
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
            Item.AddPair('cliente',      Query.FieldByName('NOME_CLIENTE').AsString);
            Item.AddPair('emailCliente', Query.FieldByName('EMAIL_CLIENTE').AsString);
            Item.AddPair('servico',      Query.FieldByName('NOME_SERVICO').AsString);
            Item.AddPair('preco',        TJSONNumber.Create(Query.FieldByName('PRECO').AsFloat));
            Item.AddPair('duracaoMin',   TJSONNumber.Create(Query.FieldByName('DURACAO_MIN').AsInteger));
            Item.AddPair('barbeiro',     Query.FieldByName('NOME_BARBEIRO').AsString);
            Item.AddPair('barbeiroId',   TJSONNumber.Create(Query.FieldByName('BARBEIRO_ID').AsInteger));
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

procedure RotaCriar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Body: TJSONObject;
  Query: TFDQuery;
  HoraInicio: TTime;
  HoraFim: TTime;
  DuracaoMin: Integer;
  DataStr: string;
  DataParts: TArray<string>;
  DtAgen: TDate;
begin
  try
    Body := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    if not Assigned(Body) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"JSON inválido"}');
      Exit;
    end;
    try
      if Body.GetValue<Integer>('clienteId', 0) = 0 then
      begin
        Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"clienteId obrigatório"}');
        Exit;
      end;
      if Body.GetValue<Integer>('barbeiroId', 0) = 0 then
      begin
        Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"barbeiroId obrigatório"}');
        Exit;
      end;
      if Body.GetValue<Integer>('servicoId', 0) = 0 then
      begin
        Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"servicoId obrigatório"}');
        Exit;
      end;

      // Parse 'YYYY-MM-DD' → TDate via EncodeDate (avoids locale date separator issues)
      DataStr   := Body.GetValue<string>('data', '');
      DataParts := DataStr.Split(['-']);
      if Length(DataParts) = 3 then
        DtAgen := EncodeDate(StrToIntDef(DataParts[0], 2024),
                             StrToIntDef(DataParts[1], 1),
                             StrToIntDef(DataParts[2], 1))
      else
        DtAgen := Date;

      // 'HH:MM' → TTime; append ':00' so StrToTimeDef never gets a partial string
      HoraInicio := StrToTimeDef(Body.GetValue<string>('horaInicio', '00:00') + ':00', 0);
      DuracaoMin := Body.GetValue<Integer>('duracaoMin', 60);
      HoraFim    := IncMinute(HoraInicio, DuracaoMin);

      Conn := CreateConnection;
      try
        Query := TFDQuery.Create(nil);
        try
          Query.Connection := Conn;
          Query.SQL.Text :=
            'INSERT INTO TB_AGENDAMENTOS ' +
            '  (CLIENTE_ID, BARBEIRO_ID, SERVICO_ID, DT_AGENDAMENTO, HR_INICIO, HR_FIM, STATUS, VALOR_COBRADO) ' +
            'VALUES ' +
            '  (:CLI, :BAR, :SVC, :DATA, :INICIO, :FIM, ''PENDENTE'', :VALOR)';
          Query.ParamByName('CLI').AsInteger   := Body.GetValue<Integer>('clienteId', 0);
          Query.ParamByName('BAR').AsInteger   := Body.GetValue<Integer>('barbeiroId', 0);
          Query.ParamByName('SVC').AsInteger   := Body.GetValue<Integer>('servicoId', 0);
          Query.ParamByName('DATA').AsDate     := DtAgen;
          // FormatDateTime 'hh:nn:ss' = locale-independent HH:MM:SS for Firebird TIME
          Query.ParamByName('INICIO').AsString := FormatDateTime('hh:nn:ss', HoraInicio);
          Query.ParamByName('FIM').AsString    := FormatDateTime('hh:nn:ss', HoraFim);
          Query.ParamByName('VALOR').AsFloat   := Body.GetValue<Double>('valor', 0);
          Query.ExecSQL;
          Res.ContentType('application/json; charset=utf-8').Status(201)
            .Send('{"mensagem":"Agendamento criado"}');
        finally
          Query.Free;
        end;
      finally
        Conn.Free;
      end;
    finally
      Body.Free;
    end;
  except
    on E: Exception do
    begin
      Writeln('ERROR POST /api/agendamentos: ' + E.Message);
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
    end;
  end;
end;

procedure RotaAtualizarStatus(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Body: TJSONObject;
  Query: TFDQuery;
  ID: Integer;
  NovoStatus: string;
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
      NovoStatus := UpperCase(Body.GetValue<string>('status', ''));
      if not (NovoStatus = 'PENDENTE') and not (NovoStatus = 'EM_ANDAMENTO') and
         not (NovoStatus = 'CONCLUIDO') and not (NovoStatus = 'CANCELADO') then
      begin
        Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"Status inválido"}');
        Exit;
      end;

      Conn := CreateConnection;
      try
        Query := TFDQuery.Create(nil);
        try
          Query.Connection := Conn;
          Query.SQL.Text :=
            'UPDATE TB_AGENDAMENTOS SET STATUS = :STATUS WHERE ID = :ID';
          Query.ParamByName('STATUS').AsString := NovoStatus;
          Query.ParamByName('ID').AsInteger    := ID;
          Query.ExecSQL;
          Res.ContentType('application/json; charset=utf-8').Status(200)
            .Send('{"mensagem":"Status atualizado"}');
        finally
          Query.Free;
        end;
      finally
        Conn.Free;
      end;
    finally
      Body.Free;
    end;
  except
    on E: Exception do
      Res.ContentType('application/json; charset=utf-8').Status(500).Send('{"erro":"' + E.Message + '"}');
  end;
end;

procedure RegistrarRotas;
begin
  THorse.Get('/api/agendamentos',            RotaListar);
  THorse.Post('/api/agendamentos',           RotaCriar);
  THorse.Put('/api/agendamentos/:id/status', RotaAtualizarStatus);
end;

end.
