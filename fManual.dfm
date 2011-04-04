object frmManual: TfrmManual
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Ingreso Manual Asistencia'
  ClientHeight = 324
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 437
    Height = 306
    Caption = 'Panel1'
    TabOrder = 0
    object grdManual: TDBGrid
      Left = 9
      Top = 45
      Width = 416
      Height = 245
      DataSource = dm.dsEmployees
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Courier New'
      TitleFont.Style = []
      OnDblClick = btnOKClick
    end
    object Edit1: TEdit
      Left = 9
      Top = 16
      Width = 305
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 0
      OnChange = Edit1Change
    end
    object btnOK: TButton
      Left = 350
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Aceptar'
      Default = True
      TabOrder = 2
      OnClick = btnOKClick
    end
  end
end
