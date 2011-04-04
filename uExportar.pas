unit uExportar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ADODB, DB, Grids, DBGrids, CheckLst, Mask, rxToolEdit;

type
  TformExportTrx = class(TForm)
    Panel1: TPanel;
    btnExport: TButton;
    Button2: TButton;
    clbTables: TCheckListBox;
    rgpCriteria: TRadioGroup;
    stbExport: TStatusBar;
    pnlRange: TPanel;
    Label1: TLabel;
    dtDesde: TDateTimePicker;
    dtHasta: TDateTimePicker;
    Label2: TLabel;
    dedFolder: TDirectoryEdit;
    procedure btnExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure rgpCriteriaClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formExportTrx: TformExportTrx;

implementation

uses
  uDM, ds2xml;

{$R *.dfm}

procedure TformExportTrx.btnExportClick(Sender: TObject);
const
  lTables: array[0..5] of string=('Employees','BioFingers','Entries','Payrolls','Departments','Users');
  sqlQry: string = 'SELECT * FROM %s WHERE %s';
  sqlFilter: string = 'modified_on BETWEEN %s AND %s';
var
 strRow,fname, blobname, szCriteria: String;
 fexport: TextFile;
 i : integer;
 blob: TStream;
  J: Integer;
begin
  if rgpCriteria.ItemIndex<>0 then
    szCriteria:=Format(sqlFilter,[DateToStr(dtDesde.Date),DateToStr(dtHasta.Date)])
  else
    szCriteria:='1=1';
  for I := 0 to clbTables.Count - 1 do
  begin
    if clbTables.Checked[i] then
    begin
      stbExport.SimpleText:='Procesando tabla '+clbTables.Items[i]+'...';
      dm.cmdXport.Close;
      dm.cmdXport.CommandText:=Format(sqlQry,[lTables[i],szCriteria]);
      //dm.cdsXport.CommandText:=Format(sqlQry,[lTables[i],szCriteria]);
      //dm.cdsXport.Active:=true;
      try
        dm.cmdXport.Open;
        if dm.cmdXport.RecordCount>0 then
        begin
          fname:=IncludeTrailingPathDelimiter(dedFolder.Text)+clbTables.Items[i]+'.skr';
          //DatasetToXML(dm.cmdXport,fname);
          //dm.cdsXport.SaveToFile(fname);
          AssignFile(FExport, fname);
          Rewrite(FExport);
          while not dm.cmdXport.Eof do
          begin
            strRow:='';
            strRow:=dm.cmdXport.Fields.Fields[0].AsString;
            for J := 1 to dm.cmdXport.Fields.Count - 1 do
            begin
              if dm.cmdXport.Fields.Fields[j].DataType<>ftBlob then
              begin
                if dm.cmdXport.Fields.Fields[J].AsVariant <> NULL then
                  strRow:=strRow+';'+dm.cmdXport.Fields.Fields[J].AsString
                else strRow:=strRow+';NULL';
              end
              else
              begin
                blob:=dm.cmdXport.CreateBlobStream(dm.cmdXport.Fields.Fields[J],bmRead);
                blob.Seek(0,soFrombeginning);
                blobname:=ExtractFilePath(fname)+clbTables.Items[i]+dm.cmdXport.FieldByName('id').AsString+'.skr';
                if blob.size>0 then
                with TFileStream.Create(blobname, fmCreate) do
                try
                  CopyFrom(blob, blob.Size);
                finally
                  Free;
                end;
                blob.Free;
                strRow:=strRow+';NULL';
              end;
            end;
            strRow:=strRow+';';
            Writeln(FExport, strRow);
            dm.cmdXport.Next;
          end;
        end;
      except
        ShowMessage('Error al exportar tabla');
      end;
      CloseFile(FExport);
    end;
  end;
  stbExport.SimpleText:='Proceso finalizado';
end;

procedure TformExportTrx.Button2Click(Sender: TObject);
begin
  dtDesde.Date:=Date;
  dtHasta.Date:=Date;
  dedfolder.InitialDir:=GetCurrentDir+'\XPORT';
  dedfolder.Text:=GetCurrentDir+'\XPORT';
  rgpCriteria.ItemIndex:=0;
end;

procedure TformExportTrx.FormCreate(Sender: TObject);
begin
  dtDesde.Date:=Date;
  dtHasta.Date:=Date;
  dedfolder.InitialDir:=GetCurrentDir+'\XPORT';
  dedfolder.Text:=GetCurrentDir+'\XPORT';
  rgpCriteria.ItemIndex:=0;
end;

procedure TformExportTrx.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Ord(Key)=27 then
  Close;
end;

procedure TformExportTrx.rgpCriteriaClick(Sender: TObject);
begin
  if rgpCriteria.ItemIndex<>0 then
    pnlRange.Visible:=true
  else
    pnlRange.Visible:=false;
end;

end.
