object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Autorizaci'#243'n SCAR'
  ClientHeight = 171
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 377
    Height = 137
    Caption = 'Panel1'
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 16
      Top = 16
      Width = 257
      Height = 97
      Caption = 'Acceso '
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 63
        Height = 15
        Caption = 'Usuario: '
      end
      object Label2: TLabel
        Left = 16
        Top = 56
        Width = 77
        Height = 15
        Caption = 'Contrase'#241'a:'
      end
      object edtUser: TEdit
        Left = 104
        Top = 24
        Width = 121
        Height = 23
        TabOrder = 0
      end
      object edtPass: TMaskEdit
        Left = 104
        Top = 56
        Width = 121
        Height = 23
        PasswordChar = '*'
        TabOrder = 1
      end
    end
    object btnOk: TButton
      Left = 288
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Aceptar'
      Default = True
      TabOrder = 1
      OnClick = btnOkClick
    end
    object Button2: TButton
      Left = 288
      Top = 55
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancelar'
      ModalResult = 3
      TabOrder = 2
    end
  end
  object stbLogin: TStatusBar
    Left = 0
    Top = 152
    Width = 395
    Height = 19
    Panels = <>
  end
end
