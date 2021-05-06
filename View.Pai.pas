unit View.Pai;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TViewPai = class(TForm)
  private
    { Private declarations }
  protected
  public
    { Public declarations }
    procedure Executar(Sender: TObject); virtual;
    procedure ExecutarModulo(Sender: TObject); virtual;
  end;

var
  ViewPai: TViewPai;

implementation


{$R *.dfm}

{ TViewPai }


procedure TViewPai.Executar(Sender: TObject);
begin

end;

procedure TViewPai.ExecutarModulo(Sender: TObject);
begin


end;

end.

