unit uPlanilla1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ExtCtrls, QuickRpt, Qrctrls, ADODB;

type
  TformPlanilla1 = class(TForm)
    rptMaletas: TQuickRep;
    QRSubDetail1: TQRSubDetail;
    QRDBText2: TQRDBText;
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    adoCnxBag: TADOConnection;
    adoBag: TADOQuery;
    dsCon: TDataSource;
    QRDBText4: TQRDBText;
    PageHeaderBand1: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    adoCon: TADOQuery;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRSysData2: TQRSysData;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    QRShape2: TQRShape;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPlanilla1: TformPlanilla1;

implementation

{$R *.dfm}

end.
