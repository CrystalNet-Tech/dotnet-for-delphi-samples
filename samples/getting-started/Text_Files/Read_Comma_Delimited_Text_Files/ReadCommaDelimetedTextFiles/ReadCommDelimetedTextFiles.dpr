program ReadCommDelimetedTextFiles;

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
  stringDynArray: TClrWStringDynArray;
begin
  try
    // Create a new TextFieldParser. The following code creates the TextFieldParser
    // named Reader and opens the file test.txt.
    Reader := CoTextFieldParser.CreateInstance('C:\TestFolder\test.txt');
    try
      Setlength(stringDynArray, 1);
      stringDynArray[0] := ',';
      // Define the TextField type and delimiter. The following code defines the
      // TextFieldType property as Delimited and the delimiter as ",".
      Reader.TextFieldType := FieldType_Delimited;
      Reader.SetDelimiters(TClrArrayHelper.ToStringArray(stringDynArray));

      // Loop through the fields in the file. If any lines are corrupt, report an
      // error and continue parsing. The following code loops through the file,
      // displaying each field in turn and reporting any fields that are formatted incorrectly.
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


