{
 -------------------------------------------------------------------------------
 Sistema de Asistencia del Personal Rural
 (c) 2008 ARXyS
 http://www.arxys.com.ar
 -------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------
// GUI routines: main form
// -----------------------------------------------------------------------------------

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, uDBClass,
  ExtDlgs, GrFinger, ComCtrls, DB, Grids, DBGrids, ADODB, Buttons,
  ImgList;

type
  TformMain = class(TForm)
    MainMenu: TMainMenu;
    mnInicio: TMenuItem;
    mnOptions: TMenuItem;
    mnInicioSalir: TMenuItem;
    mnVersion: TMenuItem;
    N1: TMenuItem;
    Ayuda1: TMenuItem;
    Acercade1: TMenuItem;
    Sincronizar1: TMenuItem;
    mnSincExpAsistencias: TMenuItem;
    mnInicioCuadrillas: TMenuItem;
    N3: TMenuItem;
    btnSalir: TButton;
    GroupBox1: TGroupBox;
    pnlRdrImage: TPanel;
    image: TImage;
    grpSemaforo: TGroupBox;
    shpRed: TShape;
    shpGreen: TShape;
    btEnroll: TBitBtn;
    btVerify: TBitBtn;
    ckDisplayFinger: TCheckBox;
    ckAutoAsistencia: TCheckBox;
    ckBoxAutoIdentify: TCheckBox;
    ckAutoExtract: TCheckBox;
    pnlMasterLeft: TPanel;
    pnlRecords: TPanel;
    Splitter1: TSplitter;
    pnlLog: TPanel;
    GroupBox2: TGroupBox;
    memoLog: TMemo;
    GroupBox3: TGroupBox;
    grdLog: TDBGrid;
    Reportes1: TMenuItem;
    ControlMaletas1: TMenuItem;
    Asistencias1: TMenuItem;
    Personas1: TMenuItem;
    mnuInicioUsuarios: TMenuItem;
    N4: TMenuItem;
    btnManual: TBitBtn;
    mnuToolsImport: TMenuItem;
    MigrarDB1: TMenuItem;
    N5: TMenuItem;
    procedure mnOptionsClick(Sender: TObject);
    procedure btEnrollClick(Sender: TObject);
    procedure btVerifyClick(Sender: TObject);
    procedure btIdentifyClick(Sender: TObject);
    procedure btExtractClick(Sender: TObject);
    procedure mnInicioSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure mnVersionClick(Sender: TObject);
    procedure btnAsistenciaClick(Sender: TObject);
    procedure ckDisplayFingerClick(Sender: TObject);
    procedure mnInicioMaletasClick(Sender: TObject);
    procedure mnSincExpAsistenciasClick(Sender: TObject);
    procedure ckAutoAsistenciaClick(Sender: TObject);
    procedure Acercade1Click(Sender: TObject);
    procedure mnSincPersonasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnInicioCuadrillasClick(Sender: TObject);
    procedure mnuInicioContratistasClick(Sender: TObject);
    procedure mnSincImpPersonalClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure mnuInicioUsuariosClick(Sender: TObject);
    procedure btnManualClick(Sender: TObject);
    procedure mnuToolsImportClick(Sender: TObject);
    procedure Asistencias1Click(Sender: TObject);
    procedure MigrarDB1Click(Sender: TObject);
  private
  public
    lastID : Double;
    lastQad: Integer;
  end;

var
  formMain: TformMain;

implementation

uses uOptions, uCallbacks, uUtil, uPersonal, uMaletas, uExportar,
  uAcercade, uSincro, uCuadrillas, uCambiaQad, uContratistas,
  uDM, uImportar, fUsers, fManual, fLogin, fImport, fAsistencia, fMigrator;
{$R *.dfm}

// Application startup code
procedure TformMain.FormCreate(Sender: TObject);
var
  ret: Integer;
begin
  ShortDateFormat := 'dd/mm/yyyy';
  lastID:=0;
  lastQad:=0;
  // Initialize Tables Connections
  {dm.adoPer1.Open;
  dm.adoLog1.Filter := 'fecha='+DateToStr(Date());
  dm.adoLog1.Filtered := true;
  dm.adoLog1.Open;
  dm.adoLog1.Sort := 'fechahora DESC';}
  dm.Employees.Open;
  //dm.Entries.Filter := 'fecha='+DateToStr(Date());
  //dm.Entries.Filtered := true;
  dm.Entries.Parameters.ParamByName('date').Value:=date;
  dm.Entries.Open;
  //dm.Entries.Sort := 'fechahora DESC';
  grdLog.Columns.Add;
  grdLog.Columns[0].FieldName:='timestamp';
  grdLog.Columns[0].Title.Caption:='Fecha/Hora';
  grdLog.Columns[0].Title.Alignment := taCenter;

  grdLog.Columns.Add;
  grdLog.Columns[1].FieldName:='apenom';
  grdLog.Columns[1].Title.Caption:='Apellido y Nombre';
  grdLog.Columns[1].Title.Alignment := taCenter;

  grdLog.Columns.Add;
  grdLog.Columns[2].FieldName:='id';
  grdLog.Columns[2].Title.Caption:='ID/DNI/CUIL';
  grdLog.Columns[2].Title.Alignment := taCenter;


  // Initialize GrFinger Library
  ret := InitializeGrFinger();
  // Print result in log
  if ret < 0 then
    WriteError(ret)
  else
    WriteLog('Dispositivo Inicializado. OK!');
end;

// Application finalization code
procedure TformMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //adoCnx1.Close;
  // finalize GrFinger
  FinalizeGrFinger();
end;

// Add a fingerprint to database
procedure TformMain.Asistencias1Click(Sender: TObject);
begin
  frmAsistencia.ShowModal;
end;

procedure TformMain.btEnrollClick(Sender: TObject);
var
  id: Double;
begin
  id:=-1;
  //dm.adoPer1.Close;
  if formPersonal.ShowModal = mrOk then
  // Adding fingerprint
  id:=AnEnroll(formPersonal.id);
  // add fingerprint
  //id := Enroll();
  if id >= 0 then
    WriteLog('Huella cargada con ID = ' + FloatToStr(formPersonal.id))
  else
    if id = -10 then
      WriteLog('Error al cargar huella. Repita operación.')
    else
    if id = -20 then
      WriteLog('No se encontró ID. repita operación.')
    else  WriteLog('Error: Huella no cargada');
  //dm.adoPer1.Open;
  //dm.adoLog1.Refresh;
end;

// Identify a fingerprint
procedure TformMain.btIdentifyClick(Sender: TObject);
var
  ret: Double;
  score: Integer;
begin
  lastID:= 0;
  score := 0;
  // identify it
  ret := Identify(score);
  // write result to the log
  if ret > 0 then
  begin
    WriteLog('Huella identificada. ID = '+FloatToStr(ret)+'. Puntaje = '+
             IntToStr(score)+'.');
    PrintBiometricDisplay(true, GR_DEFAULT_CONTEXT);
    lastID:=ret;
  end
  else if ret = 0 then
    WriteLog('Huella no Encontrada.')
  else
    WriteLog(FloatToStr(ret));
end;

// Check a fingerprint
procedure TformMain.btVerifyClick(Sender: TObject);
var
  id: Double;
  score: Integer;
  ret: Integer;
begin
  // ask target fingerprint ID
  score := 0;
  id := StrToIntDef(InputBox('Ingrese ID a verificar', 'Verificación',''), -1);
  if id >= 0 then
  begin
    // compare fingerprints
    ret := Verify(id, score);
    // write result to the log
    if ret < 0 then
      WriteError(ret);
    if ret = GR_NOT_MATCH then
      WriteLog('NO Coincide. Puntaje = ' + IntToStr(score));
    if ret = GR_MATCH then
    begin
      WriteLog('COINCIDE!. Puntaje = ' + IntToStr(score));
      // if they match, display matching minutiae/segments/directions
      PrintBiometricDisplay(true, GR_DEFAULT_CONTEXT);
    end;
  end;
end;

// Extract a template from a fingerprint image
procedure TformMain.btExtractClick(Sender: TObject);
var
  ret: Integer;
begin
  // extract template
  ret := ExtractTemplate();
  // write template quality to log
  if (ret = GR_BAD_QUALITY)
    then writeLog('Resultado de extracción:  MALA.')
  else if (ret = GR_MEDIUM_QUALITY)
    then writeLog('Resultado de extracción:  BUENA.')
  else if (ret = GR_HIGH_QUALITY)
    then writeLog('Resultado de extracción:  EXCELENTE!.');
  if ret >= 0 then
  begin
    // if no error, display minutiae/segments/directions into the image
    PrintBiometricDisplay(true, GR_NO_CONTEXT);
    // enable operations we can do over extracted template
    //BtExtract.Enabled := false;
    btEnroll.Enabled := true;
    //btIdentify.Enabled := true;
    btVerify.Enabled := true;
  end
  else
    // write error to log
    WriteError(ret);
end;

procedure TformMain.mnInicioSalirClick(Sender: TObject);
begin
  formMain.Close;
end;

// Open "Options" window
procedure TformMain.mnOptionsClick(Sender: TObject);
var
  minutiaeColor: Integer;
  minutiaeMatchColor: Integer;
  segmentsColor: Integer;
  segmentsMatchColor: Integer;
  directionsColor: Integer;
  directionsMatchColor: Integer;
  thresholdId : Integer;
  rotationMaxId: Integer;
  thresholdVr : Integer;
  rotationMaxVr: Integer;
  ok: boolean;
  ret: integer;
begin

  while true do begin
        // get current identification/verification parameters
        GrGetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
        GrGetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
        // set current identification/verification parameters on options form
        formOptions.setParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr);

        ok := true;
        // show form with match, display and colors options
        // and get the new parameters
        if not formOptions.getParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr,
                minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor) then exit;
        if ((thresholdId < GR_MIN_THRESHOLD) or
         (thresholdId > GR_MAX_THRESHOLD) or
         (rotationMaxId < GR_ROT_MIN) or
         (rotationMaxId > GR_ROT_MAX)) then begin
            ShowMessage('Invalid identify parameters values!');
            ok := false;
        end;
        if ((thresholdVr < GR_MIN_THRESHOLD) or
         (thresholdVr > GR_MAX_THRESHOLD) or
         (rotationMaxVr < GR_ROT_MIN) or
         (rotationMaxVr > GR_ROT_MAX)) then begin
            showmessage ('Invalid verify parameters values!');
            ok := false;
        end;
        // set new identification parameters
        if ok then begin
          ret := GrSetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
          // error?
          if ret = GR_DEFAULT_USED then begin
            showmessage('Invalid identify parameters values. Default values will be used.');
            ok := false;
          end;
          // set new verification parameters
          ret := GrSetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
          // error?
          if ret = GR_DEFAULT_USED then begin
            showmessage('Invalid verify parameters values. Default values will be used.');
            ok := false;
          end;
          // if everything ok
          if ok then begin
            // accept new parameters
            formOptions.AcceptChanges();
            // set new colors
            GrSetBiometricDisplayColors(minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor);
            Exit;
          end;
        end;
  end;
