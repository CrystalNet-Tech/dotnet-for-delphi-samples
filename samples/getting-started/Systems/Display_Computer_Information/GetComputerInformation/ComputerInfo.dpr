program ComputerInfo;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.VisualBasic,CNClrLib.Enums;

var
  computer: _Computer;
begin
  try
    computer := CoComputer.CreateInstance;

    // Play Audio Song
    computer.Audio.Play_1('C:\CompleteSong.wav', AudioPlayMode_WaitToComplete);

    // Get Computer Name
    Writeln('Computer Name: ', computer.Name);

    // Get Local Time;
    Writeln('Local DateTime: ', computer.Clock.LocalTime);

    // Get GMT Time;
    Writeln('GMT DateTime: ', computer.Clock.GmtTime);

    // Get Total Physical Memory
    Writeln('Total Physical Memory: ',computer.Info.TotalPhysicalMemory);

    // Get Available Physical Memory
    Writeln('Available Physical Memory: ', computer.Info.AvailablePhysicalMemory);

    // Get Total Virtual Memory
    Writeln('Total Virtual Memory: ', computer.Info.TotalVirtualMemory);

    // Get Available Virtual Memory
    Writeln('Available Virtual Memory: ', computer.Info.AvailableVirtualMemory);

    // Get OS Fullname
    Writeln('OS FullName: ', computer.Info.OSFullName);

    // Get OS Platform
    Writeln('OS Platform: ', computer.Info.OSPlatform);

    // Get OS Version
    Writeln('OS Version: ', computer.Info.OSVersion);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
