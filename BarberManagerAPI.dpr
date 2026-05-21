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
  API.Clientes in 'src\API\API.Clientes.pas';

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

  THorse.Get('/',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      HTML: TStringList;
      FilePath: string;
    begin
      FilePath := ExtractFilePath(ParamStr(0)) + 'index.html';
      if FileExists(FilePath) then
      begin
        HTML := TStringList.Create;
        try
          HTML.LoadFromFile(FilePath);
          Res.ContentType('text/html; charset=utf-8');
          Res.Send(HTML.Text);
        finally
          HTML.Free;
        end;
      end
      else
        Res.Status(404).Send('index.html not found');
    end
  );

  Writeln('BarberManager API running on http://localhost:9000');
  Writeln('Press Enter to stop...');
  THorse.Listen(9000);
end.
