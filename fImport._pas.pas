unit fImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Grids, DBGrids, DB, Mask, rxToolEdit;

type
  TfrmImport = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    btnOk: TButton;
    Button2: TButton;
    btnProcess: TButton;
    mmoImport: TMemo;
    cbxTable: TComboBox;
    Label1: TLabel;
    edtImportFile: TFilenameEdit;
    procedure btnProcessClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edtImportFileAfterDialog(Sender: TObject; var Name: string; var Action: Boolean);
    procedure edtImportFileChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImport: TfrmImport;

implementation

uses
  uDM, uStrUtils, ADODb;

{$R *.dfm}

procedure TfrmImport.btnOkClick(Sender: TObject);
const
   lTables: array[0..5] of string=('Employees','BioFingers','Entries','Payrolls','Departments','Users');
  sqlQry: string = 'SELECT * FROM %s WHERE %s';
  sqlFilter: string = 'modified_on BETWEEN %s AND %s';
  sqlCond: string = 'AND %s = %s ';
  sqlIns: string = 'INSERT INTO %s (%s) VALUES (%s)';
  sqlUpd: string = 'UPDATE %s SET %s WHERE modified_on > :modified_on';

var
  rec, slKeyFields: TAdvStringList;
  i,j, k, l, idx, fiBlob: integer;
  blob, blobfile: Tstream;
  blobname: string;
  szTable, szQryCond: string;
  slCols, slParms, slQryCond, slSet, slKeyValues: TStringlist;
  dsIndx,dsBlob: TADOTable;
  vList: Variant;
  bFound: boolean;
begin
  fiBlob:=-1;
  slCols:= TStringList.Create;
  slParms:= TStringList.Create;
  slKeyFields:= TAdvStringList.Create;
  slKeyValues:= TStringList.Create;
  slKeyFields.TokenSeparator:=';';
  slQryCond:= TStringList.Create;
  slSet:= TStringList.Create;
  rec:=TAdvStringList.Create;
  rec.TokenSeparator:=';';
  szTable:=lTables[cbxTable.ItemIndex];
  dsIndx:=TADOTable.Create(nil);
  dsIndx.Connection:=dm.adoCnx;
  dsIndx.TableName:=szTable;
  dsIndx.Open;
  slKeyFields.TokenizedText:=dsIndx.IndexDefs.Find('PrimaryKey').Fields;


  //Get Columns for Insert
  fiBlob:=-1;
  dm.cmdAux.Close;
  dm.cmdAux.CommandText:=Format(sqlQry,[szTable,'1=0']);
  dm.cmdAux.Open;
  for K := 0 to dm.cmdAux.Fields.Count - 1 do
  begin
    slCols.Add(dm.cmdAux.Fields.Fields[K].FieldName);
    slParms.Add(':'+dm.cmdAux.Fields.Fields[K].FieldName);
    slSet.Add(slCols[K]+' = :'+slCols[K]);
    if dm.cmdAux.Fields.Fields[K].DataType=ftBlob then
    fiBlob:=K;
  end;

  //Parse PrimaryKey Fields
  szQryCond:=' 1=1 ';
  for l := 0 to slKeyFields.Count - 1 do
    szQryCond:=szQryCond+Format(sqlCond,[slKeyFields[l],':'+slKeyFields[l]]);

  dm.cmdAux.Close;
  dm.cmdAux.CommandText:=Format(sqlQry,[szTable,szQryCond]);


  //Parse Values as Parameters
  for I := 0 to mmoImport.Lines.Count - 1 do
  begin
    rec.TokenizedText:=mmoImport.Lines[i];
    slKeyValues.Clear;
    dm.cmdAux.Close;
    for j := 0 to slKeyFields.Count - 1 do
    begin
      dm.cmdAux.Parameters.ParamByName(slKeyFields[J]).Value:=rec[slCols.IndexOf(slKeyFields[J])];
      slKeyValues.Add(rec[slCols.IndexOf(slKeyFields[J])]);
    end;
    //Check for doing a Insert or  Update
    dm.cmdAux.Prepared:=true;
    dm.cmdAux.Open;
    if dm.cmdAux.RecordCount>0 then
    begin
      vList := VarArrayCreate([0, 0], varVariant);
      if slKeyValues.Count>1 then
      begin
        VarArrayRedim(vList,slKeyValues.Count);
        for j := 0 to slKeyValues.Count - 1 do
          vList[J]:=dm.cmdAux.FieldByName(slKeyFields[J]).Value;
        bFound:=dsIndx.Locate(slKeyFields.TokenizedText,vList,[]);
      end
      else
        bFound:=dsIndx.Locate(slKeyFields.TokenizedText,dm.cmdAux.FieldByName(slKeyFields[0]).Value,[]);

      if bFound then
      begin
        if dsIndx.FieldByName('modified_on').AsString<rec[slCols.IndexOf('modified_on')] then
          dsIndx.Edit
        else
          continue;
      end;
    end
    else
      dsIndx.Append;

    for J := 0 to dsIndx.Fields.Count - 1 do
    begin
      if (dsIndx.State = dsEdit) and (slKeyFields.IndexOf(dsIndx.Fields.Fields[J].FieldName)=-1) then
        dsIndx.Fields.Fields[J].AsString:=rec[J];
    //Blob fieldtype values
    if j=fiBlob then
    begin
      blobname:=ExtractFilePath(edtImportFile.Text)+cbxTable.Text+rec[0]+'.skr';
      if FileExists(blobname) then
      begin
        dsBlob:=TADOTable.Create(nil);
        dsBlob.Connection:=dm.adoCnx;
        dsBlob.TableName:=szTable;
        dsBlob.Open;
        if dsBlob.Locate(slCols[0],rec[0],[loCaseInsensitive]) then
        begin
          dsBlob.Edit;
          blob:=dsBlob.CreateBlobStream(dsBlob.Fields[fiBlob],bmWrite);
          blob.Seek(0, soFromBeginning);
          blobfile:=TFileStream.Create(blobname,fmShareDenyWrite);
          try
            blob.CopyFrom(blobfile,blobfile.Size);
          finally
            blobfile.free;
          end;
          blob.Free;
          dsBlob.Post;
        end;
      end;
    end;
    end;
    dsIndx.post;
  end;
