unit fMigrator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, ExtCtrls, ComCtrls, StdCtrls, Buttons, Mask, rxToolEdit;

type
  TfrmMigrator = class(TForm)
    Panel1: TPanel;
    adoCnx: TADOConnection;
    adoCmd: TADOCommand;
    StatusBar1: TStatusBar;
    btnMigrate: TBitBtn;
    BitBtn2: TBitBtn;
    fedSource: TFilenameEdit;
    pgbProcess: TProgressBar;
    labMigrate: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMigrateClick(Sender: TObject);
    procedure adoCnxAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure Migrate;
    procedure CopyRecord(Src, Dst: TDataSet);
  public
    { Public declarations }
    paramValid: boolean;
    dsScar: string;
  end;

var
  frmMigrator: TfrmMigrator;

implementation

uses uDM;

{$R *.dfm}

procedure TfrmMigrator.adoCnxAfterConnect(Sender: TObject);
begin
  if adoCnx.Connected then StatusBar1.SimpleText:='Conectado'
  else StatusBar1.SimpleText:='No Conectado';
end;

procedure TfrmMigrator.btnMigrateClick(Sender: TObject);
begin
  if FileExists(fedSource.Text) then
    if MessageDlg('Esta operacion va a copiar la informacion de una base de datos antigua a esta.'+
                  Chr(13)+Chr(10)+'Realice esta operacion solo una vez.'
                  ,mtWarning, mbOKCancel, 0) = mrOk then
    begin
      btnMigrate.Enabled:=false;
      btnMigrate.Enabled:=false;
      dsScar:=fedSource.Text;
      labMigrate.Visible:=true;
      Migrate;
      btnMigrate.Enabled:=true;
    end;
end;

procedure TfrmMigrator.CopyRecord(Src, Dst: TDataSet);
var I:integer;
    SField, DField: TField;
begin
  for I:=0 to Src.FieldCount - 1 do
   begin
     SField := Src.Fields[ I ];
     DField := Dst.FindField( SField.FieldName );
     if (DField <> nil) and (DField.FieldKind = fkData) and
        not DField.ReadOnly then
        if (SField.DataType = ftString) or
           (SField.DataType <> DField.DataType) then
           DField.AsString := SField.AsString
        else
           DField.Assign( SField )
   end;
end;
procedure TfrmMigrator.FormCreate(Sender: TObject);
begin
  paramValid:=True;
  if ParamCount>0 then
  begin
    dsScar:=ParamStr(1);
    if FileExists(dsScar) then
      adoCnx.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+dsSCAR+';Persist Security Info=False;'
    else
      paramValid:=false;
  end
  else
    paramValid:=false;
end;

procedure TfrmMigrator.FormShow(Sender: TObject);
begin
  if not paramValid then
    StatusBar1.SimpleText:='No conectado'
  else
  begin
    dm.adoCnx.Connected:=true;
    StatusBar1.SimpleText:='Conectado';
    fedSource.Text:=dsScar;
    Migrate;
  end;
end;

procedure TfrmMigrator.Migrate;
var
  qBio, qEmp, qQad, qLog, qPay: TADOQuery;
  slBio, slEmp, slQad, slLog, slPay: TStringlist;
  tables: TStringlist;
  i: integer;
