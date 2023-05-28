unit ManagerMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Data.Win.ADODB, Vcl.StdCtrls,ProductGrid;

type
  TManagerForm = class(TForm)
    Page: TPageControl;
    ProductList: TTabSheet;
    OrdresList: TTabSheet;
    ADOConnection1: TADOConnection;
    DBGrid1: TDBGrid;
    Button1: TButton;
    ProductsTableQuery: TADOQuery;
    ADODataSet1: TADODataSet;
    ADOStoredProc1: TADOStoredProc;
    Button2: TButton;
    DBGrid2: TDBGrid;
    ProductQuery: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OrdresListShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManagerForm: TManagerForm;

implementation

{$R *.dfm}

procedure TManagerForm.Button1Click(Sender: TObject);
begin
ADOStoredProc1.Parameters.ParamByName('@Id').Value := strtoint(DbGrid1.DataSource.DataSet.Fields.Fields[0].Value);
if DbGrid1.DataSource.DataSet.Fields.Fields[6].Value = 1 then
ADOStoredProc1.Parameters.ParamByName('@IsDone').Value := 2
else if DbGrid1.DataSource.DataSet.Fields.Fields[6].Value = 2 then
ADOStoredProc1.Parameters.ParamByName('@IsDone').Value := 3
else if DbGrid1.DataSource.DataSet.Fields.Fields[6].Value = 3 then
ADOStoredProc1.Parameters.ParamByName('@IsDone').Value := 1;
ADOStoredProc1.ExecProc; // ��������� ���������
FormShow(Sender);
end;

procedure TManagerForm.Button2Click(Sender: TObject);
begin
Application.CreateForm(TForm2,Form2);
Form2.ProductQuery.SQL.Text := 'SELECT * FROM PorductListView where OrderID = ' + inttostr(strtoint(DbGrid1.DataSource.DataSet.Fields.Fields[0].Value));
Form2.Show;
end;

procedure TManagerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TManagerForm.FormShow(Sender: TObject);
var
DataSource1: TDataSource;
begin
try
ProductsTableQuery.close;
ProductsTableQuery.SQL.Text := 'SELECT * FROM OrdersView';
ProductsTableQuery.Open;
DataSource1 := TDataSource.Create(nil);
DataSource1.DataSet := ProductsTableQuery;
DBGrid1.DataSource := DataSource1;
DBGRid1.Repaint;
DBGRID1.Columns[0].Width:=0;
DBGRID1.Columns[1].Width:=100;
DBGRID1.Columns[1].Title.caption :='���';
DBGRID1.Columns[2].Width:=120;
DBGRID1.Columns[2].Title.caption :='�������';
DBGRID1.Columns[3].Width:=120;
DBGRID1.Columns[3].Title.caption :='����';
DBGRID1.Columns[4].Width:=370;
DBGRID1.Columns[4].Title.caption :='�����';
DBGRID1.Columns[5].Width:=150;
DBGRID1.Columns[5].Title.caption :='������';
DBGRID1.Columns[6].Width:=0;
finally

end;
end;

procedure TManagerForm.OrdresListShow(Sender: TObject);
var
DataSource2: TDataSource;
begin
ProductQuery.Close;
ProductQuery.Open;
DBGRid2.Repaint;
DataSource2 := TDataSource.Create(nil);
DataSource2.DataSet := ProductQuery;
DBGrid2.DataSource := DataSource2;
DBGRID2.Columns[0].Width:=0;
DBGRID2.Columns[1].Width:=200;
DBGRID2.Columns[1].Title.caption :='��������';
DBGRID2.Columns[2].Width:=200;
DBGRID2.Columns[2].Title.caption :='��������';
DBGRID2.Columns[3].Width:=200;
DBGRID2.Columns[3].Title.caption :='���';
DBGRID2.Columns[4].Width:=0;
DBGRID2.Columns[6].Width:=80;
DBGRID2.Columns[6].Title.caption :='����';
DBGRID2.Columns[5].Width:=0;
DBGRID2.Columns[7].Width:=80;
DBGRID2.Columns[7].Title.caption :='������';
DBGRID2.Columns[8].Width:=300;
DBGRID2.Columns[8].Title.caption :='���������� �� ������';
DBGRID2.Columns[9].Width:=0;
end;

end.
