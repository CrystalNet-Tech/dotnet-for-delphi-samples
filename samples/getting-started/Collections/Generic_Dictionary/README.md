### How to use .Net Generic Dictionary in Delphi

The sample shows how to use .Net Generic Dictionary in Delphi to add data, remove data and enumerate though the data stored in the generic dictionary.

The demo creates an empty .Net Generic Dictionary(called **_GenericDictionary**) of strings with string keys and uses the Add method to add some elements. 

The demo shows how the Add method throws an ArgumentException when attempting to add a duplicate key. The demo uses the Item property (the indexer in C#) to retrieve values, demonstrating that a **KeyNotFoundException** is thrown when a requested key is not present, and showing that the value associated with a key can be replaced. 

The demo shows how to use the **TryGetValue** method as a more efficient way to retrieve values if a program often must try key values that are not in the dictionary, and it shows how to use the ContainsKey method to test whether a key exists before calling the Add method.

The demo also shows how to enumerate the keys and values in the dictionary and how to enumerate the keys and values alone using the Keys property and the Values property.

Finally, the demo demonstrates the Remove method.
