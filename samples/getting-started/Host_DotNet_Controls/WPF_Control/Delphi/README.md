Host WPF Composite Control in Delphi VCL Forms

This demo demonstrates how to host WPF Composite Control packaged into a .Net library in Delphi using the .Net Runtime Library for Delphi TClrContainer component.

This demo demonstrates how to host WPF Composite Control packaged into a .Net library in Delphi using the .Net Runtime Library for Delphi TClrContainer component.

This walkthrough steps you through an application that hosts a WPF composite control to perform data-entry in a Delphi VCL Forms application. The WPF composite control is packaged in a DLL. This general procedure can be extended to more complex applications and controls.

The walkthrough is divided into two sections. The first section briefly describes the implementation of the WPF composite control in C#. The second section discusses in brief how to host the composite control in a Delphi VCL Forms application, receive events from the control, and access some of the control’s properties. The demo contains a working example of how the WPF control in MyControl.dll is hosted in a Delphi VCL Forms using the TClrContainer component which is dropped unto the Delphi VCL Form.

Tasks illustrated in this walkthrough include:
Implementing the WPF composite control.
Implementing the Delphi VCL Forms host application.

Prerequisites: 
You need the following components to complete this walkthrough:
Delphi XE or higher
.Net Runtime Library for Delphi(https://www.crystalnet-tech.com/RuntimeLibrary/RuntimeLibrary4Delphi)

Implementing the WPF composite control.
Assuming you have created WPF composite control and packaged in a DLL. See example in demo: MyControls.dll is the WPF composite control compiled into .Net Library
with the source which is also part of the demo. For more information, go to Walkthrough: Hosting a WPF Composite Control in Windows Forms(https://docs.microsoft.com/en-us/dotnet/framework/wpf/advanced/walkthrough-hosting-a-wpf-composite-control-in-windows-forms)

Implementing the Delphi VCL Forms host application
The Delphi VCL Forms host application uses an TClrContainer together with TElementHost object in WindowsFormsIntegration unit to host the WPF composite control in the dll. The application handles the OnButtonClick event to receive the data from the composite control.The application also has a set of option buttons that you can use to modify the control’s appearance.
