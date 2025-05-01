A typical corporate setup would have a running Delphi application and SSRS reports running out of a separate Report server (or an Application server or from the Database server itself). In such scenarios, developers make use of Visual Studio Business Intelligence shell to create SSRS reports in .rdl format and deploy them to the SSRS Report server. Such SSRS reports are accessed from the Delphi application through Report Viewer using the .Net Runtime Library for Delphi.

Code for such a typical scenario. Assuming you have a rdl report called AdHocExistingRegReport.rdl in the same location as the Delphi executable file.

```
procedure TForm1.GenerateLocalReport;
var
  repParameters: IList;  
  repParameter: IReportParameter;  
  con: _SqlConnection;  
  cmd: _SqlCommand;  
  dt: _DataTable;  
  rds: IReportDataSource;
begin
  FReportViewer1.ProcessingMode := TProcessingMode.pmLocal;  
  FReportViewer1.LocalReport.ReportPath := 'AdHocExistingRegReport.rdl';  
  FReportViewer1.LocalReport.DataSources.Clear();  
  
  repParameters := TList.Create; 
  
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
```

In the above code, "DataSet_MyStoredProc" is the dataset in my report. The below statement will populate the "DataSet_MyStoredProc" dataset with the data from DataTable dt.
```
  rds := TReportDataSource.Create('DataSet_MyStoredProc', dt);
```