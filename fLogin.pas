unit fLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, ExtCtrls;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtUser: TEdit;
    edtPass: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TButton;
    Button2: TButton;
    stbLogin: TStatusBar;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    IsAdmin: Boolean;
  public
    { Public declarations }
    class function Execute: Boolean;
    class function ExecuteAdmin: Boolean;
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  uDM;

{$R *.dfm}
class function TfrmLogin.Execute: boolean;
begin
  with TfrmLogin.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

class function TfrmLogin.ExecuteAdmin: boolean;
begin
  with TfrmLogin.Create(nil) do
  try
    IsAdmin:=true;
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  //dm.adoCnx.Close;
  dm.adoCnx.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+dm.ScarDBName+';Mode=Share Deny None;';
  try
    dm.adoCnx.Connected:=true;
  except
    Application.MessageBox('NO se puede conectar a Base de Datos', 'SCAR') ;;
  end;
end;

procedure TfrmLogin.btnOkClick(Sender: TObject);
begin
  dm.qryLogin.Close;
  try
    dm.qryLogin.Parameters[0].Value:=edtUser.Text;
    dm.qryLogin.Parameters[1].Value:=edtPass.Text;
    if IsAdmin then
      dm.qryLogin.Parameters[2].Value:=99
    else
      dm.qryLogin.Parameters[2].Value:=0;
    dm.qryLogin.Prepared:=True;
    dm.qryLogin.Open;
    if dm.qryLogin.RecordCount=1 then
      ModalResult:=mrOk
    else
      begin
      stbLogin.SimpleText:='Usuario y/o Contraseña erroneos. Ingrese nuevamente';
      edtUser.Clear;
      edtPass.Clear;
      edtUser.SetFocus;
      end;
  finally
    dm.qryLogin.Close;
  end;
end;

end.
