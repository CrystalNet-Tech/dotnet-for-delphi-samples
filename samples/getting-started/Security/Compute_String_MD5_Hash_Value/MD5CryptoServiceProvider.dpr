program MD5CryptoServiceProvider;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

{$R *.res}

//See C# code example at https://docs.microsoft.com/en-gb/dotnet/api/system.security.cryptography.md5?view=netframework-4.7.2
uses
  System.SysUtils,
  CNClrLib.Host.Helper,
  CNClrLib.Enums,
  CNClrLib.Core,
  CNClrLib.Security;

  // Hash an input string and return the hash as
  // a 32 character hexadecimal string.
  function getMd5Hash(input: string): String;
  var
    md5Hasher: _MD5CryptoServiceProvider;
    data: _ByteArray;
    sBuilder: _StringBuilder;
    I: Integer;
  begin
    // Create a new instance of the MD5CryptoServiceProvider object.
    md5Hasher := CoMD5CryptoServiceProvider.CreateInstance;

    // Convert the input string to a byte array and compute the hash.
    data := md5Hasher.ComputeHash_1(CoEncodingHelper.CreateInstance.Default_.GetBytes_3(input));

    // Create a new Stringbuilder to collect the bytes
    // and create a string.
    sBuilder := CoStringBuilder.CreateInstance;

    // Loop through each byte of the hashed data
    // and format each one as a hexadecimal string.
    for I := 0 to data.Length - 1 do
      sBuilder.Append_2(TClrByteHelper.ToString(data[i], 'x2'));

    // Return the hexadecimal string.
    Result := sBuilder.ToString;
  end;

  // Verify a hash against a string.
  function verifyMd5Hash(input, hash: string): Boolean;
  var
    hashOfInput: String;
    comparer: _StringComparer;
  begin
    // Hash the input.
    hashOfInput := getMd5Hash(input);

    // Create a StringComparer an compare the hashes.
    comparer := CoStringComparerHelper.CreateInstance.OrdinalIgnoreCase;

    Result := comparer.Compare_2(hashOfInput, hash) = 0;
  end;

var
  source, hash: String;
begin
  try
    source := 'Hello World!';
    hash := getMd5Hash(source);

    WriteLn('The MD5 hash of ' + source + ' is: ' + hash + '.');
    WriteLn('Verifying the hash...');

    if verifyMd5Hash(source, hash) then
      WriteLn('The hashes are the same.')
    else
      WriteLn('The hashes are not same.');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
