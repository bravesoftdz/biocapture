unit uPersonal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB, DB, Mask, DBCtrls, ExtCtrls;

type
  TformPersonal = class(TForm)
    GroupBox1: TGroupBox;
    btnAceptar: TButton;
    btnCancelar: TButton;
    grpDatos: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtApe: TDBEdit;
    edtNom: TDBEdit;
    chkHabilitado: TDBCheckBox;
    edtFecha: TDBEdit;
    edtQad: TDBLookupComboBox;
    Label5: TLabel;
    DBNavigator1: TDBNavigator;
    edtID: TEdit;
    Label1: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure edtIDExit(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    id: Double;
  end;

var
  formPersonal: TformPersonal;

implementation

uses uDM;
{$R *.dfm}

procedure TformPersonal.btnAceptarClick(Sender: TObject);
begin
  if length(edtApe.Text)<2 then
    edtApe.SetFocus
  else if length(edtNom.Text)<2 then
    edtNom.SetFocus
  else
    begin
    formPersonal.id:=StrToFloat(edtID.Text);
    dm.Employees.Post;
    dm.Employees.Close;
    edtID.Text:='';
    ModalResult:=mrOk;
    end;
end;

procedure TformPersonal.edtIDExit(Sender: TObject);
var
 auxID : Double;
begin
  if length(edtId.Text)>0 then
  if not TryStrToFloat(edtID.Text,auxID) then
    edtID.Setfocus
  else
  begin
  grpDatos.Enabled:=true;
  dm.Employees.Open;
  if dm.Employees.Locate('id',StrToFloat(edtID.Text),[]) then
    begin
    btnAceptar.Caption:='Modificar';
    dm.Employees.Edit;
    //dm.Employees.FieldByName('modified_on').Value:=Date;
    edtApe.SetFocus;
    end
  else
    Begin
    dm.Employees.Insert;
    //dm.Employees.FieldByName('id').Value:=StrToFloat(edtID.Text);
    //dm.Employees.FieldByName('created_on').Value:=Date;
    edtApe.SetFocus;
    end;
  end;
end;

procedure TformPersonal.FormDeactivate(Sender: TObject);
begin
  dm.Employees.Cancel;
  edtID.Text:='';
  grpDatos.Enabled:=false;
  btnAceptar.Caption:='Aceptar';
 end;

procedure TformPersonal.btnCancelarClick(Sender: TObject);
begin
  dm.Employees.Cancel;
  dm.Employees.Close;
  edtID.Text:='';
  grpDatos.Enabled:=false;
  btnAceptar.Caption:='Aceptar';
end;

procedure TformPersonal.FormActivate(Sender: TObject);
begin
  dm.Employees.Cancel;
  dm.Employees.Close;
  edtID.Text:='';
  grpDatos.Enabled:=false;
  btnAceptar.Caption:='Aceptar';
  edtID.SetFocus;
end;

procedure TformPersonal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = VK_RETURN then
  SelectNext(ActiveControl, true, true);
end;

end.
