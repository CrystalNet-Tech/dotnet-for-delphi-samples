program GZipStream;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils,
  CNClrLib.Core,
  CNClrLib.Host.Helper,
  CNClrLib.IO,
  CNClrLib.EnumTypes,
  CNClrLib.Text;

//Compress/zip a string
function Zip(value: string): String;
var
  byteArray: _ByteArray;
  indexBA: Integer;
  item: Char;
  ms: _MemoryStream;
  sw: _GZipStream;
  sB: _StringBuilder;
  I: Integer;
begin
  //Transform string into byte[]
  byteArray := CoByteArray.CreateInstance(Length(value));
  indexBA := 0;
  for item in value do
  begin
    byteArray[indexBA] := TClrConvert.ToByte(TClrConvert.ToClrChar(item));
    Inc(indexBA);
  end;

  //Prepare for compress
  ms := CoMemoryStream.CreateInstance;
  sw := CoGZipStream.CreateInstance(ms.AsStream, cmCompress);

  //Compress
  sw.Write(byteArray, 0, byteArray.Length);
  //Close, DO NOT FLUSH cause bytes will go missing...
  sw.Close();

  //Transform byte[] zip data to string
  byteArray := ms.ToArray;
  sB := CoStringBuilder.CreateInstance(byteArray.Length);
  for I := 0 to byteArray.Length - 1 do
  begin
    sB.Append_7(TClrConvert.ToClrChar(byteArray[I]));
  end;

  ms.Close;
  sw.Dispose;
  ms.Dispose;
  Result := sB.ToString;
end;

//Decompress/Unzip a string: input value has been previously compressed with GZipStream.
function UnZip(value: string): String;
var
  byteArray: _ByteArray;
  indexBA: Integer;
  item: Char;
  ms: _MemoryStream;
  sr: _GZipStream;
  sB: _StringBuilder;
  rByte, I: Integer;
begin
  //Transform string into byte[]
  byteArray := CoByteArray.CreateInstance(Length(value));
  indexBA := 0;
  for item in value do
  begin
    byteArray[indexBA] := TClrConvert.ToByte(TClrConvert.ToClrChar(item));
    Inc(indexBA);
  end;

  //Prepare for decompress
  ms := CoMemoryStream.CreateInstance(byteArray);
  sr := CoGZipStream.CreateInstance(ms.AsStream, cmDecompress);

  //Reset variable to collect uncompressed result
  byteArray := CoByteArray.CreateInstance(byteArray.Length);

  //Decompress
  rByte := sr.Read(byteArray, 0, byteArray.Length);

  //Transform byte[] unzip data to string
  sB := CoStringBuilder.CreateInstance(rByte);
  //Read the number of bytes GZipStream red and do not a for each bytes in
  //resultByteArray;
  for I := 0 to rByte -1 do
  begin
    sB.Append_7(TClrConvert.ToClrChar(byteArray[I]));
  end;

  sr.Close;
  ms.Close;
  sr.Dispose;
  ms.Dispose;
  Result := sB.ToString;
end;


var
  originalValue: String;
  compressValue: String;
  decompressValue: string;
begin
  try
    originalValue := 'Value for money';
    Writeln('Original Value: ', originalValue);

    compressValue := Zip(originalValue);
    Writeln('Compressed Value: ', compressValue);

    decompressValue := UnZip(compressValue);
    Writeln('Decompressed Value: ', decompressValue);

    Writeln('Original and Decompressed Values are the same : ', BoolToStr(SameStr(originalValue, decompressValue), True));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
