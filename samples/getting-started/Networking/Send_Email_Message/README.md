### How to send an e-mail message asynchronously using .Net SmtpClient in Delphi

The sample how to send an e-mail message asynchronously with the .Net SmtpClient in Delphi using the [.Net Runtime Library for Delphi](https://crystalnet-tech.com/RuntimeLibrary/RuntimeLibrary4Delphi.aspx).

The **SmtpClient** interface is used to send e-mail to an SMTP server for delivery. The SMTP protocol is defined in RFC 2821, which is available at http://www.ietf.org.

To construct and send an e-mail message by using SmtpClient, you must specify the following information:
* The SMTP host server that you use to send e-mail. See the Host and Port properties.
Credentials for authentication, if required by the SMTP server. See the Credentials property.
* The e-mail address of the sender. See the Send and SendAsync methods that take a from parameter. Also see the MailMessage.From property.
* The e-mail address or addresses of the recipients. See the Send and SendAsync methods that take a recipient parameter. Also see the MailMessage.To property.
* The message content. See the Send and SendAsync methods that take a body parameter. Also see the MailMessage.Body property.

To include an attachment with an e-mail message, first create the attachment by using the Attachment interface, and then add it to the message by using the **MailMessage.Attachments** property. Depending on the e-mail reader used by the recipients and the file type of the attachment, some recipients might not be able to read the attachment. For clients that cannot display the attachment in its original form, you can specify alternate views by using the **MailMessage.AlternateViews** property.

To send the e-mail message and block while waiting for the e-mail to be transmitted to the SMTP server, use one of the synchronous Send methods. To allow your program's main thread to continue executing while the e-mail is transmitted, use one of the asynchronous **SendAsync** methods. The **Add_SendCompleted** event method raises the event parameter when a SendAsync operation completes. To receive this event, you must add a **SendCompletedEventHandler** delegate to Add_SendCompleted method. The **SendCompletedEventHandler** delegate must reference a callback method that handles notification of SendCompleted events. To cancel an asynchronous e-mail transmission, use the **SendAsyncCancel** method.
