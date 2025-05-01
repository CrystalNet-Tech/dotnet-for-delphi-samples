# How to create a WebRequest instance and return the response.
The following demo shows how to create a WebRequest instance and return the response.

The following demo shows how to create a WebRequest(https://docs.microsoft.com/en-gb/dotnet/api/system.net.webrequest?view=netframework-4.7.2) instance and return the response.


WebRequest is the abstract base class for .NET's request/response model for accessing data from the Internet. An application that uses the request/response model can request data from the Internet in a protocol-agnostic manner, in which the application works with instances of the WebRequest class while protocol-specific descendant classes carry out the details of the request.

Requests are sent from an application to a particular URI, such as a Web page on a server. The URI determines the proper descendant class to create from a list of WebRequest descendants registered for the application. WebRequest descendants are typically registered to handle a specific protocol, such as HTTP or FTP, but can be registered to handle a request to a specific server or path on a server.

Because the WebRequest class is an abstract class, the actual behavior of WebRequest instances at run time is determined by the descendant class returned by Create method which can be HttpWebRequest and FileWebRequest.