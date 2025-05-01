program HMACMD5_Example;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

//https://docs.microsoft.com/en-gb/dotnet/api/system.security.cryptography.hmacmd5?view=netframework-4.7.2

uses
  System.SysUtils,
  System.Win.ComObj,
  CNClrLib.EnumTypes,
  CNClrLib.Core,
  CNClrLib.Security;

  // Computes a keyed hash for a source file and creates a target file with the keyed hash
  // prepended to the contents of the source file.
  procedure SignFile(key: _ByteArray; sourceFile, destFile: String);
  var
    hmac: _HMACMD5;
    inStream, outStream: _FileStream;
    hashValue, buffer: _ByteArray;
    bytesRead: Integer;
  begin
    // Initialize the keyed hash object.
    hmac := CoHMACMD5.CreateInstance(key);
    inStream := CoFileStream.CreateInstance(sourceFile, fmOpen);
    outStream := CoFileStream.CreateInstance(destFile, fmCreate);

    // Compute the hash of the input file.
    hashValue := hmac.ComputeHash(inStream.AsStream);
    // Reset inStream to the beginning of the file.
    inStream.Position := 0;
    // Write the computed hash value to the output file.
    outStream.Write(hashValue, 0, hashValue.Length);
    // Copy the contents of the sourceFile to the destFile.
    // read 1K at a time
    buffer := CoByteArray.CreateInstance(1024);
    repeat
      // Read from the wrapping CryptoStream.
      bytesRead := inStream.Read(buffer, 0, 1024);
      outStream.Write(buffer, 0, bytesRead);
    until bytesRead = 0;

    outStream.Close;
    outStream.Dispose;

    inStream.Close;
    inStream.Dispose;

    hmac.Dispose;

    inStream := nil;
    hmac := nil;
  end;


  // Compares the key in the source file with a new key created for the data portion of the file. If the keys
  // compare the data has not been tampered with.
  function VerifyFile(key: _ByteArray; sourceFile: String): Boolean;
  var
    err: Boolean;
    hmac: _HMACMD5;
    inStream: _FileStream;
    storedHash, computedHash: _ByteArray;
    i: Integer;
  begin
    err := false;
    // Initialize the keyed hash object.
    hmac := CoHMACMD5.CreateInstance(key);
    // Create an array to hold the keyed hash value read from the file.
    storedHash := CoByteArray.CreateInstance(Round(hmac.HashSize / 8));
    // Create a FileStream for the source file.
    inStream := CoFileStream.CreateInstance(sourceFile, fmOpen);

    // Read in the storedHash.
    inStream.Read(storedHash, 0, storedHash.Length);
    // Compute the hash of the remaining contents of the file.
    // The stream is properly positioned at the beginning of the content,
    // immediately after the stored hash value.
    computedHash := hmac.ComputeHash(inStream.AsStream);
    // compare the computed hash with the stored value

    for i := 0 to storedHash.Length - 1 do
    begin
      if computedHash[i] <> storedHash[i] then
        err := true;
    end;

    inStream.Close;
    inStream.Dispose;

    hmac.Dispose;
    hmac := nil;
    if err then
    begin
      WriteLn('Hash values differ! Signed file has been tampered with!');
      Result := false;
    end
    else
    begin
      WriteLn('Hash values agree -- no tampering occurred.');
      Result := true;
    end;
  end;

var
  dataFile, signedFile: String;
  sw: _StreamWriter;
  pfile: _File;
  secretkey: _ByteArray;
  rng: _RNGCryptoServiceProvider;
begin
  try
    //If no file names are specified, create them.
    if ParamCount < 2 then
    begin
      dataFile := 'text.txt';
      signedFile := 'signedFile.enc';

      pfile := CoFile.CreateInstance;
      if not pfile.Exists(dataFile) then
      begin
        // Create a file to write to.
        sw :=  pfile.CreateText(dataFile);
        sw.WriteLine_12('Here is a message to sign');

        sw.Close;
        sw.Dispose;
        sw := nil;
      end;
    end
    else
    begin
      dataFile := ParamStr(0);
      signedFile := ParamStr(1);
    end;

    // Create a random key using a random number generator. This would be the
    //  secret key shared by sender and receiver.
    secretkey := CoByteArray.CreateInstance(64);
    //RNGCryptoServiceProvider is an implementation of a random number generator.
    rng := CoRNGCryptoServiceProvider.CreateInstance;
    try
      // The array is now filled with cryptographically strong random bytes.
      rng.GetBytes(secretkey);

      // Use the secret key to sign the message file.
      SignFile(secretkey, dataFile, signedFile);

      // Verify the signed file
      VerifyFile(secretkey, signedFile);
    finally
      rng.Dispose;
      rng := nil;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
