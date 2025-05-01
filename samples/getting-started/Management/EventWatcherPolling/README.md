# Show synchronous consumption of system events in Delphi
The demo shows how to show synchronous consumption of events in Delphi using the .Net Runtime Library for Delphi

The demo shows how the client receives notification when an instance of Win32_Process is created because the event class is __InstanceCreationEvent.
The client receives events synchronously by calling the WaitForNextEvent method. This example can be tested by starting a process, such as Notepad, while the example code is running.