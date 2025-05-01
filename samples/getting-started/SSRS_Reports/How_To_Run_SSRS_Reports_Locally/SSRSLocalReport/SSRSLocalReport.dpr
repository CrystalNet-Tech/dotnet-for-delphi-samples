program SSRSLocalReport;

uses
  Vcl.Forms,
  uReportViewer in 'uReportViewer.pas' {Form1},
  Microsoft.ReportViewer.WinForms.Consts in 'Microsoft.ReportViewer.WinForms.Consts.pas',
  Microsoft.ReportViewer.WinForms.Enums in 'Microsoft.ReportViewer.WinForms.Enums.pas',
  Microsoft.ReportViewer.WinForms.Intf in 'Microsoft.ReportViewer.WinForms.Intf.pas',
  Microsoft.ReportViewer.WinForms in 'Microsoft.ReportViewer.WinForms.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
