program WebRequestGetExample;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN HIDING_MEMBER OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.Net, CNClrLib.Core, CNClrLib.IO;

var
  request: _WebRequest;
  requestHelper: _WebRequestHelper;
  response: _HttpWebResponse;
  dataStream: _Stream;
  reader: _StreamReader;
  responseFromServer: String;
begin
  try
    // Create a static WebRequest class helper
    requestHelper := CoWebRequestHelper.CreateInstance;

    // Create a request for the URL.
    request := requestHelper.Create('http://www.contoso.com/default.html');

    // If required by the server, set the credentials.
    request.Credentials := CoCredentialCacheHelper.CreateInstance.DefaultCredentials;

    // Get the response.
    response := CoHttpWebResponse.Wrap(request.GetResponse);

    // Display the status.
    WriteLn(response.StatusDescription);

    // Get the stream containing content returned by the server.
    dataStream := response.GetResponseStream;

    // Open the stream using a StreamReader for easy access.
    reader := CoStreamReader.CreateInstance(dataStream);

    // Read the content.
    responseFromServer := reader.ReadToEnd ();

    // Display the content.
    WriteLn(responseFromServer);

    // Cleanup the streams and the response.
    reader.Close;
    dataStream.Close;
    response.Close;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
