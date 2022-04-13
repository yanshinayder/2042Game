unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    LytToolbar: TLayout;
    RectPlacar: TRectangle;
    Label1: TLabel;
    lblplacar: TLabel;
    RectVoltar: TRectangle;
    Image1: TImage;
    Layout1: TLayout;
    Label3: TLabel;
    lblLevel: TLabel;
    GridLayout: TGridLayout;
    Rectangle1: TRectangle;
    lblQuadrado1: TLabel;
    Rectangle2: TRectangle;
    lblQuadrado2: TLabel;
    Rectangle3: TRectangle;
    lblQuadrado3: TLabel;
    Rectangle4: TRectangle;
    lblQuadrado4: TLabel;
    Rectangle5: TRectangle;
    lblQuadrado5: TLabel;
    Rectangle6: TRectangle;
    lblQuadrado6: TLabel;
    Rectangle7: TRectangle;
    lblQuadrado7: TLabel;
    Rectangle8: TRectangle;
    lblQuadrado8: TLabel;
    Rectangle9: TRectangle;
    lblQuadrado9: TLabel;
    Rectangle10: TRectangle;
    lblQuadrado10: TLabel;
    Rectangle11: TRectangle;
    lblQuadrado11: TLabel;
    Rectangle12: TRectangle;
    lblQuadrado12: TLabel;
    Rectangle13: TRectangle;
    lblQuadrado13: TLabel;
    Rectangle14: TRectangle;
    lblQuadrado14: TLabel;
    Rectangle15: TRectangle;
    lblQuadrado15: TLabel;
    Rectangle16: TRectangle;
    lblQuadrado16: TLabel;
    Rectangle17: TRectangle;
    lblQuadrado17: TLabel;
    Rectangle18: TRectangle;
    lblQuadrado18: TLabel;
    Rectangle19: TRectangle;
    lblQuadrado19: TLabel;
    Rectangle20: TRectangle;
    lblQuadrado20: TLabel;
    procedure RectVoltarClick(Sender: TObject);
    procedure lblQuadrado1DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure lblQuadrado1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure FormShow(Sender: TObject);
  private
    procedure SomarPontos(pontos: integer);
    procedure Reset;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.Reset;
begin
  lblPlacar.Text := '0';
  lblLevel.Text := '1';
end;


procedure TFrmPrincipal.SomarPontos(pontos : integer);
begin
  lblPlacar.Text := IntToStr(lblPlacar.Text.ToInteger + pontos);
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
   Reset;
end;

procedure TFrmPrincipal.lblQuadrado1DragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
var
  lblOrigem, lblDestino : TLabel;
begin
  lblDestino := TLabel(Sender);
  lblOrigem := TLabel(Data.Source);

  if (lblDestino.Text <> '') and (lblOrigem.Text <> '') then
  begin
  lblDestino.Text := IntToStr(lblDestino.Text.ToInteger + lblOrigem.Text.ToInteger);
  lblOrigem.Text := '' ;

  SomarPontos(lblDestino.Text.ToInteger);
  end;

end;

procedure TFrmPrincipal.lblQuadrado1DragOver(Sender: TObject;
  const Data: TDragObject; const Point: TPointF; var Operation: TDragOperation);
begin
  Operation := TDragOperation.Move;
end;

procedure TFrmPrincipal.RectVoltarClick(Sender: TObject);
begin
  close;
end;

end.
