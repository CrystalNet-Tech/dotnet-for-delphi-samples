How to load .Net Assemblies from Delphi
There are several ways to load an assembly into an application domain using the .Net Runtime Library for Delphi. The recommended way is to use the static Load method of the TClrAssembly class (Declared in CNClrLib.Host unit).

There are several ways to load an assembly into an application domain using the .Net Runtime Library for Delphi. The recommended way is to use the static Load method of the TClrAssembly class (declared in CNClrLib.Host unit). Other ways assemblies can be loaded include:


The LoadFrom method of the TClrAssembly class loads an assembly given its file location. Loading assemblies with this method uses a different load context.
The LoadWithPartialName method loads an assembly given the partial assembly name.
Methods such as CreateInstance of the TClrAppDomain class can load assemblies into an application domain.
The Load method of the TClrAppDomain class can load assemblies, but is primarily used for COM interoperability. It should not be used to load assemblies into an application domain other than the application domain from which it is called.
The demo shows how to loads an assembly named "example.exe" or "example.dll" into the current application domain, gets a type named Example from the assembly, gets a parameterless method named MethodA for that type, and executes the method.
