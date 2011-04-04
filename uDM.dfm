object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 473
  Width = 733
  object adoCnx: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 16
  end
  object adoCon: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'fecha'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '13/05/2009'
      end>
    SQL.Strings = (
      
        'SELECT a.cuadrillaid, q.cuadrilla, a.fecha, e.id, ([e].[apellido' +
        ']+" "+[e].[nombre]) AS ApeNom'
      
        'FROM (asistencias AS a INNER JOIN cuadrillas AS q ON a.cuadrilla' +
        'id = q.id) INNER JOIN enroll AS e ON a.ID = e.ID'
      'WHERE a.fecha=:fecha'
      
        'GROUP BY a.cuadrillaid, q.cuadrilla, a.fecha, e.id, ([e].[apelli' +
        'do]+" "+[e].[nombre]);')
    Left = 280
    Top = 40
  end
  object adoBag: TADOQuery
    CursorType = ctStatic
    DataSource = dsCon
    Parameters = <
      item
        Name = 'fecha'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '01/04/2008'
      end>
    Prepared = True
    SQL.Strings = (
      'SELECT a.cuadrillaid, q.cuadrilla, a.fecha'
      'FROM asistencias a inner join cuadrillas q on a.cuadrillaid=q.id'
      'WHERE a.fecha=:fecha'
      'GROUP BY a.cuadrillaid, q.cuadrilla, a.fecha')
    Left = 280
    Top = 104
    object adoBagApeNom: TStringField
      FieldKind = fkLookup
      FieldName = 'ApeNom'
      LookupDataSet = adoPer
      LookupKeyFields = 'id'
      LookupResultField = 'ApeNom'
      KeyFields = 'id'
      Size = 50
      Lookup = True
    end
    object adoBagcuadrillaid: TIntegerField
      FieldName = 'cuadrillaid'
    end
    object adoBagid: TFloatField
      FieldName = 'id'
    end
    object adoBagmaleta01: TIntegerField
      FieldName = 'maleta01'
    end
    object adoBagmaleta02: TIntegerField
      FieldName = 'maleta02'
    end
  end
  object dsCon: TDataSource
    DataSet = adoCon
    Left = 320
    Top = 40
  end
  object adoPer: TADOQuery
    CursorType = ctStatic
    DataSource = dsCon
    Parameters = <
      item
        Name = 'fecha'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 255
        Precision = 255
        Value = Null
      end
      item
        Name = 'cuadrillaid'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      
        'select e.id, trim(e.apellido)+" "+trim(e.nombre) as apenom, e.cu' +
        'adrillaid,'
      
        ' (select count(id) from asistencias where fecha=:fecha and id=e.' +
        'id group by id) as asi'
      'from enroll e'
      'where e.habilitado=1 and e.cuadrillaid=:cuadrillaid'
      'order by 2')
    Left = 280
    Top = 160
  end
  object adoQad: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select id,contratistaid,cuadrilla from cuadrillas')
    Left = 84
    Top = 48
    object adoQadid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object adoQadcontratistaid: TIntegerField
      FieldName = 'contratistaid'
    end
    object adoQadcuadrilla: TWideStringField
      FieldName = 'cuadrilla'
      Size = 30
    end
  end
  object adoLog1: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    Filtered = True
    OnCalcFields = adoLog1CalcFields
    TableName = 'asistencias'
    Left = 84
    Top = 96
    object adoLog1fechahora: TDateTimeField
      FieldName = 'fechahora'
    end
    object adoLog1ID: TFloatField
      FieldName = 'ID'
    end
    object adoLog1apenom: TStringField
      FieldKind = fkCalculated
      FieldName = 'apenom'
      LookupKeyFields = 'id'
      LookupResultField = 'apenom'
      KeyFields = 'id'
      Size = 50
      Calculated = True
    end
    object adoLog1ContratistaID: TIntegerField
      FieldName = 'ContratistaID'
    end
    object adoLog1CuadrillaID: TIntegerField
      FieldName = 'CuadrillaID'
    end
    object adoLog1Maleta01: TIntegerField
      FieldName = 'Maleta01'
    end
    object adoLog1Maleta02: TIntegerField
      FieldName = 'Maleta02'
    end
    object adoLog1fecha: TDateTimeField
      FieldName = 'fecha'
    end
  end
  object adoPer1: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    OnCalcFields = adoPer1CalcFields
    TableName = 'enroll'
    Left = 84
    Top = 152
    object adoPer1ApeNom: TStringField
      FieldKind = fkCalculated
      FieldName = 'ApeNom'
      Size = 150
      Calculated = True
    end
    object adoPer1apellido: TWideStringField
      FieldName = 'apellido'
      Size = 35
    end
    object adoPer1nombre: TWideStringField
      FieldName = 'nombre'
      Size = 50
    end
    object adoPer1ID: TFloatField
      FieldName = 'ID'
    end
    object adoPer1template: TBlobField
      FieldName = 'template'
    end
    object adoPer1fecha: TDateTimeField
      FieldName = 'fecha'
    end
    object adoPer1habilitado: TWordField
      FieldName = 'habilitado'
    end
    object adoPer1contratistaid: TIntegerField
      FieldName = 'contratistaid'
    end
    object adoPer1cuadrillaid: TIntegerField
      FieldName = 'cuadrillaid'
    end
    object adoPer1hits: TIntegerField
      FieldName = 'hits'
    end
  end
  object dsLog: TDataSource
    AutoEdit = False
    DataSet = adoLog1
    Left = 144
    Top = 42
  end
  object qryLogin: TADOQuery
    Connection = adoCnx
    Parameters = <
      item
        Name = 'username'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'password'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'usertype'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '0'
      end>
    SQL.Strings = (
      'Select *'
      'From Usuarios'
      'where Username = :username'
      'and Password = :password'
      'and UserType > :usertype')
    Left = 440
    Top = 24
  end
  object tblUsers: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    BeforePost = tblUsersBeforePost
    TableName = 'Usuarios'
    Left = 440
    Top = 80
    object tblUsersUsername: TWideStringField
      FieldName = 'Username'
      Size = 255
    end
    object tblUsersPassword: TWideStringField
      FieldName = 'Password'
      Size = 255
    end
    object tblUsersUserType: TIntegerField
      FieldName = 'UserType'
    end
  end
  object qryPersonas: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'Select trim(Apellido)+" "+trim(Nombre)'
      'From Enroll'
      'Where id = :id')
    Left = 152
    Top = 96
  end
  object qryHabilitados: TADOQuery
    Connection = adoCnx
    Parameters = <
      item
        Name = 'id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      
        'Select trim(Apellido)+" "+trim(Nombre), contratistaid, cuadrilla' +
        'id'
      'From Enroll'
      'Where id = :id'
      'and habilitado = true')
    Left = 152
    Top = 152
  end
  object qryHits: TADOQuery
    Connection = adoCnx
    Parameters = <
      item
        Name = 'id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'Update Enroll'
      'Set Hits = Hits + 1'
      'Where id = :id'
      '')
    Left = 152
    Top = 200
  end
  object qryManual: TADOQuery
    Connection = adoCnx
    Parameters = <
      item
        Name = 'param0'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'Select (Apellido+" "+Nombre) as Apellido_Nombre, id as ID_CUIL'
      'From Enroll'
      'Where (Apellido+" "+Nombre) Like :param0'
      'Order By (Apellido+" "+Nombre)')
    Left = 24
    Top = 96
  end
  object qryPerGral: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'fecha1'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '26/02/2010'
      end
      item
        Name = 'fecha2'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '26/02/2010'
      end>
    Prepared = True
    SQL.Strings = (
      'Select *'
      'From Enroll'
      'Where fecha between :fecha1 and :fecha2')
    Left = 440
    Top = 200
  end
  object qryImport: TADOQuery
    Connection = adoCnx
    Parameters = <>
    Left = 304
    Top = 216
  end
  object dsImport: TDataSource
    DataSet = qryImport
    Left = 360
    Top = 216
  end
  object qryAsis: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    DataSource = dsQuad
    Parameters = <
      item
        Name = 'fecha1'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'fecha2'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'cuadrillaid'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT DISTINCT a.id, e.apellido+'#39' '#39'+e.nombre as apenom, a.cuadr' +
        'illaid, a.fecha'
      'FROM asistencias a LEFT JOIN enroll e ON a.id=e.id'
      'WHERE a.fecha BETWEEN :fecha1 AND :fecha2'
      'AND a.cuadrillaid=:cuadrillaid'
      'ORDER BY a.fecha, 2'
      ''
      '')
    Left = 536
    Top = 24
  end
  object qryQuad: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'fecha1'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'fecha2'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT DISTINCT a.fecha, q.cuadrilla, a.cuadrillaid'
      'FROM asistencias a LEFT JOIN cuadrillas q ON a.cuadrillaid=q.id'
      'WHERE a.fecha BETWEEN :fecha1 AND :fecha2'
      ''
      ''
      '')
    Left = 536
    Top = 80
  end
  object dsQuad: TDataSource
    DataSet = qryQuad
    Left = 592
    Top = 80
  end
  object tblJrn: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    IndexFieldNames = 'fecha;grupo'
    MasterFields = 'fecha;grupo'
    MasterSource = dsQad
    TableName = 'jornales'
    Left = 592
    Top = 152
    object tblJrnmaleta0: TIntegerField
      FieldName = 'maleta0'
    end
    object tblJrnmaleta1: TIntegerField
      FieldName = 'maleta1'
    end
    object tblJrnjornal: TIntegerField
      FieldName = 'jornal'
    end
    object tblJrnfecha: TDateTimeField
      FieldName = 'fecha'
    end
    object tblJrngrupo: TIntegerField
      FieldName = 'grupo'
    end
    object tblJrnid: TFloatField
      FieldName = 'id'
    end
    object tblJrnapenom: TStringField
      FieldKind = fkLookup
      FieldName = 'apenom'
      LookupDataSet = qryGralPer
      LookupKeyFields = 'id'
      LookupResultField = 'apenom'
      KeyFields = 'id'
      Size = 150
      Lookup = True
    end
  end
  object dsJrn: TDataSource
    DataSet = dtsJrn
    OnStateChange = dsJrnStateChange
    Left = 640
    Top = 192
  end
  object qryQad: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'fecha'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '#02/01/2000#'
      end>
    Prepared = True
    SQL.Strings = (
      'SELECT DISTINCT grupo, fecha, q.cuadrilla'
      'FROM jornales j LEFT JOIN cuadrillas q ON j.grupo=q.id'
      'WHERE fecha =:fecha')
    Left = 536
    Top = 200
  end
  object dsQad: TDataSource
    DataSet = qryQad
    Left = 536
    Top = 152
  end
  object qryGralPer: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <>
    Prepared = True
    SQL.Strings = (
      'Select trim(Apellido)+" "+trim(Nombre) as apenom, id'
      'From Enroll'
      '')
    Left = 208
    Top = 200
  end
  object qryJrn: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    DataSource = dsQuad
    Parameters = <
      item
        Name = 'grupo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'fecha'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      
        'SELECT DISTINCT j.id, (p.apellido+'#39' '#39'+p.nombre) as apenom,j.male' +
        'ta0, j.maleta1, j.jornal'
      'FROM jornales j LEFT JOIN enroll p ON j.id=p.id'
      'WHERE j.grupo=:grupo'
      'AND j.fecha=:fecha'
      'ORDER BY 2'
      '')
    Left = 592
    Top = 200
  end
  object dtsJrn: TADODataSet
    Connection = adoCnx
    CursorType = ctStatic
    CommandText = 
      'select grupo, j.fecha, j.id, (p.apellido+'#39' '#39'+p.nombre) as apenom' +
      ', jornal, maleta0, maleta1 '#13#10'from jornales j left join enroll p ' +
      'on j.id=p.id'#13#10'order by 4'
    DataSource = dsQad
    IndexFieldNames = 'grupo;fecha'
    MasterFields = 'grupo;fecha'
    Parameters = <>
    Prepared = True
    Left = 640
    Top = 152
  end
  object cmdJrn: TADOCommand
    CommandText = 'insert into jornales values (:fecha, :grupo, :id, 0, 0, 0)'
    Connection = adoCnx
    Parameters = <
      item
        Name = 'fecha'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'grupo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 656
    Top = 8
  end
  object qryJrnEx: TADOQuery
    Connection = adoCnx
    Parameters = <
      item
        Name = 'fecha'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'grupo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM jornales'
      'WHERE fecha=:fecha'
      'AND grupo=:grupo'
      'AND id=:id')
    Left = 656
    Top = 56
  end
  object qryAsisToday: TADOQuery
    Connection = adoCnx
    Parameters = <
      item
        Name = 'fecha'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM asistencias'
      'WHERE fecha =:fecha')
    Left = 656
    Top = 104
  end
  object Employees: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    BeforePost = EmployeesBeforePost
    TableName = 'Employees'
    Left = 60
    Top = 336
  end
  object Entries: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'date'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      
        'SELECT e.timestamp, TRIM(p.lastname)+" "+TRIM(p.firstname) AS Ap' +
        'eNom, e.id'
      'FROM Entries e LEFT JOIN employees p ON e.id=p.id'
      'WHERE e.date=:date'
      'ORDER BY e.timestamp DESC')
    Left = 120
    Top = 280
  end
  object dsEntries: TDataSource
    AutoEdit = False
    DataSet = Entries
    Left = 120
    Top = 338
  end
  object newEntry: TADOCommand
    CommandText = 
      'insert into Entries values (:timestamp, :id, :date, :checkpoint,' +
      ' :modified_on)'
    Connection = adoCnx
    Parameters = <
      item
        Name = 'timestamp'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'date'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'checkpoint'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'modified_on'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 176
    Top = 336
  end
  object qDepts: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'date1'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'date2'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'SELECT date, dept, count(id) as qty'
      'FROM payrolls'
      'WHERE date BETWEEN :date1 AND :date2'
      'GROUP BY date, dept')
    Left = 392
    Top = 336
  end
  object dsDepts: TDataSource
    DataSet = qDepts
    Left = 440
    Top = 336
  end
  object qPayrolls: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    DataSource = dsDepts
    Parameters = <
      item
        Name = 'date'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '27/05/2008'
      end
      item
        Name = 'dept'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = 'QUIROGA AGUADA'
      end>
    Prepared = True
    SQL.Strings = (
      
        'SELECT a.id, e.lastname+'#39' '#39'+e.firstname as apenom, a.dept, a.dat' +
        'e, a.deduction1, a.deduction2, a.amountpaid'
      'FROM payrolls a LEFT JOIN employees e ON a.id=e.id'
      'WHERE a.date = :date'
      'AND a.dept=:dept'
      'ORDER BY a.date, a.dept, 2')
    Left = 488
    Top = 336
  end
  object dsPayrolls: TDataSource
    DataSet = qPayrolls
    Left = 536
    Top = 336
  end
  object newPayroll: TADOCommand
    CommandText = 
      'INSERT INTO Payrolls ( id, [date], dept, modified_on )'#13#10'SELECT E' +
      'ntries.id, Entries.date, Employees.dept, now'#13#10'FROM Entries  INNE' +
      'R JOIN Employees ON Entries.id = Employees.id'#13#10'WHERE (((Entries.' +
      'id) Not In (select id from payrolls where date=:date1)) AND ((En' +
      'tries.date)=:date2))'#13#10'GROUP BY Entries.id, Entries.date, Employe' +
      'es.dept;'#13#10
    Connection = adoCnx
    Prepared = True
    Parameters = <
      item
        Name = 'date1'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'date2'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 608
    Top = 336
  end
  object dsEmployees: TDataSource
    AutoEdit = False
    DataSet = qEmployees
    Left = 120
    Top = 394
  end
  object qEmployees: TADOQuery
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'param0'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      
        'Select (lastname+" "+firstname) as Apellido_Nombre, id as ID_CUI' +
        'L'
      'From Employees'
      'Where (lastname+" "+firstname) Like :param0'
      'Order By (lastname+" "+firstname)')
    Left = 56
    Top = 392
  end
  object qEnableEmp: TADOQuery
    Connection = adoCnx
    Parameters = <
      item
        Name = 'id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'Select id'
      'From Employees'
      'Where id = :id'
      'and enabled = true')
    Left = 192
    Top = 392
  end
  object dsEmp: TDataSource
    DataSet = Employees
    Left = 64
    Top = 282
  end
  object Departments: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    BeforePost = DepartmentsBeforePost
    IndexName = 'PrimaryKey'
    TableName = 'Departments'
    Left = 284
    Top = 392
  end
  object dsDepartments: TDataSource
    DataSet = Departments
    Left = 285
    Top = 344
  end
  object cmdXport: TADODataSet
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <>
    Prepared = True
    Left = 608
    Top = 392
  end
  object cmdImport: TADODataSet
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <>
    Prepared = True
    Left = 536
    Top = 392
  end
  object cmdAux: TADODataSet
    Connection = adoCnx
    CursorType = ctStatic
    Parameters = <>
    Prepared = True
    Left = 464
    Top = 392
  end
  object BioFingers: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    IndexName = 'PrimaryKey'
    TableName = 'BioFingers'
    Left = 180
    Top = 280
  end
  object Payrolls: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    IndexName = 'PrimaryKey'
    TableName = 'Payrolls'
    Left = 244
    Top = 280
  end
  object Entries1: TADOTable
    Connection = adoCnx
    CursorType = ctStatic
    IndexName = 'PrimaryKey'
    TableName = 'Entries'
    Left = 292
    Top = 280
  end
end
