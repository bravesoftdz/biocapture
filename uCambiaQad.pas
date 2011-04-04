unit uCambiaQad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, DBCtrls, ExtCtrls;

type
  TformCambiaQad = class(TForm)
    adoCnxQad: TADOConnection;
    adoQad: TADOQuery;
    dsQad: TDataSource;
    Button1: TButton;
    cbxQad: TComboBox;
    Button2: TButton;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxQadChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodList: TStringList;
    lastQad: Integer;
    lastQadStr: String;
  end;

var
  formCambiaQad: TformCambiaQad;

implementation

uses uMain;

{$R *.dfm}

procedure TformCambiaQad.FormCreate(Sender: TObject);
begin
  CodList:=TStringList.Create;
  adoCnxQad.Open;
  adoQad.Open;
  adoQad.First;
  cbxQad.Clear;
  while not adoQad.Eof do
  begin
    CodList.Add(adoQad.FieldByName('id').AsString);
    cbxQad.Items.Add(adoQad.FieldByName('cuadrilla').AsString);
    adoQad.Next;
  end;
end;

procedure TformCambiaQad.Button1Click(Sender: TObject);
begin
    formMain.lastQad:=lastQad;
    //formMain.edtLastQadStr.Text:=lastQadStr;
    ModalREsult:=mrOk;
end;

procedure TformCambiaQad.cbxQadChange(Sender: TObject);
begin
    lastQad:=StrToInt(CodList.Strings[cbxqad.ItemIndex]);
    lastQadStr:=cbxQad.Items.Strings[cbxqad.ItemIndex];
end;

end.
