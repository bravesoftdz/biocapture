unit fSCARUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, jpeg, ADODB, DB;

type
  TForm1 = class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    adoCnx: TADOConnection;
    adoCmd: TADOCommand;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  adoCmd.CommandText:='create table [usuarios] ( [username] text(255), [password] text(255), [usertype] byte)';
  adoCmd.Execute;
  adoCmd.Commandtext:='CREATE UNIQUE INDEX [PrimaryKey] ON [usuarios] ([username])  WITH PRIMARY DISALLOW NULL';
  adoCmd.Execute;
  adoCmd.CommandText:='INSERT INTO [usuarios] VALUES ("admin","admin",100)';
  adoCmd.Execute;
  button1.Enabled:=false;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  try
    adoCnx.Connected:=True;
  except
    ShowMessage('Ha ocurrido un error al intentar conectarse a la Base de Datos');
  end;
end;

end.
