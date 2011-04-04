unit uPlanilla;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ExtCtrls, QuickRpt, Qrctrls, ADODB;

type
  TrpfAsistencia = class(TForm)
    rptMaletas: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRLabel6: TQRLabel;
    QRSysData2: TQRSysData;
    QRBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText4: TQRDBText;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRLabel7: TQRLabel;
    QRBand2: TQRBand;
    QRExpr1: TQRExpr;
    QRShape5: TQRShape;
    QRLabel8: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel9: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rpfAsistencia: TrpfAsistencia;

implementation

uses
  uDM;

{$R *.dfm}

end.
