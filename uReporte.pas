unit uReporte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, QuickRpt, QRCtrls;

type
  TformReporte = class(TForm)
    qrpAsistencia: TQuickRep;
    adoPer: TADOQuery;
    QRBand2: TQRBand;
    DataSource1: TDataSource;
    adoPerID: TFloatField;
    adoPercuadrillaid: TIntegerField;
    adoPerasi: TIntegerField;
    adoPerapenom: TWideStringField;
    QRGroup1: TQRGroup;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel8: TQRLabel;
    adoPercuadrilla: TWideStringField;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRLabel6: TQRLabel;
    adoCon: TADOQuery;
    dsCon: TDataSource;
    QRSubDetail1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRLabel7: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formReporte: TformReporte;

implementation

uses uDM;
{$R *.dfm}

end.