end;

// Display GrFinger version
procedure TformMain.mnVersionClick(Sender: TObject);
begin
  MessageVersion();
end;

procedure TformMain.btnAsistenciaClick(Sender: TObject);
begin
  if lastID > 0 then
  with dm do
  begin
    qEnableEmp.Close;
    qEnableEmp.Parameters[0].Value:=lastID;
    try
      qEnableEmp.Open;
      if qEnableEmp.RecordCount>0 then
        begin
          {adoLog1.Open;
          adoLog1.DisableControls;
          adoLog1.First;
          adoLog1.Insert;
          adoLog1.Fields.FieldByName('fechahora').Value:=now();
          adoLog1.Fields.FieldByName('id').Value:=lastID;
          adoLog1.Fields.FieldByName('contratistaid').Value:=qEnableEmp.FieldByName('contratistaid').AsInteger;
          adoLog1.Fields.FieldByName('cuadrillaid').Value:=qEnableEmp.FieldByName('cuadrillaid').AsInteger;
          adoLog1.Fields.FieldByName('maleta01').Value:=0;
          adoLog1.Fields.FieldByName('maleta02').Value:=0;
          adoLog1.Fields.FieldByName('fecha').Value:=Date();
          adoLog1.Post;}
          newEntry.Parameters.ParamByName('timestamp').Value:=now;
          newEntry.Parameters.ParamByName('id').Value:=lastID;
          newEntry.Parameters.ParamByName('date').Value:=date;
          newEntry.Parameters.ParamByName('checkpoint').Value:='scar';
          newEntry.Parameters.ParamByName('modified_on').Value:=now;
          newEntry.Prepared:=true;
          newEntry.Execute;
          qryHits.Close;
          qryHits.Parameters[0].Value:=lastID;
          try
            qryHits.ExecSQL;
          finally
            qryHits.Close;
          end;
          sleep(350);
          //adoLog1.EnableControls;
          Entries.Requery([eoAsyncFetchNonBlocking]);
          lastID:=0;
        end;
    finally
      qEnableEmp.Close;
    end;
  end;
