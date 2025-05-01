program GetAttrFunction;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, ActiveX, CNClrLib.VisualBasic, CNClrLib.Enums;

var
  FileSystem: _FileSystem_VB;
  MyAttr: FileAttribute;
  normalReadonly: FileAttribute;
begin
  try
    FileSystem := CoFileSystem_VB.CreateInstance;
    // Assume file TESTFILE is normal and readonly.
    MyAttr := FileSystem.GetAttr('C:\TESTFILE.txt'); // Returns vbNormal.

    // Test for normal.
    If (MyAttr And FileAttribute_Normal) = FileAttribute_Normal Then
      Writeln('This file is normal.');

    // Test for normal and readonly.
    normalReadonly := FileAttribute_Normal Or FileAttribute_ReadOnly;
    If (MyAttr And normalReadonly) = normalReadonly Then
      Writeln('This file is normal and readonly.');

    // Assume MYDIR is a directory or folder.
    MyAttr := FileSystem.GetAttr('C:\MYDIR');
    If (MyAttr And FileAttribute_Directory) = FileAttribute_Directory Then
      Writeln('MYDIR is a directory');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
