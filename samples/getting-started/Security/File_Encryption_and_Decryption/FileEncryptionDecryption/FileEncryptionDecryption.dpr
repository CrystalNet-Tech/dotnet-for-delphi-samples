program FileEncryptionDecryption;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.Core, CNClrLib.IO, CNClrLib.EnumTypes,
  CNClrLib.Security, CNClrLib.Host.Helper;


///<summary>
/// Encrypts a file using Rijndael algorithm.
///</summary>
///<param name="inputFile"></param>
///<param name="outputFile"></param>
procedure EncryptFile(inputFile, outputFile: string);
var
  password: string;
  UE: _UnicodeEncoding;
  key: _ByteArray;
  cryptFile: string;
  fsCrypt: _FileStream;
  RMCrypto: _RijndaelManaged;
  cs: _CryptoStream;
  fsIn: _FileStream;
  data: Integer;
begin
  try
    password := 'myKey123'; // Your Key Here
    UE := CoUnicodeEncoding.CreateInstance;
    key := UE.GetBytes_5(password);

    cryptFile := outputFile;
    fsCrypt := CoFileStream.CreateInstance(cryptFile, fmCreate);

    RMCrypto := CoRijndaelManaged.CreateInstance;

    cs := CoCryptoStream.CreateInstance(fsCrypt.AsStream, RMCrypto.CreateEncryptor(key, key), csmWrite);

    fsIn := CoFileStream.CreateInstance(inputFile, fmOpen);

    data := fsIn.ReadByte;
    while data <> -1 do
    begin
      cs.WriteByte(TClrConvert.ToByte(data));
      data := fsIn.ReadByte;
    end;

    fsIn.Close;
    cs.Close;
    fsCrypt.Close;
  except
    Writeln('Encryption failed!');
  end;
end;


///<summary>
/// Decrypts a file using Rijndael algorithm.
///</summary>
///<param name="inputFile"></param>
///<param name="outputFile"></param>
procedure DecryptFile(inputFile, outputFile: string);
var
  password: string;
  UE: _UnicodeEncoding;
  key: _ByteArray;
  fsCrypt: _FileStream;
  RMCrypto: _RijndaelManaged;
  cs: _CryptoStream;
  fsOut: _FileStream;
  data: Integer;
begin
  password := 'myKey123'; // Your Key Here

  UE := CoUnicodeEncoding.CreateInstance;
  key := UE.GetBytes_5(password);

  fsCrypt := CoFileStream.CreateInstance(inputFile, fmOpen);

  RMCrypto := CoRijndaelManaged.CreateInstance;

  cs := CoCryptoStream.CreateInstance(fsCrypt.AsStream, RMCrypto.CreateDecryptor(key, key), csmRead);

  fsOut := CoFileStream.CreateInstance(outputFile, fmCreate);

  data := cs.ReadByte;
  while data <> -1 do
  begin
    fsOut.WriteByte(TClrConvert.ToByte(data));
    data := cs.ReadByte;
  end;

  fsOut.Close;
  cs.Close;
  fsCrypt.Close;
end;

var
  inputFile1,
  inputFile2,
  outputFile1,
  outputFile2: string;
begin
  try
    inputFile1 := 'File2Encrypt.txt';
    outputFile1 := 'File2Encrypt.encrypt';

    EncryptFile(inputFile1, outputFile1);

    inputFile2 := outputFile1;
    outputFile2 := 'File2Encrypt2.txt';
    DecryptFile(inputFile2, outputFile2);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
