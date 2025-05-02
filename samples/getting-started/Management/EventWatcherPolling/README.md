### Show synchronous consumption of system events in Delphi

The sample shows how to show synchronous consumption of events in Delphi using the [.Net Runtime Library for Delphi](https://crystalnet-tech.com/RuntimeLibrary/RuntimeLibrary4Delphi.aspx)

The sample shows how the client receives notification when an instance of **Win32_Process** is created because the event class is ___InstanceCreationEvent_.

The client receives events synchronously by calling the **WaitForNextEvent** method. This example can be tested by starting a process, such as Notepad, while the example code is running.
