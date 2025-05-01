program AssemblyInformation;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}
{$R *.res}

uses
  System.SysUtils,
  CNClrLib.Host,
  CNClrLib.Core,
  CNClrLib.Enums;

var
  Console: _Console;
  myType: _Type;
  I: Integer;
  MemberInfoArray: _MemberInfoArray;
begin
  Console := CoConsole.CreateInstance;

  Console.WriteLine_14('Reflection.MemberInfo');

  // Get the Type and MemberInfo.
  // Insert the fully qualified class name inside the quotation marks in the
  // following statement.
  myType := TClrAssembly.GetType('System.IO.BinaryReader');
  MemberInfoArray := myType.GetMembers_1(BindingFlags_Public or
      BindingFlags_NonPublic or BindingFlags_Static or
      BindingFlags_Instance or BindingFlags_DeclaredOnly);

  // Get and display the DeclaringType method.
  Console.WriteLine_15('There are {0} documentable members in ', MemberInfoArray.Length);
  Console.WriteLine_15('{0}.', myType.FullName);

  for I := 0 to MemberInfoArray.Length - 1 do
    Console.WriteLine_14(MemberInfoArray[I].Name);

  Console.ReadKey;
end.

//Output

//Reflection.MemberInfo
//There are 43 documentable members in
//System.IO.BinaryReader.
//get_BaseStream
//Close
//Dispose
//Dispose
//PeekChar
//Read
//ReadBoolean
//ReadByte
//ReadSByte
//ReadChar
//ReadInt16
//ReadUInt16
//ReadInt32
//ReadUInt32
//ReadInt64
//ReadUInt64
//ReadSingle
//ReadDouble
//ReadDecimal
//ReadString
//Read
//InternalReadChars
//InternalReadOneChar
//ReadChars
//Read
//ReadBytes
//FillBuffer
//Read7BitEncodedInt
//.ctor
//.ctor
//.ctor
//BaseStream
//m_stream
//m_buffer
//m_decoder
//m_charBytes
//m_singleChar
//m_charBuffer
//m_maxCharsSize
//m_2BytesPerChar
//m_isMemoryStream
//m_leaveOpen
//MaxCharBytesSize
