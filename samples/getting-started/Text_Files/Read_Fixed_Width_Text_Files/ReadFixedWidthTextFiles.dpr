program ReadFixedWidthTextFiles;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.VisualBasic, CNClrLib.Enums, CNClrLib.Host, System.Win.ComObj;

var
  Reader: _TextFieldParser;
  currentRow:_StringArray;
  I: Integer;
  clrException: EClrException;
begin
  try
    // Create a new TextFieldParser. The following code creates the TextFieldParser named Reader and opens the file test.log.
    Reader := CoTextFieldParser.CreateInstance('C:\TestFolder\test.log');
    try
      // Define the TextFieldType property as FixedWidth, defining the width and format. The following code defines the columns of text;
      // the first is 5 characters wide, the second 10, the third 11, and the fourth is of variable width.
      Reader.TextFieldType := FieldType_FixedWidth;
      Reader.SetFieldWidths(TClrArrayHelper.ToInt32Array([5, 10, 11, -1]));

      // Loop through the fields in the file. If any lines are corrupted, report an error and continue parsing.
      while not Reader.EndOfData do
      begin
        try
          currentRow := Reader.ReadFields;
          for I := 0 to currentRow.Length - 1 do
          begin
            Writeln(currentRow[I]);
          end;
        except
          on Ex: EOleSysError do
          begin
            clrException := EClrException.Create(Ex.ErrorCode);
            if clrException.IsTypeOf(' Microsoft.VisualBasic.FileIO.MalformedLineException') then
              Writeln('Line ' + Ex.Message + ' is not valid and will be skipped.');
          end;
        end;
      end;
    finally
      Reader.Close;
      Reader.Dispose;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

