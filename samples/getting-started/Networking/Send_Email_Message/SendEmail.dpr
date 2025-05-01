program SendEmail;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN HIDING_MEMBER OFF}

{$R *.res}

uses
  System.SysUtils, CNClrLib.Common, CNClrLib.Core, CNClrLib.Host,
  CNClrLib.Net, CNClrLib.ComponentModel, CNClrLib.Text, CNClrLib.Host.Helper;


type
  TSimpleAsynchronousExample = class
  private
    class var mailSent: Boolean;
    class procedure SendCompletedCallback(sender: Olevariant; e: _AsyncCompletedEventArgs);
  end;

{ TSimpleAsynchronousExample }

procedure TSimpleAsynchronousExample_SendCompletedCallback(
  sender: _ClrObject; e: _ClrEventArgs); stdcall;
var
 	evtArg: _AsyncCompletedEventArgs;
begin
	evtArg := CoAsyncCompletedEventArgs.Wrap(e.EventArgs);
  TSimpleAsynchronousExample.SendCompletedCallback(sender, evtArg);
end;

class procedure TSimpleAsynchronousExample.SendCompletedCallback(
  sender: Olevariant; e: _AsyncCompletedEventArgs);
var
  token: string;
begin
  // Get the unique identifier for this asynchronous operation.
  token := e.UserState;

  if e.Cancelled then
    Writeln('[%s] Send canceled.', token);

  if e.Error <> nil then
    Writeln('[%s] %s', token, e.Error.ToString)
  else
    Writeln('Message sent.');

  mailSent := true;
end;

var
  client: _SmtpClient;
  from: _MailAddress;
  to_: _MailAddress;
  message: _MailMessage;
  encodingHelper: _EncodingHelper;
  standardEventHandler: TClrEventHandler;
  eventSenderObj: TSimpleAsynchronousExample;
  userState,
  answer: string;
begin
  try
     //Create static encoding interface;
    encodingHelper := CoEncodingHelper.CreateInstance;
    TSimpleAsynchronousExample.mailSent := False;
    // Command line argument must the the SMTP host.
    client := CoSmtpClient.CreateInstance(ParamStr(0));

    // Specify the e-mail sender.
    // Create a mailing address that includes a UTF8 character
    // in the display name.
    from := CoMailAddress.CreateInstance('jane@contoso.com', 'Jane Clayton', encodingHelper.UTF8);

    // Set destinations for the e-mail message.
    to_ := CoMailAddress.CreateInstance('ben@contoso.com');

    // Specify the message content.
    message := CoMailMessage.CreateInstance(from, to_);
    message.Body := 'This is a test e-mail message sent by an application. \n\r';
    message.BodyEncoding := encodingHelper.UTF8;
    message.Subject := 'test message 1';
    message.SubjectEncoding := encodingHelper.UTF8;

    // Set the method that is called back when the send operation ends.
    eventSenderObj := TSimpleAsynchronousExample.Create;
    standardEventHandler := TSimpleAsynchronousExample_SendCompletedCallback;
    client.Add_SendCompleted_1(TClrConvert.ToManagedPointer(@eventSenderObj),
      TClrConvert.ToManagedPointer(@standardEventHandler));

    // The userState can be any object that allows your callback
    // method to identify this send operation.
    // For this example, the userToken is a string constant.
    userState := 'test message1';
    client.SendAsync_2(message, userState);
    Writeln('Sending message... press c to cancel mail. Press any other key to exit.');

    Readln(answer);

    // If the user canceled the send, and mail hasn't been sent yet,
    // then cancel the pending operation.
    if answer.StartsWith('c') and not TSimpleAsynchronousExample.mailSent then
      client.SendAsyncCancel();

    // Clean up.
    message.Dispose();

    WriteLn('Goodbye.');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
