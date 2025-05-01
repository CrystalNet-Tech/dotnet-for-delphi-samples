program DownloadFile;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.VisualBasic;

var
  Computer: _Computer;
begin
  try
    // The DownloadFile method can be used to download a remote file and store it to a specific location.
    // If the ShowUI parameter is set to True, a dialog box is displayed showing the progress of the download
    // and allowing users to cancel the operation. By default, existing files having the same name are not overwritten;
    // if you want to overwrite existing files, set the overwrite parameter to True.

    Computer := CoComputer.CreateInstance;
    // download a file
    Computer.Network.DownloadFile('http://www.cohowinery.com/downloads/WineList.txt',
      'C:\Documents and Settings\All Users\Documents\WineList.txt');

    // download a file, supplying a user name and password
    Computer.Network.DownloadFile_2('http://www.cohowinery.com/downloads/WineList.txt',
      'C:\Documents and Settings\All Users\Documents\WineList.txt', 'anonymous', '');

    // Security Note
    // The FTP protocol used by the DownLoadFile method sends information,
    // including passwords, in plain text and should not be used for transmitting
    // sensitive information.
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
