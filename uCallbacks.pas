{
 -------------------------------------------------------------------------------
 Sistema de Asistencia del Personal Rural
 (c) 2008 ARXyS
 http://www.arxys.com.ar
 -------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------
// Callback routines
// -----------------------------------------------------------------------------------

unit uCallbacks;

interface

uses GrFinger;

procedure StatusCallback(idSensor: Pchar; event: GRCAP_STATUS_EVENTS); stdcall;
procedure FingerCallback(idSensor: Pchar; event: GRCAP_FINGER_EVENTS); stdcall;
Procedure ImageCallback(idSensor: PChar; imageWidth: Integer; imageHeight: Integer; rawImage: PChar; res: Integer); stdcall;
function InitializeGrCap():Integer;

implementation

uses uMain, uUtil, SysUtils;

// Initialize capture library
function InitializeGrCap():Integer;
begin
  // Initializing GrCapture. Passing adress of the "StatusCallback" sub.
  InitializeGrCap := GrCapInitialize(@StatusCallback);
end;

// This sub is called evertime an status event is raised.
Procedure StatusCallback(idSensor: Pchar; event: GRCAP_STATUS_EVENTS); stdcall;
begin
  sleep(200);
  // Signals that a status event ocurred.
  WriteEvent(idSensor, event);
  // Checking if event raised is a plug or unplug.
  if (event = GR_PLUG) then
    // Start capturing from plugged sensor.
    GrCapStartCapture(idSensor, @FingerCallback, @ImageCallback)
  else if (event = GR_UNPLUG) then
    // Stop capturing from unplugged sensor.
    GrCapStopCapture(idSensor);
end;

// This Function is called every time a finger is placed or removed from sensor.
Procedure FingerCallback(idSensor: Pchar; event: GRCAP_FINGER_EVENTS); stdcall;
Begin
  // Just signals that a finger event ocurred.
  WriteEvent(idSensor, event);
  Sleep(200);
End;

// This function is called every time a finger image is captured
Procedure ImageCallback(idSensor: PChar; imageWidth: Integer; imageHeight: Integer; rawImage: PChar; res: Integer); stdcall;
Begin
  // Copying aquired image
  raw.height := imageHeight;
  raw.width := imageWidth;
  raw.res := res;
  Move(rawImage^, raw.img^, imageWidth*imageHeight);

  // Signaling that an Image Event occurred.
  WriteEvent(idSensor, GR_IMAGE);

  // Display fingerprint image
  PrintBiometricDisplay(false, GR_DEFAULT_CONTEXT);

  // now we have a fingerprint, so we can extract template
  formMain.btEnroll.Enabled := false;
  //formMain.btExtract.Enabled := true;
  //formMain.btIdentify.Enabled := false;
  formMain.btVerify.Enabled := false;

  // extracting template from image.
  if formMain.ckAutoExtract.Checked then
  Begin
      formMain.btExtractClick(nil);
        // identify fingerprint
        if formMain.ckBoxAutoIdentify.Checked then
          begin
          formMain.btIdentifyClick(nil);
          if formMain.ckAutoAsistencia.Checked then
            formMain.btnAsistenciaClick(nil);
          end

  End;
{  else
      formMain.btExtract.Enabled := true;
 }
end;

end.
