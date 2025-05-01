program UploadFile;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.VisualBasic;

var
  Computer: _Computer;
begin
  try
    Computer := CoComputer.CreateInstance;

    // Upload a file.
    // Use the UploadFile method to upload a file, specifying the source file's location
    //  and the target directory location as a string or URI (Uniform Resource Identifier).
    //  This example uploads the file Order.txt to http://www.cohowinery.com/uploads.aspx.
    Computer.Network.UploadFile('C:\My Documents\Order.txt',
      'http://www.cohowinery.com/upload.aspx');

    // Upload a file and show the progress of the operation
    // Use the UploadFile method to upload a file, specifying the source file's location
    // and the target directory location as a string or URI. This example uploads the file
    // Order.txt to http://www.cohowinery.com/uploads.aspx without supplying a user name or password, shows the progress of the upload, and has a time-out interval of 500 milliseconds.
    Computer.Network.UploadFile_4('C:\My Documents\Order.txt',
      'http://www.cohowinery.com/upload.aspx', '', '', True, 500);

    // Upload a file, supplying a user name and password
    // Use the UploadFile method to upload a file, specifying the source file's location and
    // the target directory location as a string or URI, and specifying the user name and the
    // password. This example uploads the file Order.txt to http://www.cohowinery.com/uploads.aspx,
    // supplying the user name anonymous and a blank password.
    Computer.Network.UploadFile_2('C:\My Documents\Order.txt',
      'http://www.cohowinery.com/upload.aspx', 'anonymous', '');

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

