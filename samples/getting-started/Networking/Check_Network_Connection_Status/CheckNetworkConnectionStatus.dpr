program CheckNetworkConnectionStatus;

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
    if Computer.Network.IsAvailable then
      Write('Computer is connected.')
    else
      Write('Computer is not connected.');

    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
