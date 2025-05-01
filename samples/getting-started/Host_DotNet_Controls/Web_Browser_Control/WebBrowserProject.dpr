program WebBrowserProject;

uses
  Vcl.Forms,
  WebBrowser in 'WebBrowser.pas' {Form12};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm12, Form12);
  Application.Run;
end.
