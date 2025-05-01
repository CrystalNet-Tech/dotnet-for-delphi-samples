program WebRequestGetExample2;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

//See C# Code example at https://docs.microsoft.com/en-gb/dotnet/api/system.net.webrequest?view=netframework-4.7.2
uses
  System.SysUtils,
  CNClrLib.Core,
  CNClrLib.Net;

var
  Console: _Console;
  request: _WebRequest;
  response: _HttpWebResponse;
  dataStream: _Stream;
  reader: _StreamReader;
  responseFromServer: String;
  Uri: String;
begin
  Console := CoConsole.CreateInstance;
  try
    Console.WriteLine_14('Specify the URI of the resource to retrieve:');
    Uri := Console.ReadLine;
    // Create a request for the URL.
    request := CoWebRequestHelper.CreateInstance.Create(Uri);
    // If required by the server, set the credentials.
    request.Credentials := CoCredentialCacheHelper.CreateInstance.DefaultCredentials;
    // Get the response.
    response := CoHttpWebResponse.Wrap(request.GetResponse);
    // Display the status.
    Console.WriteLine_14(response.StatusDescription);
    // Get the stream containing content returned by the server.
    dataStream := response.GetResponseStream;
    // Open the stream using a StreamReader for easy access.
    reader := CoStreamReader.CreateInstance(dataStream);
    // Read the content.
    responseFromServer := reader.ReadToEnd;
    // Display the content.
    Console.WriteLine_14(responseFromServer);
    // Cleanup the streams and the response.
    reader.Close;
    dataStream.Close;
    response.Close;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Console.ReadLine;
end.
