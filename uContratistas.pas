unit uContratistas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, DBCtrls, ExtCtrls, Mask;

type
  TformContratistas = class(TForm)
    GroupBox1: TGroupBox;
    dsCon: TDataSource;
    Panel1: TPanel;
    adoCon: TADOTable;
    Label1: TLabel;
    edtID: TDBEdit;
    Label2: TLabel;
    edtQad: TDBEdit;
    DBNavigator1: TDBNavigator;
    Panel2: TPanel;
    Button2: TButton;
    Button1: TButton;
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
  formContratistas: TformContratistas;

implementation

uses uDM;

{$R *.dfm}

procedure TformContratistas.FormCreate(Sender: TObject);
begin
  dm.adoCnx.Open;
  adoCon.Open;
end;

procedure TformContratistas.Button1Click(Sender: TObject);
begin
  if adoCon.State in [dsInsert,dsEdit] then
    adoCon.Post;
  ModalResult:=mrOk;
end;

procedure TformContratistas.Button2Click(Sender: TObject);
begin
  if adoCon.State in [dsInsert,dsEdit] then
    adoCon.Cancel;
  ModalResult:=mrCancel;
end;

procedure TformContratistas.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Ord(Key)=27 then
  Close;
end;

end.
