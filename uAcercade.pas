unit uAcercade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TformAcercade = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    procedure FormClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAcercade: TformAcercade;

implementation

{$R *.dfm}

procedure TformAcercade.FormClick(Sender: TObject);
begin
 ModalResult:=mrOK;
end;

procedure TformAcercade.FormKeyPress(Sender: TObject; var Key: Char);
begin
  ModalResult:=mrOK;
end;

end.
