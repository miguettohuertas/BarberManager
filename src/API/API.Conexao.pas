unit API.Conexao;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.Intf,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.DataSet, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param;

var
  FDConnection: TFDConnection;

procedure IniciarConexao;
procedure EncerrarConexao;

implementation

var
  FDPhysFBDriverLink: TFDPhysFBDriverLink;

procedure IniciarConexao;
begin
  FDPhysFBDriverLink := TFDPhysFBDriverLink.Create(nil);
  FDPhysFBDriverLink.VendorLib :=
    'C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll';

  FDConnection := TFDConnection.Create(nil);
  FDConnection.Params.DriverID := 'FB';
  FDConnection.Params.Database :=
    'C:\ProjetosDelphi\BarberManager\BarberManager\database\barbermanager.fdb';
  FDConnection.Params.UserName := 'SYSDBA';
  FDConnection.Params.Password := 'masterkey';
  FDConnection.Params.Add('CharacterSet=UTF8');
  FDConnection.Params.Add('Protocol=Local');
  FDConnection.Connected := True;
  FDConnection.TxOptions.AutoCommit := True;
  FDConnection.TxOptions.AutoStart  := True;
  Writeln('Database connected.');
end;

procedure EncerrarConexao;
begin
  if Assigned(FDConnection) then
  begin
    FDConnection.Connected := False;
    FreeAndNil(FDConnection);
  end;
  FreeAndNil(FDPhysFBDriverLink);
end;

end.
