unit uMaletas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ComCtrls, Grids, DBGrids, DBCtrls, Buttons,
  ExtCtrls, Mask;

type
  TformMaletas = class(TForm)
    grdLog: TDBGrid;
    dtFecha: TDateTimePicker;
    Label1: TLabel;
    btnCerrar: TBitBtn;
    Label2: TLabel;
    DBNavigator1: TDBNavigator;
    edtQad: TDBEdit;
    btnPreview: TBitBtn;
    btnPrint: TBitBtn;
    procedure dsLogStateChange(Sender: TObject);
    procedure dtFechaChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formMaletas: TformMaletas;

implementation
uses QuickRpt, QRExport, uDM, rMaletas;
{$R *.dfm}

procedure TformMaletas.btnPrintClick(Sender: TObject);
begin
  frmRMaletas.rptMaletas.Print;
end;

procedure TformMaletas.dsLogStateChange(Sender: TObject);
begin
  if dm.dsPayrolls.State = dsInsert then
    dm.dsPayrolls.DataSet.Cancel;
end;

procedure TformMaletas.dtFechaChange(Sender: TObject);
begin
  with dm do
  begin
    newPayroll.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
    newPayroll.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
    try
      newPayroll.Execute;
    except
      ShowMessage('Se produjo un error tratando de generar Asistencias');
    end;
  end;

  dm.qDepts.Close;
  dm.qDepts.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  dm.qDepts.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  dm.qDepts.Open;
  dm.qDepts.First;
  grdLog.Refresh;
end;

procedure TformMaletas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=27 then
    Close;
end;

procedure TformMaletas.FormActivate(Sender: TObject);
begin
  dtFecha.Date:=Date;
  {Update Joranles for today}
  {dm.qryAsisToday.Close;
  dm.qryAsisToday.Parameters.ParamByName('fecha').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  try
    dm.qryAsisToday.Open;
    while not dm.qryAsisToday.Eof do
    begin
      dm.qryJrnEx.Close;
      dm.qryJrnEx.Parameters.ParamByName('fecha').Value:=dm.qryAsisToday.FieldByname('fecha').Value;
      dm.qryJrnEx.Parameters.ParamByName('grupo').Value:=dm.qryAsisToday.FieldByname('cuadrillaid').Value;
      dm.qryJrnEx.Parameters.ParamByName('id').Value:=dm.qryAsisToday.FieldByname('id').Value;
      try
        dm.qryJrnEx.Open;
        if dm.qryJrnEx.RecordCount=0 then
        begin
          dm.cmdJrn.Parameters.ParamByName('fecha').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
          dm.cmdJrn.Parameters.ParamByName('grupo').Value:=dm.qryAsisToday.FieldByName('cuadrillaid').AsInteger;
          dm.cmdJrn.Parameters.ParamByName('id').Value:=dm.qryAsisToday.FieldByName('id').AsFloat;
          try
            dm.cmdJrn.Execute;
          except
            dm.cmdJrn.Cancel;
          end;
        end;
      finally
        dm.qryJrnEx.Close;
      end;
      dm.qryAsisToday.Next;
    end;
  finally
    dm.qryAsisToday.Close;
  end;
  }
  with dm do
  begin
    newPayroll.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
    newPayroll.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
    try
      newPayroll.Execute;
    except
      ShowMessage('Se produjo un error tratando de generar Asistencias');
    end;
  end;
  {End Update}
  dm.qDepts.Close;
  dm.qDepts.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  dm.qDepts.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtFecha.Date);
  dm.qDepts.Open;
  dm.qDepts.First;
  dm.dsPayrolls.DataSet.Open;
end;

procedure TformMaletas.btnPreviewClick(Sender: TObject);
begin
  frmRMaletas.rptMaletas.Preview;
end;

end.
