{
 -------------------------------------------------------------------------------
 Sistema de Asistencia del Personal Rural
 (c) 2008 ARXyS
 http://www.arxys.com.ar
 -------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------
// Database routines
// -----------------------------------------------------------------------------------

unit uDBClass;

interface

uses
  ADODB, DB, classes, SysUtils, GrFinger, uDM;

const
  // the database we'll be connecting to
  DBFile = 'SCAR.mdb';
  ConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + DBFile;
  EnrollTableName = 'BioFingers';

type
  // Class TTemplate
  // Define a type to temporary storage of template
  TTemplate = class
    public
      // Template data.
      tpt:        Pchar;
      // Template size
      size:       Integer;
      // Template ID (if retrieved from DB)
      //id:         Integer;
      id:         Double;

      // Allocates space to template
      constructor Create;
      // clean-up
      destructor Destroy; override;
  end;

  TDBClass = class
  private
    // a data set to mantain all templates of database
    dsTemplates: TADODataSet;
    // the connection object
    connection: TADOConnection;
    // Template object used to get a template from database.
    tptBlob: TTemplate;
  public
    function openDB(): boolean;
    procedure closeDB();
    procedure clearDB();
    function addTemplate(template: TTemplate): Double;
    procedure updateTemplate(template: TTemplate;var id: Double);
    procedure getTemplates();
    function getTemplate(id: Double) : TTemplate;
    function getNextTemplate(): TTemplate;

  end;

implementation

// Default constructor
constructor TTemplate.Create();
begin
  // Allocate memory for template and initialize its size to 0
  tpt := AllocMem(GR_MAX_SIZE_TEMPLATE);
  size := 0;
end;

// Default destructor
destructor TTemplate.Destroy();
begin
  // free resources
  FreeMemory(tpt);
end;

// Open connection
function TDBClass.openDB(): boolean;
begin
  try
        dsTemplates := TADODataSet.Create(nil);
        tptBlob := TTemplate.Create();
        openDB := true;
  except
        openDB := false;
  end;
end;

// Close conection
procedure TDBClass.closeDB();
begin
  dsTemplates.Close();
  dsTemplates.Free();
  tptBlob.Free();
end;

// Clear database
procedure TDBClass.clearDB();
begin
  // run "clear" query
  connection.Execute('DELETE FROM enroll');
end;

// Update template into database record.
procedure TDBClass.updateTemplate(template: TTemplate;var id: Double);
var
  rs: TADOTable;
  tptStream: TMemoryStream;
//  id: Integer;
begin
  // get DB data and append one row
  rs := TADOTable.Create(nil);
  rs.Connection := dm.adoCnx; //connection;
  rs.TableName := EnrollTableName;
  rs.Open;
  if rs.Locate('id',id,[]) then
  begin
    tptStream := TMemoryStream.Create();
    // write template data to memory stream.
    tptStream.write(template.tpt^, template.size);
    // save template data from memory stream to database.
    rs.Edit;
    try
      (rs.FieldByName('template') as  TBlobField).LoadFromStream(tptStream);
    finally
      tptStream.Free;
    end;
    // update database with added template.
    rs.FieldByName('ID').Value:= id;
    if length(rs.FieldByName('template').AsString)>0 then
      rs.Post
    else
      begin
        rs.Cancel;
        //WriteLog('Error al cargar huella. Repita operación.');
        id:=-10;
      end;
  end
  else
   //WriteLog('No se encontró ID. repita operación.');
   id:=-20;
  // close connection
  rs.Close;
  rs.Free;
end;

// Add template to database. Returns added template ID.
function TDBClass.addTemplate(template: TTemplate): Double;
var
  rs: TADODataSet;
  tptStream: TMemoryStream;
  id: Integer;
begin
  // get DB data and append one row
  rs := TADODataSet.Create(nil);
  rs.Connection := dm.adoCnx;//connection;
  rs.CursorType := ctStatic;
  rs.LockType := ltOptimistic;
  rs.CommandText := 'SELECT * FROM '+EnrollTableName;
  rs.Open();
  rs.Append();
  tptStream := TMemoryStream.Create();
  // write template data to memory stream.
  tptStream.write(template.tpt^, template.size);
  // save template data from memory stream to database.
  (rs.FieldByName('template') as  TBlobField).LoadFromStream(tptStream);
  // update database with added template.
  rs.post();
  // get the ID of enrolled template.
  //id := rs.FieldByName('ID').AsInteger;
  id := rs.FieldByName('ID').AsVariant;
  // close connection
  tptStream.Free();
  rs.Close();
  rs.Free();
  addTemplate := id;
end;

// Start fetching all enrolled templates from database.
procedure TDBClass.getTemplates();
begin
  dsTemplates.Close;
  dsTemplates.CacheSize := 15000;
  dsTemplates.CursorLocation := clUseClient;
  dsTemplates.CursorType := ctOpenForwardOnly;
  dsTemplates.LockType := ltReadOnly;
  dsTemplates.Connection := dm.adoCnx; //connection;
  dsTemplates.CommandText := 'SELECT * FROM '+ EnrollTableName+' ORDER BY hits DESC';
  dsTemplates.Open;
  dsTemplates.BlockReadSize := 15000;
end;

// Returns template with supplied ID.
function TDBClass.getTemplate(id: Double): TTemplate;
Var
  template: TTemplate;
begin
  dsTemplates.Close;
  dsTemplates.Connection := dm.adoCnx; //connection;
  dsTemplates.CursorType := ctDynamic;
  dsTemplates.LockType := ltReadOnly;
  dsTemplates.CommandText := 'SELECT * FROM '+EnrollTableName+' WHERE ID = ' + FloatToStr(id);
  // Get query response
  dsTemplates.Open;
  // Deserialize template and return it
  template := getNextTemplate;
  dsTemplates.Close;
  getTemplate := template;
end;

// Return next template from dataset
function TDBClass.getNextTemplate(): TTemplate;
Var
  tmp: String;
begin
  // No results?
  if dsTemplates.Eof then
  begin
    tptBlob.size := -1;
    getNextTemplate := tptBlob;
  end else
  begin
    // Get template ID from database
    //tptBlob.id := dsTemplates.FieldByName('ID').AsInteger;
    tptBlob.id := dsTemplates.FieldByName('ID').AsFloat;
    // Get template data from database as string.
    tmp := dsTemplates.FieldByName('template').AsString;
    // Get template size from database.
    tptBlob.size := length(tmp);
    // Move template data from temporary string
    // to template object.
    Move(PChar(tmp)^, tptBlob.tpt^, tptBlob.size);
    // move foward in the list of templates
    dsTemplates.Next();
    getNextTemplate := tptBlob;
  end;
end;

end.
