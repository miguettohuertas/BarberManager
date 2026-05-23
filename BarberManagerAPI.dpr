program BarberManagerAPI;

{$APPTYPE CONSOLE}

uses
  System.SysUtils, System.Classes,
  Horse,
  API.Conexao in 'src\API\API.Conexao.pas',
  API.Auth in 'src\API\API.Auth.pas',
  API.Dashboard in 'src\API\API.Dashboard.pas',
  API.Servicos in 'src\API\API.Servicos.pas',
  API.Agendamentos in 'src\API\API.Agendamentos.pas',
  API.Clientes in 'src\API\API.Clientes.pas',
  API.Barbeiros in 'src\API\API.Barbeiros.pas',
  API.Avaliacoes in 'src\API\API.Avaliacoes.pas',
  API.Usuarios in 'src\API\API.Usuarios.pas';

begin
  API.Conexao.IniciarConexao;

  THorse.Use(
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.AddHeader('Access-Control-Allow-Origin', '*');
      Res.AddHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
      Res.AddHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
      if Req.Method = 'OPTIONS' then
      begin
        Res.Status(200).Send('');
        Exit;
      end;
      Next;
    end
  );

  API.Auth.RegistrarRotas;
  API.Dashboard.RegistrarRotas;
  API.Servicos.RegistrarRotas;
  API.Agendamentos.RegistrarRotas;
  API.Clientes.RegistrarRotas;
  API.Barbeiros.RegistrarRotas;
  API.Avaliacoes.RegistrarRotas;
  API.Usuarios.RegistrarRotas;

  THorse.Get('/',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      HTML: TStringList;
      FilePath: string;
    begin
      FilePath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'index.html';
      Writeln('Looking for: ' + FilePath);
      if not FileExists(FilePath) then
      begin
        Res.Status(404).Send('{"error":"index.html not found","path":"' + FilePath + '"}');
        Exit;
      end;
      HTML := TStringList.Create;
      try
        try
          HTML.LoadFromFile(FilePath, TEncoding.UTF8);
        except
          on E: Exception do
          begin
            Res.Status(500).Send('{"error":"' + E.Message + '"}');
            Exit;
          end;
        end;
        Res.ContentType('text/html; charset=utf-8');
        Res.Send(HTML.Text);
      finally
        HTML.Free;
      end;
    end
  );

  Writeln('BarberManager API running on http://localhost:9000');
  Writeln('Press Enter to stop...');
  THorse.Listen(9000);
end.
