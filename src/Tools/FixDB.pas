program FixDB;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.Intf,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.DataSet, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param;

procedure ExecSQL(Conn: TFDConnection; const SQL: string);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    Q.SQL.Text := SQL;
    Q.ExecSQL;
    Writeln('OK: ', Copy(SQL, 1, 60));
  finally
    Q.Free;
  end;
end;

var
  DriverLink: TFDPhysFBDriverLink;
  Conn: TFDConnection;
begin
  try
    DriverLink := TFDPhysFBDriverLink.Create(nil);
    DriverLink.VendorLib := 'C:\Program Files (x86)\Firebird\Firebird_3_0\fbclient.dll';

    Conn := TFDConnection.Create(nil);
    Conn.Params.DriverID  := 'FB';
    Conn.Params.Database  := 'C:\ProjetosDelphi\BarberManager\BarberManager\database\barbermanager.fdb';
    Conn.Params.UserName  := 'SYSDBA';
    Conn.Params.Password  := 'masterkey';
    Conn.Params.Add('CharacterSet=UTF8');
    Conn.Params.Add('Protocol=Local');
    Conn.Connected := True;
    Writeln('Connected.');

    ExecSQL(Conn, 'UPDATE TB_SERVICOS SET NOME=''Corte de Cabelo'',   DESCRICAO=''Corte moderno e personalizado conforme seu estilo.''   WHERE ID=1');
    ExecSQL(Conn, 'UPDATE TB_SERVICOS SET NOME=''Barba Completa'',    DESCRICAO=''Modelagem e acabamento perfeito para sua barba.''       WHERE ID=2');
    ExecSQL(Conn, 'UPDATE TB_SERVICOS SET NOME=''Combo Corte + Barba'', DESCRICAO=''O combo completo para um visual impecável.''         WHERE ID=3');
    ExecSQL(Conn, 'UPDATE TB_SERVICOS SET NOME=''Design de Sobrancelha'', DESCRICAO=''Alinhamento e design preciso das sobrancelhas.''   WHERE ID=4');
    ExecSQL(Conn, 'UPDATE TB_SERVICOS SET NOME=''Hidratação Capilar'', DESCRICAO=''Tratamento profundo para restaurar os fios.''         WHERE ID=5');
    ExecSQL(Conn, 'UPDATE TB_SERVICOS SET NOME=''Pigmentação de Barba'', DESCRICAO=''Coloração e preenchimento para barba rala ou grisalha.'' WHERE ID=6');
    ExecSQL(Conn, 'UPDATE TB_SERVICOS SET NOME=''Platinado'',          DESCRICAO=''Descoloração e aplicação de tons platinados.''        WHERE ID=7');
    ExecSQL(Conn, 'UPDATE TB_SERVICOS SET NOME=''Manutenção de Barba'', DESCRICAO=''Manutenção completa de barba''                      WHERE ID=9');
    ExecSQL(Conn, 'UPDATE TB_CATEGORIAS SET NOME=''Estética'' WHERE ID=3');
    ExecSQL(Conn, 'UPDATE TB_CATEGORIAS SET NOME=''Combo''    WHERE ID=4');

    Conn.Commit;
    Writeln('All done. Committed.');
  except
    on E: Exception do
      Writeln('ERROR: ', E.Message);
  end;
  Writeln('Press Enter to exit.');
  Readln;
end.