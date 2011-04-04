unit fAsistencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TfrmAsistencia = class(TForm)
    Panel1: TPanel;
    rgpFilters: TRadioGroup;
    GroupBox1: TGroupBox;
    lblFrom: TLabel;
    lblUntil: TLabel;
    dtpFrom: TDateTimePicker;
    dtpUntil: TDateTimePicker;
    btnPrint: TButton;
    btnSalir: TButton;
    btnPreview: TButton;
    pnlDataPreview: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    procedure rgpFiltersClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAsistencia: TfrmAsistencia;

implementation

uses uDM,rAsistencia, rAsistencias, rMaletas;

{$R *.dfm}

procedure TfrmAsistencia.btnPreviewClick(Sender: TObject);
begin
  with dm do
  begin
    qPayrolls.Close;
    qDepts.Close;
    qDepts.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtpFrom.Date);
    qDepts.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtpUntil.Date);
    qDepts.Open;
    qPayrolls.Open;
    if qPayrolls.RecordCount>0 then
//        frmRMaletas.rptMaletas.Preview;
        frmRAsistencias.rptAsistencias.Preview;
  end;

end;

procedure TfrmAsistencia.btnPrintClick(Sender: TObject);
begin
  with dm do
  begin
    qPayrolls.Close;
    qDepts.Close;
    qDepts.Parameters.ParamByName('date1').Value:=FormatDateTime('dd,mm,yyyy',dtpFrom.Date);
    qDepts.Parameters.ParamByName('date2').Value:=FormatDateTime('dd,mm,yyyy',dtpUntil.Date);
    qDepts.Open;
    qPayrolls.Open;
    if qPayrolls.RecordCount>0 then
        frmRAsistencias.rptAsistencias.Print;
  end;
end;

procedure TfrmAsistencia.FormCreate(Sender: TObject);
begin
  {$IFNDEF DEBUG}
    dtpFrom.Date:=Date;
    pnlDataPreview.Visible:=false;
  {$ELSE}
    pnlDataPreview.Visible:=true;
  {$ENDIF}
  frmAsistencia.AutoSize:=true;
  dtpUntil.Date:=dtpFrom.Date;
end;

procedure TfrmAsistencia.rgpFiltersClick(Sender: TObject);
begin
  if rgpFilters.ItemIndex = 0 then
  begin
    lblFrom.Caption:='Fecha: ';
    dtpFrom.Date:=date;
    dtpFrom.Enabled:=false;
    lblUntil.Visible:=false;
    dtpUntil.Visible:=false;
  end;
  if rgpFilters.ItemIndex = 1 then
  begin
    lblFrom.Caption:='Fecha: ';
    dtpFrom.Date:=date-1;
    dtpFrom.Enabled:=true;
    lblUntil.Visible:=false;
    dtpUntil.Visible:=false;
  end;
  if rgpFilters.ItemIndex = 2 then
  begin
    lblFrom.Caption:='Desde: ';
    dtpFrom.Date:=date;
    dtpFrom.Enabled:=true;
    dtpUntil.Date:=date;
    lblUntil.Visible:=true;
    dtpUntil.Visible:=true;
  end;

end;

end.
