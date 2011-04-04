program SCARUpdate;

uses
  Forms,
  fSCARUpdate in 'fSCARUpdate.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCAR Update';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
