unit Model.Conexao;

interface

uses
  System.SysUtils, System.Classes, FMX.Dialogs,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.Intf,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.DataSet, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs;

type
  TdmConexao = class(TDataModule)
  public
    FDConnection1: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
  private
    function GetIsConectado: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Conectar: Boolean;
    procedure Desconectar;
    property IsConectado: Boolean read GetIsConectado;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TdmConexao.GetIsConectado: Boolean;
begin
  Result := FDConnection1.Connected;
end;

constructor TdmConexao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDConnection1 := TFDConnection.Create(Self);
  FDPhysFBDriverLink1 := TFDPhysFBDriverLink.Create(Self);
  Conectar;
end;

destructor TdmConexao.Destroy;
begin
  FreeAndNil(FDPhysFBDriverLink1);
  FreeAndNil(FDConnection1);
  inherited Destroy;
end;

function TdmConexao.Conectar: Boolean;
begin
  Result := False;
  try
    FDPhysFBDriverLink1.VendorLib :=
      'C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll';

    FDConnection1.Params.DriverID := 'FB';
    FDConnection1.Params.Database :=
      'C:\ProjetosDelphi\BarberManager\BarberManager\database\barbermanager.fdb';
    FDConnection1.Params.UserName := 'SYSDBA';
    FDConnection1.Params.Password := 'masterkey';
    FDConnection1.Params.Add('CharacterSet=UTF8');
    FDConnection1.Params.Add('Protocol=Local');

    FDConnection1.Connected := True;
    Result := True;
  except
    on E: Exception do
      ShowMessage('Erro ao conectar ao banco de dados: ' + E.Message);
  end;
end;

procedure TdmConexao.Desconectar;
begin
  FDConnection1.Connected := False;
end;

end.
