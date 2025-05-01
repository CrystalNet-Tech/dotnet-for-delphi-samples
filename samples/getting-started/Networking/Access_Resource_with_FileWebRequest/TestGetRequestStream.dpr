program TestGetRequestStream;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.Net, CNClrLib.System, System.win.ComObj,
  CNClrLib.Host, CNClrLib.Core;


var
  myFileWebRequest: _FileWebRequest;

procedure showUsage;
begin
  WriteLn(#13#10+'Please enter file name and timeout :');
  WriteLn('Usage: cs_getrequeststream <systemname>/<sharedfoldername>/<filename> timeout');
  WriteLn('Example: cs_getrequeststream ngetrequestrtream() ndpue/temp/hello.txt  1000');
  WriteLn('Small time-out values (for example, 3 or less) cause a time-out exception.');
end;

procedure makeFileRequest(fileName: string; timeout: Integer);
var
  myUrl: _Uri;
  myFileWebRequest: _FileWebRequest;
  WebRequest: _WebRequestHelper;
  myException: EClrException;
begin
  try
    // Create a Uri object.
    myUrl := CoUri.CreateInstance('file://' + fileName);

    // Create a FileWebRequest object.
    WebRequest := CoWebRequestHelper.CreateInstance;
    myFileWebRequest := CoFileWebRequest.Wrap(WebRequest.CreateDefault(myUrl));

    // Set the time-out to the value selected by the user.
    myFileWebRequest.Timeout := timeout;

    // Set the Method property to POST
    myFileWebRequest.Method := 'POST';
  except
    on E: EOleSysError do
    begin
      myException := EClrException.Create(E.ErrorCode);
      if myException.IsTypeOf('System.Net.WebException') then
        Writeln('WebException: ' + E.Message)
      else if myException.IsTypeOf('System.UriFormatException') then
        Writeln('UriFormatWebException: ' + E.Message)
    end;
  end;
end;

procedure writeToFile;
var
  userInput: string;
  encoder: _ASCIIEncoding;
  byteArray: _ByteArray;
  contentLength: String;
  readStream: _Stream;
  myException: EClrException;
begin
  try
    // Enter the string to write to the file.
    WriteLn('Enter the string you want to write:');

    ReadLn(userInput);

    // Convert the string to a byte array.
    encoder := CoASCIIEncoding.CreateInstance;
    byteArray := encoder.GetBytes_5(userInput);

    // Set the ContentLength property.
    myFileWebRequest.ContentLength := byteArray.Length;

    contentLength := myFileWebRequest.ContentLength.ToString;

    WriteLn(#13#10+'The content length is %s.', contentLength);

    // Get the file stream handler to write to the file.
    readStream := myFileWebRequest.GetRequestStream;

    // Write to the file stream.
    // Note.  For this to work, the file must be accessible
    // on the network. This can be accomplished by setting the property
    // sharing of the folder containg the file.
    // FileWebRequest.Credentials property cannot be used for this purpose.
    readStream.Write(byteArray, 0, userInput.Length);
    WriteLn(#13#10+'The String you entered was successfully written to the file.');

    readStream.Close;
  except
    on E: EOleSysError do
    begin
      myException := EClrException.Create(E.ErrorCode);
      if myException.IsTypeOf('System.Net.WebException') then
        Writeln('WebException: ' + E.Message)
      else if myException.IsTypeOf('System.UriFormatException') then
        Writeln('UriFormatWebException: ' + E.Message);
    end;
  end;
end;

begin
  try
    if ParamCount < 2 then
      showUsage
    else
    begin
      makeFileRequest (ParamStr(0), StrToInt(ParamStr(1)));
      writeToFile;
    end;
   except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
