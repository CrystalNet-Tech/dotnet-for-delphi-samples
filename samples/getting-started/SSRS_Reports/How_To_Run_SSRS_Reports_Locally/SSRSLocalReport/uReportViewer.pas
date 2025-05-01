unit uReportViewer;

interface
{$WARN SYMBOL_PLATFORM OFF}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CNClrLib.Comp, Vcl.StdCtrls, Microsoft.ReportViewer.WinForms.Intf,
  Microsoft.ReportViewer.WinForms, Microsoft.ReportViewer.WinForms.Enums;

type
  TForm1 = class(TForm)
    ClrContainer1: TClrContainer;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FReportViewer1: IReportViewer;
    procedure AddHostControl;
    procedure GenerateLocalReport;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses CNClrLib.Data, CNClrLib.Generic.Helper, CNClrLib.Enums;

{$R *.dfm}

/// <summary>
/// Create and instance of the .Net ReportViewer control
/// Set the Properties of the .Net ReportViewer control
/// Add the .Net ReportViewer control to the ClrContainer
/// </summary>
procedure TForm1.AddHostControl;
begin
  ///Create Instance of the ReportViewer control and set it properties
  FReportViewer1 := TReportViewer.Create();
  FReportViewer1.Dock := TDockStyle.dsFill;

  ///Temporarily suspends the layout logic for the control.
  ClrContainer1.SuspendLayout;

  //Add the DatagridView control to the host control container
  ClrContainer1.AddClrControl(FReportViewer1.Unwrap);

  //Resumes usual layout logic.
  ClrContainer1.ResumeLayout();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  GenerateLocalReport;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AddHostControl;
end;

procedure TForm1.GenerateLocalReport;
var
  repParameters: IList<IReportParameter>;
  repParameter: IReportParameter;
  con: _SqlConnection;
  cmd: _SqlCommand;
  dt: _DataTable;
  rds: IReportDataSource;
begin
  FReportViewer1.ProcessingMode := TProcessingMode.pmLocal;
  FReportViewer1.LocalReport.ReportPath := 'AdHocExistingRegReport.rdl';
  FReportViewer1.LocalReport.DataSources.Clear();

  repParameters := TList<IReportParameter>.Create;

  repParameter := TReportParameter.Create;
  repParameter.Name := 'Par1';
  repParameter.Values.Add('Value1');
  repParameters.Add(repParameter);

  con := CoSqlConnection.CreateInstance('Data Source=myDataSource;Initial Catalog=myDataBase;User ID=myUsername;Password=myPassword;');
  con.Open();

  cmd := CoSqlCommand.CreateInstance('MyStoredProc', con);
  cmd.CommandType := CommandType_StoredProcedure;
  cmd.Parameters.AddWithValue('@Par1', 'Value1');

  dt := CoDataTable.CreateInstance();
  dt.Load(cmd.ExecuteReader().AsIDataReader);

  rds := TReportDataSource.Create('DataSet_MyStoredProc', dt);

  FReportViewer1.LocalReport.DataSources.Add(rds);

  FReportViewer1.LocalReport.SetParameters(repParameters);
  FReportViewer1.LocalReport.Refresh();

  con.Close();
end;

end.
