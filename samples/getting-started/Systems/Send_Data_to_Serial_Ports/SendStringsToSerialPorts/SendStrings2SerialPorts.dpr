program SendStrings2SerialPorts;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.VisualBasic, CNClrLib.IO;

var
  Computer: _Computer;
  com1: _SerialPort;
begin
  try
    Computer := CoComputer.CreateInstance;
    com1 := Computer.Ports.OpenSerialPort('COM1');
    try
      // The WriteLine method sends the data to the serial port.
      com1.WriteLine('MyData');    
    finally
      // Close and dispose the serial port
      com1.Close;
      com1.Dispose;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
