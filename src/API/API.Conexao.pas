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

function CreateConnection: TFDConnection;

procedure IniciarConexao;
procedure EncerrarConexao;

implementation

var
  FDPhysFBDriverLink: TFDPhysFBDriverLink;

function CreateConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.Params.DriverID := 'FB';
  Result.Params.Database :=
    'C:\ProjetosDelphi\BarberManager\BarberManager\database\barbermanager.fdb';
  Result.Params.UserName := 'SYSDBA';
  Result.Params.Password := 'masterkey';
  Result.Params.Add('CharacterSet=UTF8');
  Result.Params.Add('Protocol=Local');
  Result.Connected := True;
  Result.TxOptions.Isolation := xiReadCommitted;
end;

procedure IniciarConexao;
begin
  FDPhysFBDriverLink := TFDPhysFBDriverLink.Create(nil);
  FDPhysFBDriverLink.VendorLib :=
    'C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll';
  Writeln('Database driver loaded.');
end;

procedure EncerrarConexao;
begin
  FreeAndNil(FDPhysFBDriverLink);
end;

end.
