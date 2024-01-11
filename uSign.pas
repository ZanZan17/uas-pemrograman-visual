unit uSign;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, odbcconn, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TTfrmSign }

  TTfrmSign = class(TForm)
    BLogin: TButton;
    BExit: TButton;
    EUsername: TEdit;
    EPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure BExitClick(Sender: TObject);
    procedure BLoginClick(Sender: TObject);
    procedure EUsernameChange(Sender: TObject);
    procedure Label2Click(Sender: TObject);

  private

  public
    function Login: boolean;
    function GetRole: integer;
  end;

var
  TfrmSign: TTfrmSign;
  Role: integer;

implementation

{$R *.lfm}

procedure TTfrmSign.BLoginClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TTfrmSign.EUsernameChange(Sender: TObject);
begin

end;

procedure TTfrmSign.Label2Click(Sender: TObject);
begin

end;

procedure TTfrmSign.BExitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TTfrmSign.GetRole: integer;
begin
  Result := Role;
end;

function TTfrmSign.Login: boolean;
begin
  Result := False;
  SQLConnector1.Connected := True;
  try
    with SQLQuery1 do
    begin
      SQL.Text := 'SELECT * FROM user WHERE username = :username AND password = :password';
      Params.ParamByName('username').AsString := EUsername.Text;
      Params.ParamByName('password').AsString := EPassword.Text;
      Open;

      if RecordCount >= 1 then
      begin
          Role := FieldByName('role').AsInteger;
          Result := True;
      end;
    end;
  finally
    SQLConnector1.Connected := False;
    Release;
  end;
end;

end.

