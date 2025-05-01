program RetrieveStringsFromSerialPorts;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.VisualBasic, CNClrLib.IO;

var
  Computer: _Computer;
  returnStr, Incoming: String;
  com1: _SerialPort;
begin
  try
    Computer := CoComputer.CreateInstance;

    // Initialize the return string.
    returnStr :=  '';

    com1 := nil;
    try
      try
        // Determine which serial port should provide the strings. This example assumes it is COM1.
        // Use the My.Computer.Ports.OpenSerialPort method to obtain a reference to the port.
        com1 := Computer.Ports.OpenSerialPort('COM1');
        com1.ReadTimeout := 10000;

        // Create a While loop for reading lines of text until no more lines are available.
        while True do
        begin
          // Use the ReadLine method to read the next available line of text from the serial port.
          Incoming := com1.ReadLine;

          // Use an If statement to determine if the ReadLine method returns empty string (which means no more text is available).
          // If it does return empty string (''), exit the While loop.
          if Incoming = '' then
            break;

          // Append the string from the serial port to the return string.
          returnStr := returnStr + Incoming + #13#10;
        end;
      except
      // ex As TimeoutException
       //   returnStr = "Error: Serial Port read timed out."
      end;
    finally
      // Close and dispose the serial port
      If com1 <> nil then
      begin
        com1.Close;
        com1.Dispose;
      end;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
