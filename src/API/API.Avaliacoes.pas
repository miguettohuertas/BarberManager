unit API.Avaliacoes;

interface

procedure RegistrarRotas;

implementation

uses
  System.SysUtils, System.JSON,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  Horse,
  API.Conexao;

procedure RotaRecentes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  Lista: TJSONArray;
  Item: TJSONObject;
begin
  try
    Conn := CreateConnection;
    try
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Conn;
        Query.SQL.Text :=
          'SELECT AV.ID, AV.NOTA, AV.COMENTARIO, AV.DT_AVALIACAO, ' +
          '  COALESCE(UC.NOME_COMPLETO, '''') AS NOME_CLIENTE, ' +
          '  COALESCE(UB.NOME_COMPLETO, '''') AS NOME_BARBEIRO, ' +
          '  COALESCE(S.NOME, '''') AS NOME_SERVICO ' +
          'FROM TB_AVALIACOES AV ' +
          'LEFT JOIN TB_USUARIOS UC ON UC.ID = AV.CLIENTE_ID ' +
          'LEFT JOIN TB_BARBEIROS B ON B.ID = AV.BARBEIRO_ID ' +
          'LEFT JOIN TB_USUARIOS UB ON UB.ID = B.USUARIO_ID ' +
          'LEFT JOIN TB_AGENDAMENTOS AG ON AG.ID = AV.AGENDAMENTO_ID ' +
          'LEFT JOIN TB_SERVICOS S ON S.ID = AG.SERVICO_ID ' +
          'ORDER BY AV.DT_AVALIACAO DESC ' +
          'ROWS 10';
        Query.Open;
        Lista := TJSONArray.Create;
        try
          while not Query.EOF do
          begin
            Item := TJSONObject.Create;
            Item.AddPair('id',          TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
            Item.AddPair('nota',        TJSONNumber.Create(Query.FieldByName('NOTA').AsInteger));
            Item.AddPair('comentario',  Query.FieldByName('COMENTARIO').AsString);
            Item.AddPair('dtAvaliacao', Query.FieldByName('DT_AVALIACAO').AsString);
            Item.AddPair('cliente',     Query.FieldByName('NOME_CLIENTE').AsString);
            Item.AddPair('barbeiro',    Query.FieldByName('NOME_BARBEIRO').AsString);
            Item.AddPair('servico',     Query.FieldByName('NOME_SERVICO').AsString);
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

procedure RotaPorBarbeiro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  ID: Integer;
  Lista: TJSONArray;
  Item: TJSONObject;
begin
  try
    ID := StrToIntDef(Req.Params.Field('id').AsString, 0);
    if ID = 0 then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"ID invalido"}');
      Exit;
    end;
    Conn := CreateConnection;
    try
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Conn;
        Query.SQL.Text :=
          'SELECT AV.ID, AV.NOTA, AV.COMENTARIO, AV.DT_AVALIACAO, ' +
          '  COALESCE(UC.NOME_COMPLETO, '''') AS NOME_CLIENTE ' +
          'FROM TB_AVALIACOES AV ' +
          'LEFT JOIN TB_USUARIOS UC ON UC.ID = AV.CLIENTE_ID ' +
          'WHERE AV.BARBEIRO_ID = :ID ' +
          'ORDER BY AV.DT_AVALIACAO DESC ' +
          'ROWS 20';
        Query.ParamByName('ID').AsInteger := ID;
        Query.Open;
        Lista := TJSONArray.Create;
        try
          while not Query.EOF do
          begin
            Item := TJSONObject.Create;
            Item.AddPair('id',          TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
            Item.AddPair('nota',        TJSONNumber.Create(Query.FieldByName('NOTA').AsInteger));
            Item.AddPair('comentario',  Query.FieldByName('COMENTARIO').AsString);
            Item.AddPair('dtAvaliacao', Query.FieldByName('DT_AVALIACAO').AsString);
            Item.AddPair('cliente',     Query.FieldByName('NOME_CLIENTE').AsString);
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

procedure RotaPorCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  ID: Integer;
  Lista: TJSONArray;
  Item: TJSONObject;
begin
  try
    ID := StrToIntDef(Req.Params.Field('id').AsString, 0);
    if ID = 0 then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"ID invalido"}');
      Exit;
    end;
    Conn := CreateConnection;
    try
      Query := TFDQuery.Create(nil);
      try
        Query.Connection := Conn;
        Query.SQL.Text :=
          'SELECT AV.ID, AV.AGENDAMENTO_ID, AV.NOTA, AV.COMENTARIO, AV.DT_AVALIACAO, ' +
          '  COALESCE(UB.NOME_COMPLETO, '''') AS NOME_BARBEIRO ' +
          'FROM TB_AVALIACOES AV ' +
          'LEFT JOIN TB_BARBEIROS B ON B.ID = AV.BARBEIRO_ID ' +
          'LEFT JOIN TB_USUARIOS UB ON UB.ID = B.USUARIO_ID ' +
          'WHERE AV.CLIENTE_ID = :ID ' +
          'ORDER BY AV.DT_AVALIACAO DESC';
        Query.ParamByName('ID').AsInteger := ID;
        Query.Open;
        Lista := TJSONArray.Create;
        try
          while not Query.EOF do
          begin
            Item := TJSONObject.Create;
            Item.AddPair('id',            TJSONNumber.Create(Query.FieldByName('ID').AsInteger));
            Item.AddPair('agendamentoId', TJSONNumber.Create(Query.FieldByName('AGENDAMENTO_ID').AsInteger));
            Item.AddPair('nota',          TJSONNumber.Create(Query.FieldByName('NOTA').AsInteger));
            Item.AddPair('comentario',    Query.FieldByName('COMENTARIO').AsString);
            Item.AddPair('dtAvaliacao',   Query.FieldByName('DT_AVALIACAO').AsString);
            Item.AddPair('barbeiro',      Query.FieldByName('NOME_BARBEIRO').AsString);
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
  QCheck, QInsert, QUpdate: TFDQuery;
  AgendID, ClienteID, BarbeiroID, Nota: Integer;
  Comentario: string;
begin
  try
    Body := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    if not Assigned(Body) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400).Send('{"erro":"JSON invalido"}');
      Exit;
    end;
    try
      AgendID    := Body.GetValue<Integer>('agendamentoId', 0);
      ClienteID  := Body.GetValue<Integer>('clienteId', 0);
      BarbeiroID := Body.GetValue<Integer>('barbeiroId', 0);
      Nota       := Body.GetValue<Integer>('nota', 0);
      Comentario := Body.GetValue<string>('comentario', '');
    finally
      Body.Free;
    end;

    if (AgendID = 0) or (ClienteID = 0) or (BarbeiroID = 0) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400)
        .Send('{"erro":"agendamentoId, clienteId e barbeiroId sao obrigatorios"}');
      Exit;
    end;
    if (Nota < 1) or (Nota > 5) then
    begin
      Res.ContentType('application/json; charset=utf-8').Status(400)
        .Send('{"erro":"nota deve ser entre 1 e 5"}');
      Exit;
    end;

    Conn := CreateConnection;
    try
      QCheck := TFDQuery.Create(nil);
      try
        QCheck.Connection := Conn;
        QCheck.SQL.Text := 'SELECT COUNT(*) FROM TB_AVALIACOES WHERE AGENDAMENTO_ID = :AID';
        QCheck.ParamByName('AID').AsInteger := AgendID;
        QCheck.Open;
        if QCheck.Fields[0].AsInteger > 0 then
        begin
          Res.ContentType('application/json; charset=utf-8').Status(409)
            .Send('{"erro":"Este agendamento ja foi avaliado"}');
          Exit;
        end;
      finally
        QCheck.Free;
      end;

      Conn.StartTransaction;
      try
        QInsert := TFDQuery.Create(nil);
        try
          QInsert.Connection := Conn;
          QInsert.SQL.Text :=
            'INSERT INTO TB_AVALIACOES (AGENDAMENTO_ID, CLIENTE_ID, BARBEIRO_ID, NOTA, COMENTARIO) ' +
            'VALUES (:AID, :CLI, :BAR, :NOTA, :COMENT)';
          QInsert.ParamByName('AID').AsInteger   := AgendID;
          QInsert.ParamByName('CLI').AsInteger   := ClienteID;
          QInsert.ParamByName('BAR').AsInteger   := BarbeiroID;
          QInsert.ParamByName('NOTA').AsInteger  := Nota;
          QInsert.ParamByName('COMENT').AsString := Comentario;
          QInsert.ExecSQL;
        finally
          QInsert.Free;
        end;

        QUpdate := TFDQuery.Create(nil);
        try
          QUpdate.Connection := Conn;
          QUpdate.SQL.Text :=
            'UPDATE TB_BARBEIROS SET AVALIACAO_MEDIA = ' +
            '  (SELECT AVG(CAST(NOTA AS FLOAT)) FROM TB_AVALIACOES WHERE BARBEIRO_ID = :BID) ' +
            'WHERE ID = :BID';
          QUpdate.ParamByName('BID').AsInteger := BarbeiroID;
          QUpdate.ExecSQL;
        finally
          QUpdate.Free;
        end;

        Conn.Commit;
      except
        Conn.Rollback;
        raise;
      end;

      Res.ContentType('application/json; charset=utf-8').Status(201)
        .Send('{"mensagem":"Avaliacao registada com sucesso"}');
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
  THorse.Get('/api/avaliacoes/recentes',     RotaRecentes);
  THorse.Get('/api/avaliacoes/barbeiro/:id', RotaPorBarbeiro);
  THorse.Get('/api/avaliacoes/cliente/:id',  RotaPorCliente);
  THorse.Post('/api/avaliacoes',             RotaCriar);
end;

end.
