unit HostWPFControl;

interface
{$WARN SYMBOL_PLATFORM OFF}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CNClrLib.Comp, WindowsFormsIntegration.Intf,
  WindowsFormsIntegration.Enums, WindowsFormsIntegration, MyControls, MyControls.Intf,
  CNClrLib.Host, CNClrLib.Common;

type
  TForm1 = class(TForm)
    ClrContainer1: TClrContainer;
    lblAddress: TLabel;
    lblName: TLabel;
    lblCity: TLabel;
    lblState: TLabel;
    lblZip: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCtrlHost: IElementHost;
    wpfAddressCtrl: IMyControl1;

    initFontWeight: _FontWeight;
    initFontSize: Double;
    initFontStyle: _FontStyle;
    initBackBrush: ISolidColorBrush;
    initForeBrush: ISolidColorBrush;
    initFontFamily: _FontFamily;


  	procedure wpfAddressCtrl_OnButtonClick(sender: IClrBaseObject; args: IMyControlEventArgs);
	  procedure wpfAddressCtrl_Loaded(sender: IClrBaseObject; e: _RoutedEventArgs);
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

uses CNClrLib.Windows;

procedure TForm1.wpfAddressCtrl_OnButtonClick(sender: IClrBaseObject;
  args: IMyControlEventArgs);
begin
  if args.IsOK then
  begin
    lblAddress.Caption := 'Street Address: ' + args.MyStreetAddress;
    lblCity.Caption := 'City: ' + args.MyCity;
    lblName.Caption := 'Name: ' + args.MyName;
    lblState.Caption := 'State: ' + args.MyState;
    lblZip.Caption := 'Zip: ' + args.MyZip;
  end
  else
  begin
    lblAddress.Caption := 'Street Address: ';
    lblCity.Caption := 'City: ';
    lblName.Caption := 'Name: ';
    lblState.Caption := 'State: ';
    lblZip.Caption := 'Zip: ';
  end;
end;

procedure TForm1.wpfAddressCtrl_Loaded(sender: IClrBaseObject;
  e: _RoutedEventArgs);
begin
  initBackBrush := wpfAddressCtrl.MyControl_Background;
  initForeBrush := wpfAddressCtrl.MyControl_Foreground;
  initFontFamily := wpfAddressCtrl.MyControl_FontFamily;
  initFontSize := wpfAddressCtrl.MyControl_FontSize;
//  initFontWeight := wpfAddressCtrl.MyControl_FontWeight;
  //initFontStyle := wpfAddressCtrl.MyControl_FontStyle;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FCtrlHost := nil;
  wpfAddressCtrl := nil;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FCtrlHost := TElementHost.Create;
  FCtrlHost.Dock := dsFill;

//Initialise your wpf control
  wpfAddressCtrl := TMyControl1.Create;
  wpfAddressCtrl.InitializeComponent;
  FCtrlHost.Child := CoUIElement.Wrap(TMyControl1(wpfAddressCtrl).DefaultInterface);

  wpfAddressCtrl.OnButtonClick := wpfAddressCtrl_OnButtonClick;
  wpfAddressCtrl.Loaded := wpfAddressCtrl_Loaded;
  //Add Element Host Control to Container
  ClrContainer1.AddClrControl(TElementHost(FCtrlHost).DefaultInterface);
end;

end.
