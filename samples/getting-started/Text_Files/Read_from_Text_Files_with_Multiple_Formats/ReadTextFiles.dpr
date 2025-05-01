program ReadTextFiles;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.VisualBasic, CNClrLib.Enums, CNClrLib.Host, System.Win.ComObj;

var
  stdFormat: TArray<integer>;
  errorFormat: TArray<integer>;
  MyReader: _TextFieldParser;
  currentRow:_StringArray;
  rowType: String;
  I: Integer;
  clrException: EClrException;
begin
  try
    // Define the expected format and the format used when an error is reported.
    // The last entry in each array is -1, therefore the last field is assumed to be
    // of variable width. This occurs when the last entry in the array is less than or equal to 0.
    stdFormat := [5, 10, 11, -1];
    errorFormat := [5, 5, -1];

    // Create a new TextFieldParser object, defining the width and format.
    MyReader := CoTextFieldParser.CreateInstance('C:\TestFolder\testfile.txt');
    try
      MyReader.TextFieldType := FieldType_FixedWidth;
      MyReader.FieldWidths := TClrArrayHelper.ToInt32Array(stdFormat);

      // Loop through the rows, testing for format before reading.
      while not MyReader.EndOfData do
      begin
        try
          rowType := MyReader.PeekChars(3);
          If CompareText(rowType, 'Err') = 0 Then
          begin
            // If this line describes an error, the format of the row will be different.
            MyReader.SetFieldWidths(TClrArrayHelper.ToInt32Array(errorFormat));
          end
          else
          begin
            // Otherwise parse the fields normally
            MyReader.SetFieldWidths(TClrArrayHelper.ToInt32Array(stdFormat));
          end;

          currentRow := MyReader.ReadFields;
          for I := 0 to currentRow.Length - 1 do
          begin
            Write(currentRow[I] + '|');
          end;
          Writeln;
        except
          on Ex: EOleSysError do
          begin
            // Write errors to the console.
            clrException := EClrException.Create(Ex.ErrorCode);
            if clrException.IsTypeOf(' Microsoft.VisualBasic.FileIO.MalformedLineException') then
              Writeln('Line ' + Ex.Message + ' is invalid.  Skipping');
          end;
        end;
      end;
    finally
      MyReader.Close;
      MyReader.Dispose;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
