program HostWPFCtrlProject;

uses
  Vcl.Forms,
  HostWPFControl in 'HostWPFControl.pas' {Form1},
  WindowsFormsIntegration.Consts in 'WindowsFormsIntegration.Consts.pas',
  WindowsFormsIntegration.Enums in 'WindowsFormsIntegration.Enums.pas',
  WindowsFormsIntegration.Intf in 'WindowsFormsIntegration.Intf.pas',
  WindowsFormsIntegration in 'WindowsFormsIntegration.pas',
  MyControls.Enums in 'MyControls.Enums.pas',
  MyControls.Intf in 'MyControls.Intf.pas',
  MyControls in 'MyControls.pas',
  MyControls.Consts in 'MyControls.Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
