program SCARMigrator;

uses
  Forms,
  fMigrator in 'fMigrator.pas' {frmMigrator};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMigrator, frmMigrator);
  Application.Run;
end.
