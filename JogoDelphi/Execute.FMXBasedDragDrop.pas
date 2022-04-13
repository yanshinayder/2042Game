unit Execute.FMXBasedDragDrop;

{
  FMX based Drag&Drop automatic mode for Delphi XE6 (c)2014 by Execute SARL

  FMX lacks support for Drag & Drop for Android,
  this unit adds a Drag & Drop crossplatform solution that should work on Android and iOS.

  Paul TOTH
  http://www.execute.re

}

interface

uses
  System.Types;

implementation

uses
  System.Classes, System.UITypes,
  FMX.Platform, FMX.Objects, FMX.Types, FMX.Forms, FMX.Graphics;

type
  TOpenForm = class(TForm)
  // access to protected method SetCaptured()
  end;

  // the dragged image
  TDragImage = class(TImage)
  private
    FMouse    : IFMXMouseService;
    FOrigin   : TPointF;
    FData     : TDragObject;
    FOperation: TDragOperation;
  protected
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
  end;

  // the missing service
  TFMXDragDrop = class(TInterfacedObject, IFMXDragDropService)
  private
    FImage : TDragImage;
  public
    destructor Destroy; override;
    procedure BeginDragDrop(AForm: TCommonCustomForm; const Data: TDragObject; ABitmap: TBitmap);
  end;

// move the dragged image with mouse movement
procedure TDragImage.MouseMove(Shift: TShiftState; X: Single; Y: Single);
var
  MousePos: TPointF;
begin
  MousePos := FMouse.GetMousePos; // we need a Form based mouse position, not the local one
  Position.X := FOrigin.X + MousePos.X;
  Position.Y := FOrigin.Y + MousePos.Y;
  FOperation := TDragOperation.None;
  HitTest := False; // don't see me
  TForm(Parent).DragOver(FData, FMouse.GetMousePos, FOperation);
  HitTest := True;  // see me
end;

// drop the dragged image somewhere
procedure TDragImage.MouseUp(Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single);
begin
  if FOperation <> TDragOperation.None then
  begin
    HitTest := False; // don't see me
    TForm(Parent).DragDrop(FData, FMouse.GetMousePos);
    HitTest := True;  // see me
  end;
  Parent := nil;
end;

destructor TFMXDragDrop.Destroy;
begin
  FImage.Free;
  inherited;
end;

procedure TFMXDragDrop.BeginDragDrop(AForm: TCommonCustomForm; const Data: TDragObject; ABitmap: TBitmap);
var
  Mouse: IFMXMouseService;
begin
  if FImage = nil then
  begin
    // the mouse position is not available, TCommonCustomForm.FMousePos would be a good candidate if it was not private
    // request the IFMXMouseService on the TForm to see if it is provided
    if IInterface(AForm).QueryInterface(IFMXMouseService, Mouse) <> 0 then
    begin
      // now request the TPlatform, but this ony is not updated when MouseDown occurs and the first image position will be wrong
      if not TPlatformServices.Current.SupportsPlatformService(IFMXMouseService, IInterface(Mouse)) then
        Exit;
    end;
    FImage := TDragImage.Create(nil);
    FImage.FMouse := Mouse;
  end;

  FImage.Parent := AForm;
  FImage.FData := Data;
  FImage.FOrigin := FImage.FMouse.GetMousePos(); // AForm.FMousePos would be great

  FImage.SetBounds(
    FImage.FOrigin.X - ABitmap.Width/2,
    FImage.FOrigin.Y - ABitmap.Height/2,
    ABitmap.Width,
    ABitmap.Height
  );
  FImage.Bitmap.Assign(ABitmap);
  FImage.Opacity := 0.5;

  FImage.FOrigin.X := FImage.Position.X - FImage.FOrigin.X;
  FImage.FOrigin.Y := FImage.Position.Y - FImage.FOrigin.Y;

  TOpenForm(AForm).SetCaptured(FImage); // need an access to TCommonCustoForm.FCaptured
end;

initialization
  // Register the DragDrop service
  // on Windows & Mac the service is already registered and this unit is useless
  TPlatformServices.Current.AddPlatformService(IFMXDragDropService, TFMXDragDrop.Create);
end.
