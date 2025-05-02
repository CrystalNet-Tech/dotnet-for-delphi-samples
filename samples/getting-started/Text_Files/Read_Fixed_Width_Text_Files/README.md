### How to Read From Fixed-width Text Files in Delphi

The sample shows how to open and read Fixed-width log file (_test.log_).

The sample uses **TextFieldParser** object which provides a way to easily and efficiently parse structured text files, such as logs. The TextFieldType property defines whether the parsed file is a delimited file or one that has fixed-width fields of text. In a fixed-width text file, the field at the end can have a variable width. To specify that the field at the end has a variable width, define it to have a width less than or equal to zero.