end;

procedure TformMain.btnManualClick(Sender: TObject);
begin
if TfrmLogin.ExecuteAdmin then
  if frmManual.ShowModal = mrOK then
    btnAsistenciaCLick(nil);
end;

procedure TformMain.ckDisplayFingerClick(Sender: TObject);
begin
  if ckDisplayFinger.Checked then
     image.Visible:=true
  else
     image.Visible:=false;
end;

procedure TformMain.mnInicioMaletasClick(Sender: TObject);
begin
  formMaletas.ShowModal;
end;

procedure TformMain.mnSincExpAsistenciasClick(Sender: TObject);
begin
  formExportTrx.ShowModal;
end;

procedure TformMain.ckAutoAsistenciaClick(Sender: TObject);
begin
  if not ckAutoAsistencia.Checked then
  begin
    lastQad:=0;
    //btnAsistencia.Enabled:=true;
  end
  else
  begin
    //formCambiaQad.ShowModal;
    //btnAsistencia.Enabled:=false;
  end;
end;

procedure TformMain.Acercade1Click(Sender: TObject);
begin
  formAcercade.ShowModal;
end;

procedure TformMain.mnSincPersonasClick(Sender: TObject);
begin
  formSincro.ShowModal;
end;

procedure TformMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F3 then
    btEnroll.Click;
end;

procedure TformMain.MigrarDB1Click(Sender: TObject);
begin
  frmMigrator.ShowModal;
end;

procedure TformMain.mnInicioCuadrillasClick(Sender: TObject);
begin
  formCuadrillas.ShowModal;
end;

procedure TformMain.mnuInicioContratistasClick(Sender: TObject);
begin
  formContratistas.ShowModal;
end;

procedure TformMain.mnuInicioUsuariosClick(Sender: TObject);
begin
  frmUsers.ShowModal;
end;

procedure TformMain.mnuToolsImportClick(Sender: TObject);
begin
frmImport.ShowModal;
end;

procedure TformMain.mnSincImpPersonalClick(Sender: TObject);
begin
  formImportar.ShowModal;
end;

procedure TformMain.btnSalirClick(Sender: TObject);
begin
  Close;
end;

end.
