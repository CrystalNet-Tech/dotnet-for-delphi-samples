program ImportExternalDLL;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Mathematics.Consts in 'Mathematics.Consts.pas',
  Mathematics.Intf in 'Mathematics.Intf.pas',
  Mathematics in 'Mathematics.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
