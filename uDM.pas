unit uDM;

interface

uses
  SysUtils, Classes, DB, ADODB, DBClient, Provider;

type
  Tdm = class(TDataModule)
    adoCnx: TADOConnection;
    adoCon: TADOQuery;
    adoBag: TADOQuery;
    adoBagApeNom: TStringField;
    adoBagcuadrillaid: TIntegerField;
    adoBagid: TFloatField;
    adoBagmaleta01: TIntegerField;
    adoBagmaleta02: TIntegerField;
    dsCon: TDataSource;
    adoPer: TADOQuery;
    adoQad: TADOQuery;
    adoQadid: TAutoIncField;
    adoQadcontratistaid: TIntegerField;
    adoQadcuadrilla: TWideStringField;
    adoLog1: TADOTable;
    adoLog1fechahora: TDateTimeField;
    adoLog1ID: TFloatField;
    adoLog1apenom: TStringField;
    adoLog1ContratistaID: TIntegerField;
    adoLog1CuadrillaID: TIntegerField;
    adoLog1Maleta01: TIntegerField;
    adoLog1Maleta02: TIntegerField;
    adoLog1fecha: TDateTimeField;
    adoPer1: TADOTable;
    dsLog: TDataSource;
    qryLogin: TADOQuery;
    tblUsers: TADOTable;
    adoPer1ApeNom: TStringField;
    adoPer1apellido: TWideStringField;
    adoPer1nombre: TWideStringField;
    qryPersonas: TADOQuery;
    qryHabilitados: TADOQuery;
    qryHits: TADOQuery;
    adoPer1ID: TFloatField;
    adoPer1template: TBlobField;
    adoPer1fecha: TDateTimeField;
    adoPer1habilitado: TWordField;
    adoPer1contratistaid: TIntegerField;
    adoPer1cuadrillaid: TIntegerField;
    adoPer1hits: TIntegerField;
    qryManual: TADOQuery;
    tblUsersUsername: TWideStringField;
    tblUsersPassword: TWideStringField;
    tblUsersUserType: TIntegerField;
    qryPerGral: TADOQuery;
    qryImport: TADOQuery;
    dsImport: TDataSource;
    qryAsis: TADOQuery;
    qryQuad: TADOQuery;
    dsQuad: TDataSource;
    tblJrn: TADOTable;
    dsJrn: TDataSource;
    qryQad: TADOQuery;
    dsQad: TDataSource;
    tblJrnmaleta0: TIntegerField;
    tblJrnmaleta1: TIntegerField;
    tblJrnjornal: TIntegerField;
    qryGralPer: TADOQuery;
    tblJrnfecha: TDateTimeField;
    tblJrngrupo: TIntegerField;
    tblJrnid: TFloatField;
    tblJrnapenom: TStringField;
    qryJrn: TADOQuery;
    dtsJrn: TADODataSet;
    cmdJrn: TADOCommand;
    qryJrnEx: TADOQuery;
    qryAsisToday: TADOQuery;
    Employees: TADOTable;
    Entries: TADOQuery;
    dsEntries: TDataSource;
    newEntry: TADOCommand;
    qDepts: TADOQuery;
    dsDepts: TDataSource;
    qPayrolls: TADOQuery;
    dsPayrolls: TDataSource;
    newPayroll: TADOCommand;
    dsEmployees: TDataSource;
    qEmployees: TADOQuery;
    qEnableEmp: TADOQuery;
    dsEmp: TDataSource;
    Departments: TADOTable;
    dsDepartments: TDataSource;
    cmdXport: TADODataSet;
    cmdImport: TADODataSet;
    cmdAux: TADODataSet;
    BioFingers: TADOTable;
    Payrolls: TADOTable;
    Entries1: TADOTable;
    procedure adoLog1CalcFields(DataSet: TDataSet);
    procedure adoPer1CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure dsJrnStateChange(Sender: TObject);
    procedure DepartmentsBeforePost(DataSet: TDataSet);
    procedure EmployeesBeforePost(DataSet: TDataSet);
    procedure tblUsersBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    ScarDBPath: string;
  public
    { Public declarations }
    const
      ScarDBName = {$IFNDEF DEBUG}'Scar.mdb'{$ELSE} 'Scar0.mdb' {$ENDIF};
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

procedure Tdm.adoLog1CalcFields(DataSet: TDataSet);
begin
  qryPersonas.Close;
  qryPersonas.Parameters[0].Value:=adoLog1ID.Value;
  try
    qryPersonas.Open;
    if qryPersonas.RecordCOunt>0 then
      adoLog1apenom.Value:=qryPersonas.Fields.Fields[0].AsString
    else
      adoLog1apenom.Value:='<Desconocido>';
  finally
    qryPersonas.Close;
  end;
end;

procedure Tdm.adoPer1CalcFields(DataSet: TDataSet);
begin
  adoPer1ApeNom.Value:=trim(adoPer1Apellido.Value)+' '+adoPer1Nombre.Value;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  ScarDBPath:=SysUtils.GetCurrentDir+'\';
  adoCnx.Close;
  adoCnx.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+ScarDBPath+ScarDBName+';Mode=Share Deny None;';
end;

procedure Tdm.DepartmentsBeforePost(DataSet: TDataSet);
begin
  dm.Departments.FieldByName('modified_on').Value:=now;
end;

procedure Tdm.dsJrnStateChange(Sender: TObject);
begin
  if dsJrn.State = dsInsert then
    dsJrn.DataSet.Cancel;
end;

procedure Tdm.EmployeesBeforePost(DataSet: TDataSet);
begin
  if Employees.State = dsInsert then
    Employees.FieldByName('created_on').Value:=now
  else
    Employees.FieldByName('modified_on').Value:=now;
end;

procedure Tdm.tblUsersBeforePost(DataSet: TDataSet);
begin
  dm.tblUsers.FieldByName('modified_on').Value:=now;
end;

end.
