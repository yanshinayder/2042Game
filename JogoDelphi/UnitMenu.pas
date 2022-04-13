unit UnitMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmNumero = class(TForm)
    Image1: TImage;
    RectPlay: TRectangle;
    RectRanking: TRectangle;
    Image2: TImage;
    Label1: TLabel;
    Image3: TImage;
    Label2: TLabel;
    procedure RectPlayClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNumero: TFrmNumero;

implementation

{$R *.fmx}

uses UnitPrincipal;

procedure TFrmNumero.RectPlayClick(Sender: TObject);
begin
  if not Assigned(FrmPrincipal) then
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);

  FrmPrincipal.Show;

end;

end.
