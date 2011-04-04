unit uSincro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ADODB, DB;

type
  TformSincro = class(TForm)
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    adoAux: TADOQuery;
    adoPer: TADOTable;
    adoQry: TADOQuery;
    Panel1: TPanel;
    rgTablas: TRadioGroup;
    grpIntervalo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtDesde: TDateTimePicker;
    dtHasta: TDateTimePicker;
    btnExport: TButton;
    Button2: TButton;
    procedure btnExportClick(Sender: TObject);
    procedure rgTablasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formSincro: TformSincro;

implementation

uses uDM;
{$R *.dfm}

procedure TformSincro.btnExportClick(Sender: TObject);
var
 fname: String;
 i : Integer;
begin
  if rgTablas.ItemIndex=0 then
  begin
  if OpenDialog.Execute then
  begin
    fname := OpenDialog.FileName;
    adoPer.Open;
    adoAux.Close;

    adoQry.Close;
    adoQry.LoadFromFile(fname);
    {
    INSERT INTO ENROLL
    SELECT * FROM syncro WHERE id not in
    (SELECT id FROM enroll)
    }

    adoQry.First;
    while not adoQry.Eof do
    begin
      adoAux.SQL.Clear;
      AdoAux.SQL.Append('SELECT * FROM enroll WHERE ID='+adoQry.FieldByName('ID').AsString);
      AdoAux.ExecSQL;
      if adoAux.RowsAffected=0 then
      begin
        adoPer.Insert;
        for i:= 0 to adoPer.FieldCount-1 do
          adoPer.Fields.Fields[i].Value:=adoQry.Fields.Fields[i].Value;
        adoPer.Post;
      end;
      adoQry.Next;
    end;
  end;
  end
  else
  if SaveDialog.Execute then
  begin
    fname := SaveDialog.FileName+'.xml';
    adoQry.SQL.Clear;
    adoQry.SQL.Add('SELECT * FROM enroll');
    adoQry.SQL.Add(' WHERE fecha >=#'+DateToStr(dtDesde.Date));
    adoQry.SQL.Add('# AND fecha <=#'+DateToStr(dtHasta.Date)+'#');
    adoQry.Open;
    adoQry.SaveToFile(fname,pfXML);
  end;
  ModalResult:=mrOk;
end;

procedure TformSincro.rgTablasClick(Sender: TObject);
begin
   if rgTablas.ItemIndex=1 then
     grpIntervalo.Visible:=true
   else
     grpIntervalo.Visible:=false;
end;

procedure TformSincro.FormCreate(Sender: TObject);
begin
  dtDesde.Date:=Date;
  dtHasta.Date:=Date;
end;

procedure TformSincro.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Ord(Key)=27 then
  Close;

end;

end.
