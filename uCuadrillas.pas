unit uCuadrillas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, DBCtrls, ExtCtrls, Mask;

type
  TformCuadrillas = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label2: TLabel;
    edtQad: TDBEdit;
    Label3: TLabel;
    DBNavigator1: TDBNavigator;
    Panel2: TPanel;
    Button2: TButton;
    Button1: TButton;
    DBEdit1: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCuadrillas: TformCuadrillas;

implementation

uses uDM;

{$R *.dfm}

procedure TformCuadrillas.FormCreate(Sender: TObject);
begin
  if not dm.adoCnx.Connected then dm.adoCnx.Open;
  dm.Departments.Open;
end;

procedure TformCuadrillas.Button1Click(Sender: TObject);
begin
  if dm.Departments.State in [dsInsert,dsEdit] then
    dm.Departments.Post;
  ModalResult:=mrOk;
end;

procedure TformCuadrillas.Button2Click(Sender: TObject);
begin
  if dm.Departments.State in [dsInsert,dsEdit] then
    dm.Departments.Cancel;
  ModalResult:=mrCancel;
end;

procedure TformCuadrillas.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Ord(Key)=27 then
  Close;
end;

end.
