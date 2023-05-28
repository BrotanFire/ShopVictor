program ShopVictor;

uses
  Vcl.Forms,
  AuthForm in 'AuthForm.pas' {Form1},
  ClientMainForm in 'ClientMainForm.pas' {ClientForm},
  ManagerMainForm in 'ManagerMainForm.pas' {ManagerForm},
  AdminMainForm in 'AdminMainForm.pas' {AdminForm},
  ProductGrid in 'ProductGrid.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
    Application.MainFormOnTaskbar := false;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TClientForm, ClientForm);
  Application.CreateForm(TManagerForm, ManagerForm);
  Application.CreateForm(TAdminForm, AdminForm);
  Application.Run;
end.
