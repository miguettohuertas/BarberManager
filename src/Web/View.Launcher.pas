unit View.Launcher;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmLauncher = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FEdtPorta: TEdit;
    FBtnIniciar: TButton;
    FLblStatus: TLabel;
    procedure BtnIniciarClick(Sender: TObject);
  public
  end;

var
  FrmLauncher: TFrmLauncher;

implementation

uses
  ServerController, View.DashboardAdmin;

{$R *.fmx}

procedure TFrmLauncher.FormCreate(Sender: TObject);
var
  LblPorta: TLabel;
begin
  Caption  := 'BarberManager — Servidor Web';
  Width    := 440;
  Height   := 180;
  Position := TFormPosition.ScreenCenter;

  LblPorta := TLabel.Create(Self);
  LblPorta.Parent      := Self;
  LblPorta.Text        := 'Porta:';
  LblPorta.Position.X  := 40;
  LblPorta.Position.Y  := 52;
  LblPorta.Width       := 50;

  FEdtPorta := TEdit.Create(Self);
  FEdtPorta.Parent     := Self;
  FEdtPorta.Position.X := 95;
  FEdtPorta.Position.Y := 44;
  FEdtPorta.Width      := 90;

  FBtnIniciar := TButton.Create(Self);
  FBtnIniciar.Parent     := Self;
  FBtnIniciar.Text       := 'Iniciar Servidor';
  FBtnIniciar.Position.X := 200;
  FBtnIniciar.Position.Y := 44;
  FBtnIniciar.Width      := 180;
  FBtnIniciar.OnClick    := BtnIniciarClick;

  FLblStatus := TLabel.Create(Self);
  FLblStatus.Parent     := Self;
  FLblStatus.Text       := 'Servidor parado';
  FLblStatus.Position.X := 40;
  FLblStatus.Position.Y := 110;
  FLblStatus.Width      := 360;
  FLblStatus.StyledSettings := [];
  FLblStatus.TextSettings.FontColor := $FF94A3B8;

  D2BridgeServerController := TD2BridgeServerController.Create(Application);
  FEdtPorta.Text := D2BridgeServerController.Prism.INIConfig.ServerPort(8080).ToString;
end;

procedure TFrmLauncher.BtnIniciarClick(Sender: TObject);
var
  Porta: Integer;
begin
  Porta := StrToIntDef(FEdtPorta.Text, 8080);

  D2BridgeServerController.PrimaryFormClass := TFrmDashboardAdmin;
  D2BridgeServerController.Prism.Options.IncludeJQuery := True;
  D2BridgeServerController.Port := Porta;
  D2BridgeServerController.StartServer;

  FBtnIniciar.Enabled := False;
  FLblStatus.Text := 'Servidor a correr em http://localhost:' + Porta.ToString;
  FLblStatus.StyledSettings := [];
  FLblStatus.TextSettings.FontColor := $FF22C55E;
end;

end.
