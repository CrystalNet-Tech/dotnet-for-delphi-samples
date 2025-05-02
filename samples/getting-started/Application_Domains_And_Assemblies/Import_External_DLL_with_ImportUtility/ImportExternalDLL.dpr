program ImportExternalDLL;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  CNClrLib.Core,
  Mathematics.Consts in 'Mathematics.Consts.pas',
  Mathematics.Intf in 'Mathematics.Intf.pas',
  Mathematics in 'Mathematics.pas';

var
  Console : _Console;
  Mathematics : IMathematics;
begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program demonstrate how to Import utility to import external DLL and integrate the generated .Net types into Delphi');
  Console.WriteLine;
  try
    Mathematics := TMathematics.Create;

    Console.WriteLine_15('Add(30, 50):      {0}', Mathematics.Add(30, 50));
    Console.WriteLine_15('Subtract(30, 50): {0}', Mathematics.Subtract(30, 50));
    Console.WriteLine_15('Equal(30, 50):    {0}', Mathematics.Equal(30, 50));
    Console.WriteLine_15('Equal(50, 50):    {0}', Mathematics.Equal(50, 50));
  except
    on E: Exception do
      Console.WriteLine_15('Exception: {0}', e.Message);
  end;
  Console.ReadKey;
end.
