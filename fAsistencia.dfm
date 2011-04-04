object frmAsistencia: TfrmAsistencia
  Left = 0
  Top = 0
  Caption = 'frmAsistencia'
  ClientHeight = 548
  ClientWidth = 791
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
    Width = 401
    Height = 161
    TabOrder = 0
    object rgpFilters: TRadioGroup
      Left = 16
      Top = 4
      Width = 369
      Height = 54
      Caption = ' Filtros '
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        '&Hoy'
        'A&yer u otro'
        '&Rango...')
      TabOrder = 0
      OnClick = rgpFiltersClick
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 64
      Width = 369
      Height = 49
      TabOrder = 1
      object lblFrom: TLabel
        Left = 16
        Top = 20
        Width = 36
        Height = 13
        Caption = 'Fecha: '
      end
      object lblUntil: TLabel
        Left = 216
        Top = 20
        Width = 35
        Height = 13
        Caption = 'Hasta: '
        Visible = False
      end
      object dtpFrom: TDateTimePicker
        Left = 72
        Top = 16
        Width = 81
        Height = 21
        Date = 39595.416582361110000000
        Time = 39595.416582361110000000
        TabOrder = 0
      end
      object dtpUntil: TDateTimePicker
        Left = 272
        Top = 16
        Width = 81
        Height = 21
        Date = 39595.416582361110000000
        Time = 39595.416582361110000000
        TabOrder = 1
        Visible = False
      end
    end
    object btnPrint: TButton
      Left = 201
      Top = 119
      Width = 75
      Height = 25
      Caption = '&Imprimir'
      TabOrder = 2
      OnClick = btnPrintClick
    end
    object btnSalir: TButton
      Left = 310
      Top = 119
      Width = 75
      Height = 25
      Caption = 'Salir'
      ModalResult = 2
      TabOrder = 3
    end
    object btnPreview: TButton
      Left = 120
      Top = 119
      Width = 75
      Height = 25
      Caption = '&Vista Previa'
      TabOrder = 4
      OnClick = btnPreviewClick
    end
  end
  object pnlDataPreview: TPanel
    Left = 8
    Top = 175
    Width = 401
    Height = 364
    TabOrder = 1
    object DBNavigator1: TDBNavigator
      Left = 7
      Top = 7
      Width = 240
      Height = 25
      DataSource = dm.dsDepts
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 7
      Top = 38
      Width = 378
      Height = 97
      DataSource = dm.dsDepts
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      Left = 7
      Top = 141
      Width = 378
      Height = 217
      DataSource = dm.dsPayrolls
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end
