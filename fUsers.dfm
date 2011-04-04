object frmUsers: TfrmUsers
  Left = 0
  Top = 0
  Caption = 'Gestion Usuarios'
  ClientHeight = 194
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 8
    Top = 8
    Width = 410
    Height = 177
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 40
      Width = 36
      Height = 13
      Caption = 'Usuario'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 16
      Top = 80
      Width = 46
      Height = 13
      Caption = 'Password'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 16
      Top = 120
      Width = 23
      Height = 13
      Caption = 'Nivel'
      FocusControl = DBEdit3
    end
    object DBNavigator1: TDBNavigator
      Left = 16
      Top = 8
      Width = 240
      Height = 25
      DataSource = dsUsers
      TabOrder = 0
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 56
      Width = 300
      Height = 21
      DataField = 'Username'
      DataSource = dsUsers
      TabOrder = 1
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 96
      Width = 300
      Height = 21
      DataField = 'Password'
      DataSource = dsUsers
      TabOrder = 2
    end
    object DBEdit3: TDBEdit
      Left = 16
      Top = 136
      Width = 57
      Height = 21
      DataField = 'UserType'
      DataSource = dsUsers
      TabOrder = 3
    end
  end
  object dsUsers: TDataSource
    DataSet = dm.tblUsers
    Left = 296
    Top = 24
  end
end
