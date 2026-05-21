program BarberManagerAPI;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
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
      if Req.MethodType = mtAny then
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

  THorse.Listen(9000,
    procedure
    begin
      Writeln('BarberManager API running on http://localhost:9000');
      Writeln('Press Enter to stop...');
    end
  );
end.
