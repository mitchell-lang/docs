# binary

A binary number with fixed number of bits.

## Basic usage

```sml
(* Create a struct that implements 12-bit binary numbers *)
structure B = Binary(struct val binaryDim = 12 end);
val nine = B.fromInt(9);

(* m = 4095, or 111111111111b *)
val m = B.max ;
```

##### Dependencies

None.

##### Methods

- Binary. binary has type `binary`.
    + `int length()`. Return the fixed length.
    + `binary max()`. Return the max binary number.
    + `binary zero()`.  Return zero.
    + `binary fromInt(int n)`. Convert a integer to binary number.
