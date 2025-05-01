program WebClient_Example;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

//C# Code example can be found at https://docs.microsoft.com/en-gb/dotnet/api/system.net.webclient?view=netframework-4.7.2
uses
  System.SysUtils,
  CNClrLib.Core,
  CNClrLib.Net;

var
  Console: _Console;
  url, s: String;
  client: _WebClient;
  data: _Stream;
  reader: _StreamReader;
begin
  Console := CoConsole.CreateInstance;
  try
    Console.WriteLine_14('Specify the URI of the resource to retrieve:');
    url := Console.ReadLine;

    client := CoWebClient.CreateInstance;

    // Add a user agent header in case the
    // requested URI contains a query.

    client.Headers.Add('user-agent', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)');

    data := client.OpenRead(url);
    reader := CoStreamReader.CreateInstance(data);
    s := reader.ReadToEnd;
    Console.WriteLine_14(s);
    data.Close;
    reader.Close;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Console.ReadLine;
end.
