unit ProductGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids;

type
  TForm2 = class(TForm)
    DBGrid1: TDBGrid;
    ProductQuery: TADOQuery;
    ADOConnection1: TADOConnection;
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
begin
var
DataSource1: TDataSource;
begin
ProductQuery.close;

ProductQuery.Open;
DataSource1 := TDataSource.Create(nil);
DataSource1.DataSet := ProductQuery;
DBGrid1.DataSource := DataSource1;
DBGRid1.Repaint;
DBGRID1.Columns[0].Width:=0;
DBGRID1.Columns[1].Width:=200;
DBGRID1.Columns[1].Title.caption :='��������';
DBGRID1.Columns[2].Width:=200;
DBGRID1.Columns[2].Title.caption :='��������';
DBGRID1.Columns[3].Width:=80;
DBGRID1.Columns[3].Title.caption :='����������';
DBGRID1.Columns[4].Width:=80;
DBGRID1.Columns[4].Title.caption :='����';
end;
end;

end.