begin
  slBio:=TStringList.Create;
  slEmp:=TStringList.Create;
  slQad:=TStringList.Create;
  slLog:=TStringList.Create;
  slPay:=TStringList.Create;

  adoCnx.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+dsSCAR+';Persist Security Info=False;';
  adoCnx.Connected:=true;

  labMigrate.Caption:='Migrando Huellas...';
  Application.ProcessMessages;
  //slBio.Add('INSERT INTO BioFingers ( ID, template, hits, modified_on, modified_by )');
  slBio.Add('SELECT enroll.ID, enroll.template, enroll.hits, now() as modon, "pmoreno" as modby');
  slBio.Add('FROM enroll');
  qBio:=TADOQuery.Create(nil);
  qBio.Connection:=adoCnx;
  qBio.SQL.AddStrings(slBio);
  qBio.Open;
  qBio.First;
  pgbProcess.Max:=qBio.RecordCount;
  pgbProcess.Position:=0;
  pgbProcess.StepIt;
  dm.BioFingers.Open;
  while not qbio.eof do
  begin
    with qbio, dm do
    begin
      BioFingers.Insert;
      BioFingers.FieldByName('id').Value:=FieldByName('id').Value;
      BioFingers.FieldByName('hits').Value:=FieldByName('hits').Value;
      BioFingers.FieldByName('template').Value:=FieldByName('template').Value;
      BioFingers.FieldByName('modified_on').Value:=Now;
      BioFingers.FieldByName('modified_by').Value:='migrator';
      BioFingers.Post;
      Next;
      pgbProcess.Position:=pgbProcess.Position+1;
    end;
  end;

  labMigrate.Caption:='Migrando Personas...';
  Application.ProcessMessages;
  //slEmp.Add('INSERT INTO Persons ( ID, lastname, firstname, enabled, [group], modified_on, modified_by )');
  slEmp.Add('SELECT enroll.ID, enroll.apellido, enroll.nombre, enroll.habilitado, cuadrillas.Cuadrilla, enroll.fecha, "pmoreno" AS modby');
  slEmp.Add('FROM (enroll INNER JOIN cuadrillas ON enroll.cuadrillaid = cuadrillas.ID) INNER JOIN contratistas ON enroll.contratistaid = contratistas.ID');
  qEmp:=TADOQuery.Create(nil);
  qEmp.Connection:=adoCnx;
  qEmp.SQL.AddStrings(slEmp);
  qEmp.Open;
  qEmp.First;
  pgbProcess.Max:=qEmp.RecordCount;
  pgbProcess.Position:=0;
  dm.Employees.Open;
  while not qEmp.eof do
  begin
    with qEmp, dm do
    begin
      Employees.Insert;
      Employees.FieldByName('id').Value:=FieldByName('id').Value;
      Employees.FieldByName('lastname').Value:=FieldByName('apellido').Value;
      Employees.FieldByName('firstname').Value:=FieldByName('nombre').Value;
      Employees.FieldByName('enabled').Value:=FieldByName('habilitado').Value;
      Employees.FieldByName('dept').Value:=FieldByName('cuadrilla').Value;
      Employees.FieldByName('modified_on').Value:=Now;
      Employees.FieldByName('modified_by').Value:='migrator';
      Employees.Post;
      Next;
      pgbProcess.StepIt;
    end;
  end;

  labMigrate.Caption:='Migrando Cuadrillas/Contratistas...';
  Application.ProcessMessages;
  //slQad.Add('INSERT INTO Departments ( name, groupname, modified_on, modified_by )');
  slQad.Add('SELECT cuadrillas.Cuadrilla, contratistas.Contratista as contratista, now() as modon, "pmoreno" as modby');
  slQad.Add('FROM contratistas INNER JOIN cuadrillas ON contratistas.ID = cuadrillas.ContratistaID');
  qQad:=TADOQuery.Create(nil);
  qQad.Connection:=adoCnx;
  qQad.SQL.AddStrings(slQad);
  qQad.Open;
  qQad.First;
  pgbProcess.Max:=qQad.RecordCount;
  pgbProcess.Position:=0;
  dm.Departments.Open;
  while not qQad.eof do
  begin
    with qQad, dm do
    begin
      Departments.Insert;
      Departments.FieldByName('name').Value:=FieldByName('cuadrilla').Value;
      Departments.FieldByName('groupname').Value:=FieldByName('contratista').Value;
      Departments.FieldByName('modified_on').Value:=Now;
      Departments.FieldByName('modified_by').Value:='migrator';
      Departments.Post;
      Next;
      pgbProcess.StepIt;
    end;
  end;

  labMigrate.Caption:='Migrando Entradas...';
  Application.ProcessMessages;
  //slLog.Add('INSERT INTO Entries ( [timestamp], ID, [date], modified_on, modified_by )');
  slLog.Add('SELECT asistencias.fechahora, asistencias.ID, asistencias.fecha, now() as modon, "pmoreno" as modby');
  slLog.Add('FROM (asistencias INNER JOIN contratistas ON asistencias.ContratistaID = contratistas.ID) INNER JOIN cuadrillas ON asistencias.CuadrillaID = cuadrillas.ID');
  qLog:=TADOQuery.Create(nil);
  qLog.Connection:=adoCnx;
  qLog.SQL.AddStrings(slLog);
  qLog.Open;
  qLog.First;
  pgbProcess.Max:=qLog.RecordCount;
  pgbProcess.Position:=0;
  dm.Entries1.Open;
  while not qLog.eof do
  begin
    with qLog, dm do
    begin
      Entries1.Insert;
      Entries1.FieldByName('timestamp').Value:=FieldByName('fechahora').Value;
      Entries1.FieldByName('id').Value:=FieldByName('id').Value;
      Entries1.FieldByName('date').Value:=FieldByName('fecha').Value;
      Entries1.FieldByName('modified_on').Value:=Now;
      Entries1.FieldByName('modified_by').Value:='migrator';
      Entries1.Post;
      Next;
      pgbProcess.StepIt;
    end;
  end;

  labMigrate.Caption:='Migrando Asistencias...';
  Application.ProcessMessages;
  //slPay.Add('INSERT INTO Payrolls ( Fecha, id, dept, deduction1, deduction2, amountpaid, modified_on, modified_by )');
  slPay.Add('SELECT jornales.fecha, jornales.id, cuadrillas.Cuadrilla, Sum(jornales.maleta0) AS maleta0, Sum(jornales.maleta1) AS maleta1, Sum(jornales.jornal) AS jornal');
  slPay.Add('FROM jornales INNER JOIN cuadrillas ON jornales.grupo = cuadrillas.ID');
  slPay.Add('GROUP BY jornales.fecha, jornales.id, cuadrillas.Cuadrilla');
  qPay:=TADOQuery.Create(nil);
  qPay.Connection:=adoCnx;
  qPay.SQL.AddStrings(slPay);
  qPay.Open;
  qPay.First;
  pgbProcess.Max:=qPay.RecordCount;
  pgbProcess.Position:=0;
  dm.Payrolls.Open;
  while not qPay.eof do
  begin
    with qPay, dm do
    begin
      Payrolls.Insert;
      Payrolls.FieldByName('id').Value:=FieldByName('id').Value;
      Payrolls.FieldByName('date').Value:=FieldByName('fecha').Value;
      Payrolls.FieldByName('dept').Value:=FieldByName('cuadrilla').Value;
      Payrolls.FieldByName('deduction1').Value:=FieldByName('maleta0').Value;
      Payrolls.FieldByName('deduction2').Value:=FieldByName('maleta1').Value;
      Payrolls.FieldByName('amountpaid').Value:=FieldByName('jornal').Value;
      Payrolls.FieldByName('modified_on').Value:=Now;
      Payrolls.FieldByName('modified_by').Value:='migrator';
      try
        Payrolls.Post;
      except
        Payrolls.Cancel;
        ShowMessage(FieldByName('id').AsString+' '+FieldByName('fecha').AsString+' '+FieldByName('cuadrilla').AsString);
      end;
      Next;
      pgbProcess.StepIt;
    end;
  end;
  labMigrate.Caption:='Proceso Finalizado';

  qBio.Free;
  qEmp.Free;
  qQad.Free;
  qLog.Free;
  qPay.Free;



  {labMigrate.Visible:=true;
  adoSrc:=nil;
  adoDst:=nil;
  try
    adoCnx.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+dsSCAR+';Persist Security Info=False;';
    adoCnx.Connected:=true;
    dm.adoCnx.Connected:=true;
    for I := 0 to tables.Count - 1 do
      begin
        labMigrate.Caption:='Migrando tabla '+tables[i]+'...';
        try
          adoSrc:=TADOTable.Create(self);
          adoSrc.Connection:=adoCnx;
          adosrc.TableName:=tables[i];
          adoDst:=TADOTable.Create(self);
          adoDst.Connection:=dm.adoCnx;
          adoDst.TableName:=tables[i];
          try
            adoSrc.Open;
            pgbProcess.Max:=adoSrc.RecordCount;
            adoDst.Open;
            while not adoSrc.Eof do
            begin
              adoDst.Append;
              CopyRecord(adoSrc,adoDst);
              try
                adoDst.Post;
              except
                adoDst.Cancel;
                StatusBar1.SimpleText:='Error al migrar datos, posiblemente duplicacion de claves';
              end;
              adoSrc.Next;
              pgbProcess.StepIt;
            end;
          finally
            adoCnx.Connected:=false;
            //adoCnxNew.Connected:=false;
          end;
        finally
          adoSrc.Free;
          adoDst.Free;
        end;
        pgbProcess.Position:=0;
      end;
  except
    StatusBar1.SimpleText:='Error conectando Base de Datos';
  end;}
end;

end.
