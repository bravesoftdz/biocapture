object frmImport: TfrmImport
  Left = 0
  Top = 0
  Caption = 'Importar'
  ClientHeight = 275
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 432
    Height = 259
    Caption = 'Panel1'
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 16
      Top = 16
      Width = 305
      Height = 233
      Caption = ' Seleccione Origen Datos'
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 48
        Width = 33
        Height = 13
        Caption = 'Tabla: '
      end
      object btnProcess: TButton
        Left = 222
        Top = 44
        Width = 75
        Height = 25
        Caption = 'Procesar'
        Enabled = False
        TabOrder = 1
        OnClick = btnProcessClick
      end
      object mmoImport: TMemo
        Left = 8
        Top = 75
        Width = 289
        Height = 153
        Lines.Strings = (
          '')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
        WordWrap = False
      end
      object cbxTable: TComboBox
        Left = 55
        Top = 45
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          'Personas'
          'Huellas'
          'Entradas'
          'Asistencias'
          'Cuadrillas'
          'Usuarios')
      end
      object edtImportFile: TFilenameEdit
        Left = 8
        Top = 17
        Width = 289
        Height = 21
        Filter = 'All files (*.skr)|*.skr'
        NumGlyphs = 1
        TabOrder = 0
        OnChange = edtImportFileChange
      end
    end
    object btnOk: TButton
      Left = 344
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Importar'
      Enabled = False
      TabOrder = 1
      OnClick = btnOkClick
    end
    object Button2: TButton
      Left = 344
      Top = 47
      Width = 75
      Height = 25
      Caption = 'Salir'
      ModalResult = 2
      TabOrder = 2
      OnClick = Button2Click
    end
  end
end
