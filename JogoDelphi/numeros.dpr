program numeros;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMenu in 'UnitMenu.pas' {FrmNumero},
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TFrmNumero, FrmNumero);
  Application.Run;
end.
