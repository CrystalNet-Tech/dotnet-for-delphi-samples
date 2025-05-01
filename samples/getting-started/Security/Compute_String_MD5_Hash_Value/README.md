# How to compute the MD5 hash value of a string and returns the hash as a 32-character, hexadecimal-formatted string
The following demo computes the MD5(https://docs.microsoft.com/en-gb/dotnet/api/system.security.cryptography.md5?view=netframework-4.7.2) hash value of a string and returns the hash as a 32-character, hexadecimal-formatted string. 

The following code example computes the MD5 hash value of a string and returns the hash as a 32-character, hexadecimal-formatted string. The hash string created by this code example is compatible with any MD5 hash function (on any platform) that creates a 32-character, hexadecimal-formatted hash string.


Hash functions map binary strings of an arbitrary length to small binary strings of a fixed length. A cryptographic hash function has the property that it is computationally infeasible to find two distinct inputs that hash to the same value; that is, hashes of two sets of data should match if the corresponding data also matches. Small changes to the data result in large, unpredictable changes in the hash.

The hash size for the MD5 algorithm is 128 bits.

The ComputeHash(https://docs.microsoft.com/en-gb/dotnet/api/system.security.cryptography.hashalgorithm.computehash?view=netframework-4.7.2) methods of the MD5 class return the hash as an array of 16 bytes. Note that some MD5 implementations produce a 32-character, hexadecimal-formatted hash. To interoperate with such implementations, format the return value of the ComputeHash methods as a hexadecimal value.