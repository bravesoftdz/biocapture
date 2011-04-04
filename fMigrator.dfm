object frmMigrator: TfrmMigrator
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'SCAR Migrador'
  ClientHeight = 94
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 77
    TabOrder = 0
    object labMigrate: TLabel
      Left = 16
      Top = 35
      Width = 56
      Height = 13
      Caption = 'Migrando...'
      Visible = False
    end
    object btnMigrate: TBitBtn
      Left = 342
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Migrar'
      TabOrder = 0
      OnClick = btnMigrateClick
    end
    object BitBtn2: TBitBtn
      Left = 342
      Top = 37
      Width = 75
      Height = 25
      Caption = 'Cerrar'
      ModalResult = 2
      TabOrder = 1
    end
    object pgbProcess: TProgressBar
      Left = 16
      Top = 53
      Width = 305
      Height = 16
      Step = 1
      TabOrder = 2
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 75
    Width = 425
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object fedSource: TFilenameEdit
    Left = 16
    Top = 8
    Width = 312
    Height = 21
    Hint = 'Haga click en el boton'
    DefaultExt = '*.mdb'
    Filter = 'All files (*.*)|*.*|Access Database (*.mdb)|*.mdb'
    FilterIndex = 2
    DialogTitle = 'Seleccione BD Origen'
    NumGlyphs = 1
    TabOrder = 2
  end
  object adoCnx: TADOConnection
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    AfterConnect = adoCnxAfterConnect
    Left = 352
    Top = 64
  end
  object adoCmd: TADOCommand
    Connection = adoCnx
    Parameters = <>
    Left = 384
    Top = 64
  end
end
