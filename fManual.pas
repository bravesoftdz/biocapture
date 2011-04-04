unit fManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBCtrls, StdCtrls, Mask, Grids, DBGrids;

type
  TfrmManual = class(TForm)
    Panel1: TPanel;
    grdManual: TDBGrid;
    Edit1: TEdit;
    btnOK: TButton;
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManual: TfrmManual;

implementation

uses
  uDM, uMain;

{$R *.dfm}

procedure TfrmManual.btnOKClick(Sender: TObject);
begin
  if grdManual.Fields[0]<>nil then
  begin
    formMain.lastID:=grdManual.Fields[1].AsFloat;
    ModalResult:=mrOk;
  end;
end;

procedure TfrmManual.Edit1Change(Sender: TObject);
begin
with dm do
begin
  qEmployees.Close;
  qEmployees.Parameters[0].Value:=Edit1.text+'%';
  qEmployees.Open;
 end;
end;

procedure TfrmManual.FormShow(Sender: TObject);
begin
with dm do
begin
  qEmployees.Close;
  qEmployees.Parameters[0].Value:=Edit1.text+'%';
  qEmployees.Open;
 end;
end;

end.
