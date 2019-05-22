---
parent: Mitchell Libraries
---
# Converting Data to Strings (Debug Printing)

Primitive types in the
[Standard Basis Library](http://sml-family.org/Basis/manpages.html)
have `toString` defined for them as part of modules for those types.
For example, see the `toString` functions for
[int](http://sml-family.org/Basis/integer.html#SIG:INTEGER.fmt:VAL),
[real](http://sml-family.org/Basis/real.html#SIG:REAL.fmt:VAL), and
[word](http://sml-family.org/Basis/word.html#SIG:WORD.fmt:VAL).

For container types, like
[list](http://sml-family.org/Basis/list.html) and
[array](http://sml-family.org/Basis/array.html),
Mitchell provides additional libraries as below.

Mitchell's libraries for graphs, matrices, etc., include `toString` support
in those modules.

## Basic Usage

In the examples below, we show you how to print structures that are filled with
integers. For other types, you will need to create the module using that type
and the `toString` function for that type.

### List of Integers

```sml
structure T = ListToString(struct type t = int; val toString = Int.toString end)
val lst = [1,2,3]
val _ = print (T.toString lst ^ "\n")
```

This prints
```
[1,2,3]
```

### Arrays of Integers

```sml
(* Create the structure. *)
structure T = ArrayToString(struct type t = int; val toString = Int.toString end)
val arr = Array.fromList [1,2,3]
val _ = print (T.toString arr ^ "\n")
```

This prints
```
Array.fromList [1,2,3]
```

### Lists of Arrays of Integers

These modules can be combined to create functions for printing lists of lists,
lists of arrays, etc. In this example, we show how to print a list of arrays of
integers.

```sml
structure A = ArrayToString(struct type t = int; val toString = Int.toString end)
structure L = ListToString(struct type t = int array; val toString = A.toString end)
val data = List.map Array.fromList [[1,2,3],[4,5],[6,7,8,9]]
val _ = print (T.toString arr ^ "\n")
```

This prints
```
[Array.fromList [1,2,3],Array.fromList [4,5],Array.fromList [6,7,8,9]]
```

### Monomorphic Data Structures

Mitchell has support for the _monomorphic_ data structures from Standard ML,
which are containers that are specialized to contain only one type. It is
unnecessary to use the monomorphic variants of data structures in Mitchell,
because the compiler will optimize the generic variants to behave the same way.
However, if you end up using one anyway, we provide some support for the
converting monomorphic data structure to strings and printing them.

However, they have a different pattern of use than the generic structures that
are described above. To create the module, you must provide the corresponding
monomorphic slice data structure, as in the example below.

```sml
structure T = MonoArrayToString(struct structure S = IntArraySlice; val elemToString = Int.toString end)
val arr = IntArray.fromList [1,2,3]
val _ = print (T.toString arr ^ "\n")
```

This prints

```
MonoArray.fromList [1,2,3]
```

## Interface

Mitchell includes `toString` support via the following modules, which can be
used as described in the examples above.

- `ArrayToString`
- `Array2ToString`
- `ArraySliceToString`
- `ListToString`
- `VectorSliceToString`
- `VectorToString`

Additionall Mitchell includes `toString` support for monomorphic containers via
the following modules, which can be used as described in the examples above.

- `MonoArraySliceToString`
- `MonoArrayToString`
- `MonoVectorSliceToString`
- `MonoVectorToString`
