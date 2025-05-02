# How to create Instance of .Net Objects

In order to interact with .Net Objects's methods, properties, Fields and events, you need to create an instance of the object. There are several ways to Create an Instance of a .Net Object in Delphi using the .Net Runtime Library for Delphi.

n order to interact with .Net Objects's methods, properties, Fields and events, you need to create an instance of the object. There are several ways to Create an Instance of a .Net Object in Delphi using the .Net Runtime Library for Delphi. These are:

### Using Reflection
* Using Common Language Runtime Object (ClrObject)
* Using Constructor CoClasses

### Using Reflection to Create instance of .Net Objects
There are several classes and methods that can be used to create instances of .Net Objects. The mechanism used to create these instances is through reflection. 
The following methods can be used to create instances of .Net Objects through reflections: 

* **TClrAppDomain.CreateInstance**: This method creates a new instance of the specified type defined in the specified assembly. 
* **TClrAppDomain.CreateInstanceFrom**: This method creates a new instance of a specified type defined in the specified assembly file. 
* **TClrAppDomain.CreateComInstanceFrom**: This method creates a new instance of a specified COM type. Parameters specify the name of a file that contains an assembly containing the type and the name of the type. 
* **All Create Instance Methods in TClrActivator class**: The class contains methods to create types of objects locally or remotely, or obtain references to existing remote objects. 
* **All the Methods in TClrDispatchActivator Class**: The class contains methods to create types of objects and return type will be Dispatch Interface instead of Unknown Variant (IUnknown). These create instance methods in this class are required if you want ot create a library in .net with DispIDs and access them directly in delphi using dispinterfaces.
* **TClrAssembly.CreateInstance:** This method locates a type from the assembly loaded and create an instance of it using the system activator. 

### Using Common Object Runtime Object (ClrObject) to create and wrap .Net Object
This is a wrapper interface which provides low-level services to all interfaces defined in the Delphi Framework Library and .net objects. The ClrObject interface has methods and properties which allows you to interact with the properties, fields, events and methods of the object to which the interface is wrapped. The process of retrieving the members of the internal object is smooth and fast. For more information see How to Use ClrObject Interface. There are 2 ways to create instances of .Net Objects using the ClrObject. <br>
These are:
* Inherit from TClrBaseObject Class and create your own methods and properties for the class. 
* Use the ClrObject Interface to create wrapper instance of the original object to allow easy access and interactions to the objects members (Fields, Properties, Members, and Events etc.). 

### Using Constructor CoClasses
There are several classes defined in the Runtime library for creating instances of the .net framework types. These classes are called **CoClasses**. <br>
For example, to create an instance of _System.IO.FileStream(string path, FileMode mode)_ using [.Net Runtime Library for Delphi](https://crystalnet-tech.com/RuntimeLibrary/RuntimeLibrary4Delphi), use the equivalent interface of System.IO.FileStream which is __FileStream_ defined in **CNClrLib.Core** to create an instance of the __FileStream_ using the FileStream coClass called **coFileStream** class. <br>
The class has static methods called CreateInstance and each method represent the constructors defined for the System.io.FileStream.

<br>
<br>
<br>


