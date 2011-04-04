unit uImportar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask;

type
  TformImportar = class(TForm)
    Panel1: TPanel;
    dsImp: TDataSource;
    adoCnxCSV: TADOConnection;
    adoImp: TADOTable;
    OpenCSV: TOpenDialog;
    adoAux: TADOQuery;
    adoPer: TADOTable;
    adoCon: TADOTable;
    dsCon: TDataSource;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    DBNavigator1: TDBNavigator;
    edtImp: TEdit;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    adoQad: TADOTable;
    dsQad: TDataSource;
    DBEdit2: TDBEdit;
    DBNavigator2: TDBNavigator;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formImportar: TformImportar;

implementation

uses uDM;
{$R *.dfm}

procedure TformImportar.BitBtn2Click(Sender: TObject);
var
  strDataSource: String;
begin
  if OpenCSV.Execute then
  begin
    strDataSource:=ExtractFilePath(OpenCSV.FileName);
    edtImp.Text:=OpenCSV.FileName;
    {--
     Provider=Microsoft.Jet.OLEDB.4.0;
     Data Source=c:\CSVFilesFolder\;
     Extended Properties="text;HDR=Yes;FMT=Delimited";
     --}
    adoCnxCSV.Close;
    adoCnxCSV.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=';
    adoCnxCSV.ConnectionString:=adoCnxCSV.ConnectionString+strDataSource;
    adoCnxCSV.ConnectionString:=adoCnxCSV.ConnectionString+';Extended Properties="text;HDR=Yes;FMT=Delimited";';
    adoCnxCSV.Connected:=true;
    adoImp.TableName:=ExtractFileName(OpenCSV.FileName);
    adoImp.Open;
  end;
end;

procedure TformImportar.BitBtn3Click(Sender: TObject);
begin
  begin
    adoImp.First;
    adoPer.Open;
    while not adoImp.Eof do
    begin
      adoAux.SQL.Clear;
      AdoAux.SQL.Append('SELECT * FROM enroll WHERE ID='+adoImp.Fields.Fields[0].AsString);
      AdoAux.ExecSQL;
      if adoAux.RowsAffected=0 then
      begin
        adoPer.Insert;
        adoPer.Fields.Fields[0].Value:=adoImp.Fields.Fields[0].Value;
        adoPer.Fields.Fields[2].Value:=adoImp.Fields.Fields[1].Value;
        adoPer.Fields.Fields[3].Value:=adoImp.Fields.Fields[2].Value;
        adoPer.Fields.Fields[4].Value:=date;
        adoPer.Fields.Fields[5].Value:=1;
        adoPer.Fields.Fields[6].Value:=adoCon.Fields.Fields[1].Value;
        adoPer.Fields.Fields[7].Value:=adoQad.Fields.Fields[1].Value;
        adoPer.Post;
      end;
      adoImp.Next;
    end;
  end;
  adoPer.Close;
end;

procedure TformImportar.BitBtn1Click(Sender: TObject);
var
  strDataSource: String;
begin
  if OpenCSV.Execute then
  begin
    strDataSource:=ExtractFilePath(OpenCSV.FileName);
    edtImp.Text:=OpenCSV.FileName;
    {--
     Provider=Microsoft.Jet.OLEDB.4.0;
     Data Source=c:\CSVFilesFolder\;
     Extended Properties="text;HDR=Yes;FMT=Delimited";
     --}
    adoCnxCSV.Close;
    adoCnxCSV.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=';
    adoCnxCSV.ConnectionString:=adoCnxCSV.ConnectionString+strDataSource;
    adoCnxCSV.ConnectionString:=adoCnxCSV.ConnectionString+';Extended Properties="text;HDR=Yes;FMT=Delimited";';
    adoCnxCSV.Connected:=true;
    adoImp.TableName:=ExtractFileName(OpenCSV.FileName);
    adoImp.Open;
  end;
end;
end.
