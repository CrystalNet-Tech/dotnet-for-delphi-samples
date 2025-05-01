# How to add, remove, and insert data in .Net generic List in Delphi.

This demo demonstrates how you can add, remove and insert data in .Net generic List in Delphi using the .Net Runtime Library for Delphi

The demo demonstrates several properties and methods of the .Net generic List  class of type string. The default constructor is used to create a list of strings with the default capacity. The Capacity property is displayed and then the Add method is used to add several items. The items are listed, and the Capacity property is displayed again, along with the Count property, to show that the capacity has been increased as needed.

The Contains method is used to test for the presence of an item in the list, the Insert method is used to insert a new item in the middle of the list, and the contents of the list are displayed again.

The default Item property (the indexer in C#) is used to retrieve an item, the Remove method is used to remove the first instance of the duplicate item added earlier, and the contents are displayed again. The Remove method always removes the first instance it encounters.

The TrimExcess method is used to reduce the capacity to match the count, and the Capacity and Count properties are displayed. If the unused capacity had been less than 10 percent of total capacity, the list would not have been resized.

Finally, the Clear method is used to remove all items from the list, and the Capacity and Count properties are displayed.