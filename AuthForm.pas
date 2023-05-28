unit AuthForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls, ClientMainForm,ManagerMainForm,AdminMainForm;

type
  TForm1 = class(TForm)
    Conn: TADOConnection;
    AuthPC: TADOStoredProc;
    PasswordName: TEdit;
    LoginEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    LoginBtn: TButton;
    procedure LoginBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TForm1.LoginBtnClick(Sender: TObject);
var login,password: string;
begin
if LoginEdit.text = '' then
begin
ShowMessage('����� �� ����� ���� ������');
exit;
end;

if PasswordName.text = '' then
begin
ShowMessage('������ �� ����� ���� ������');
exit;
end;
login := LoginEdit.Text;
password := PasswordName.Text;
try
begin
AuthPc.Close;
AuthPc.Parameters.ParamByName('@Username').Value := login;
AuthPc.Parameters.ParamByName('@Password').Value := password;
AuthPc.ExecProc;
case AuthPc.Parameters.ParamByName('@AccountType').Value of
1:
begin
ClientMainForm.useraccount:= AuthPc.Parameters.ParamByName('@AccountId').Value;
ClientForm.Show;
hide();
end;
2:
begin
 ManagerForm.Show;
 hide();
end;
3:
begin
 AdminForm.Show;
 hide();
end;
4:
begin
ClientForm.Show;
ManagerForm.Show;
AdminForm.Show;
hide();
end;
end;
end;
Except
 ShowMessage('������:��������� ������� �����������');
end;
end;

end.
