unit rAsistencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, StdCtrls, Mask, DBCtrls;

type
  TfrmRAsistencia = class(TForm)
    rptAsistencia: TQuickRep;
    QRBand1: TQRBand;
    QRSubDetail1: TQRSubDetail;
    QRLabel6: TQRLabel;
    QRSysData2: TQRSysData;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    GroupHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape2: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText3: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRAsistencia: TfrmRAsistencia;

implementation

uses uDM;

{$R *.dfm}

end.