end;

procedure TfrmImport.btnProcessClick(Sender: TObject);
begin
  mmoImport.Lines.LoadFromFile(edtImportFile.Text);
  btnOk.Enabled:=true;
end;

procedure TfrmImport.Button2Click(Sender: TObject);
begin
  edtImportFile.InitialDir:=GetCurrentDir+'\XPORT';
  edtImportFile.Text:='';
  mmoImport.Clear;
  cbxTable.ItemIndex:=-1;
  btnOk.Enabled:=false;
  btnProcess.Enabled:=false;
end;

procedure TfrmImport.edtImportFileAfterDialog(Sender: TObject; var Name: string;
  var Action: Boolean);
var
  szTable, szFile: string;
begin
  szFile:=ExtractFileName(edtImportFile.Text);
  szTable:=copy(szFile,1,length(szFile)-4);
  if cbxTable.Items.IndexOf(szTable)>-1 then
  begin
    cbxTable.ItemIndex:=cbxTable.Items.IndexOf(szTable);
    btnProcess.Enabled:=true;
  end;
end;

procedure TfrmImport.edtImportFileChange(Sender: TObject);
var
  szTable, szFile: string;
begin
  szFile:=ExtractFileName(edtImportFile.Text);
  szTable:=copy(szFile,1,length(szFile)-4);
  if cbxTable.Items.IndexOf(szTable)>-1 then
  begin
    cbxTable.ItemIndex:=cbxTable.Items.IndexOf(szTable);
    btnProcess.Enabled:=true;
  end;
end;

procedure TfrmImport.FormCreate(Sender: TObject);
begin
  edtImportFile.InitialDir:=GetCurrentDir+'\XPORT';
  edtImportFile.Text:='';
  mmoImport.Clear;
  cbxTable.ItemIndex:=-1;
end;

end.
