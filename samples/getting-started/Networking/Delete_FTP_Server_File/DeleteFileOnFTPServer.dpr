program DeleteFileOnFTPServer;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.Net, CNClrLib.System;


var
  serverUri: _uri;
  request: _FtpWebRequest;
  response: _FtpWebResponse;
begin
  try
    if ParamCount = 0 then
      raise Exception.Create('You need to specify the FTP Server Uri');


    serverUri := CoUri.CreateInstance(ParamStr(0));
    // The serverUri parameter should use the ftp:// scheme.
    // It contains the name of the server file that is to be deleted.
    // Example: ftp://contoso.com/someFile.txt.
    //

    if serverUri.Scheme <> CoUriHelper.CreateInstance.UriSchemeFtp then
        raise Exception.Create('Invalid FTP Server Uri');

    // Get the object used to communicate with the server.
    request := CoFtpWebRequest.Wrap(CoWebRequestHelper.CreateInstance.Create_1(serverUri));
    request.Method := CoWebRequestMethods_Ftp.CreateInstance.DeleteFile;

    response := CoFtpWebResponse.CreateInstance(request.GetResponse);
    WriteLn('Delete status: %s', response.StatusDescription);
    response.Close();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
