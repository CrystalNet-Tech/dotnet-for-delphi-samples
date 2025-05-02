### Load external .Net DLL and access the members of loaded assembly types from Delphi

This sample demonstrates how to load an external dll (_Mathematics.dll_) and access the methods on the loaded assembly types through dispatch interface. 

The .Net library C# Source code class members are decorated with DispIdAttribute which specifies the COM dispatch identifier (DISPID) of the method, field, or property.

```csharp
namespace Mathematics
{
    public class Mathematics
    {
        [DispId(0)]
        public int Add(int a, int b)
        {
            return a + b;
        }
        .....
    }
}
  ```

Create a corresponding Delphi DispInterface type of Mathematics type in the Mathematics.dll
```pascal
type
  _Mathematics = dispinterface
  ['{D77959BD-C7AC-4D65-9980-A88510F776B8}']
    function Add(a, b : Integer) : Integer; dispid 0;
    ...
  end;
```

To load the 3rd party (_Mathematics.dll_) assembly, call the **Load** method on the _TClrAssembly_ class in _CNClrLib.Host.pas_
```pascal
TClrAssembly.LoadFrom('Mathematics.dll');  
```

To create an instance of the Mathematic Type, call the CreateInstance method on the TClrDispatchActivator class
```pascal
var
  Mathematics : _Mathematics;

Mathematics := _Mathematics(TClrDispatchActivator.CreateInstance('Mathematics.Mathematics'));
```

Once the Mathematics object has been ceated, you can now call the methods on the object.
```pascal
Mathematics.Add(30, 50);
```

<br>
<br>
<br>


