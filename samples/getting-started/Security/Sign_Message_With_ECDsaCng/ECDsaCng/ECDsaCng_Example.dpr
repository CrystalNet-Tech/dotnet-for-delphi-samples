program ECDsaCng_Example;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

//See the C# Code Example at https://docs.microsoft.com/en-gb/dotnet/api/system.security.cryptography.ecdsacng?view=netframework-4.7.2

uses
  System.SysUtils,
  CNClrLib.EnumTypes,
  CNClrLib.Host,
  CNClrLib.Core,
  CNClrLib.Security;

var
  key: _ByteArray;
  dsa: _ECDsaCng;
  data: _ByteArray;
  signature: _ByteArray;
  
  procedure Receive(data, signature: _byteArray);
  var
    ecsdKey: _ECDsaCng;
  begin
    ecsdKey := CoECDsaCng.CreateInstance(CoCngKeyHelper.CreateInstance.Import(key,
      CoCngKeyBlobFormatHelper.CreateInstance.EccPublicBlob));
    try
      if ecsdKey.VerifyData(data, signature) then
        WriteLn('Data is good')
      else
        WriteLn('Data is bad');
    finally
      ecsdKey.Dispose;
      ecsdKey := nil;
    end;
  end;

var
  byteArray: TClrByteDynArray;
begin
  try
    dsa := CoECDsaCng.CreateInstance;
    try
      dsa.HashAlgorithm := CoCngAlgorithmHelper.CreateInstance.Sha256;
      key := dsa.Key.Export(CoCngKeyBlobFormatHelper.CreateInstance.EccPublicBlob);

      SetLength(byteArray, 5);
      byteArray[0] := 21;
      byteArray[1] := 5;
      byteArray[2] := 8;
      byteArray[3] := 12;
      byteArray[4] := 207;
      data := TClrArrayHelper.ToByteArray(byteArray);
      signature := dsa.SignData(data);
      Receive(data, signature);      
    finally
      dsa.Dispose;
      dsa := nil;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
