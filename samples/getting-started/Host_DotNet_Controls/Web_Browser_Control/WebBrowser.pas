unit WebBrowser;

interface
{$WARN SYMBOL_PLATFORM OFF}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, CNClrLib.Comp, CNClrLib.Windows;

type
  TForm12 = class(TForm)
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton2: TToolButton;
    ComboBox1: TComboBox;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    ToolBar2: TToolBar;
    ProgressBar1: TProgressBar;
    ClrContainer1: TClrContainer;
    Label1: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FWebBrowser: _WebBrowser;
    FUrl: String;

    procedure DoInitialiseWebBrowser;
    procedure DoSetWebBrowserNavigation;
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

uses CNClrLib.Enums, CNClrLib.Host, CNClrLib.Host.Helper;

{$R *.dfm}

function ToIntPtr(APointer: Pointer): _IntPtr;
begin
  Result := TClrConvert.ToManagedPointer(APointer)
end;

procedure WebBrowser_DocumentCompleted(ASender: _ClrObject; AE: _ClrEventArgs); stdcall;
begin
  with Form12 do
  begin
    ToolButton1.Enabled := FWebBrowser.CanGoBack;
    ToolButton2.Enabled := FWebBrowser.CanGoForward;
    Label1.Caption := 'Done';
  end;
end;

procedure WebBrowser_DocumentTitleChanged(ASender: _ClrObject; AE: _ClrEventArgs); stdcall;
begin
  Form12.Caption := Form12.FWebBrowser.DocumentTitle;
end;

procedure WebBrowser_StatusTextChanged(ASender: _ClrObject; AE: _ClrEventArgs); stdcall;
begin
  Form12.Label1.Caption := Form12.FWebBrowser.StatusText;
end;

procedure WebBrowser_ProgressChanged(ASender: _ClrObject; AE: _ClrEventArgs); stdcall;
var
  e: _WebBrowserProgressChangedEventArgs;
begin
  e := CoWebBrowserProgressChangedEventArgs.Wrap(AE.EventArgs);
  Form12.ProgressBar1.Max := e.MaximumProgress;

  if (e.CurrentProgress < 0) or (e.MaximumProgress < e.CurrentProgress) then
    Form12.ProgressBar1.Position := e.MaximumProgress
  else
    Form12.ProgressBar1.Position := e.CurrentProgress;
end;

procedure WebBrowser_Navigated(ASender: _ClrObject; AE: _ClrEventArgs); stdcall;
begin
  Form12.ComboBox1.Text := Form12.FWebBrowser.Url.ToString();
end;

procedure TForm12.DoSetWebBrowserNavigation;
var
  FEventHandler: TClrEventHandler;
begin
  if Trim(ComboBox1.Text) <> '' then
    FUrl := ComboBox1.Text;

  FWebBrowser.Navigate_1(FUrl);

  FEventHandler := WebBrowser_ProgressChanged;
  FWebBrowser.Add_ProgressChanged_1(nil, ToIntPtr(@FEventHandler));

  FEventHandler := WebBrowser_DocumentTitleChanged;
  FWebBrowser.Add_DocumentTitleChanged_1(nil, ToIntPtr(@FEventHandler));

  FEventHandler := WebBrowser_StatusTextChanged;
  FWebBrowser.Add_StatusTextChanged_1(nil, ToIntPtr(@FEventHandler));

  FEventHandler := WebBrowser_Navigated;
  FWebBrowser.Add_Navigated_1(nil, ToIntPtr(@FEventHandler));

  FEventHandler := WebBrowser_DocumentCompleted;
  FWebBrowser.Add_DocumentCompleted_1(nil, ToIntPtr(@FEventHandler));
end;

procedure TForm12.FormDestroy(Sender: TObject);
begin
  if FWebBrowser <> nil then
    FWebBrowser.Dispose;

  FWebBrowser := nil;
end;

procedure TForm12.FormShow(Sender: TObject);
begin
  DoInitialiseWebBrowser;
end;

procedure TForm12.DoInitialiseWebBrowser;
begin
  FUrl := 'http://www.msn.com';
  FWebBrowser := CoWebBrowser.CreateInstance;
  FWebBrowser.Dock := DockStyle_Fill;
  ClrContainer1.AddClrControl(FWebBrowser);

  DoSetWebBrowserNavigation;

  ToolButton1.Enabled := False;
  ToolButton2.Enabled := False;
end;

procedure TForm12.ToolButton1Click(Sender: TObject);
begin
  FWebBrowser.GoBack;
end;

procedure TForm12.ToolButton2Click(Sender: TObject);
begin
  FWebBrowser.GoForward;
end;

procedure TForm12.ToolButton3Click(Sender: TObject);
begin
  DoSetWebBrowserNavigation;
end;

procedure TForm12.ToolButton4Click(Sender: TObject);
begin
  FWebBrowser.Refresh;
end;

procedure TForm12.ToolButton5Click(Sender: TObject);
begin
  FWebBrowser.GoHome;
end;

procedure TForm12.ToolButton6Click(Sender: TObject);
begin
  FWebBrowser.ShowPrintPreviewDialog;
end;


end.
