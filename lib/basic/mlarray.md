---
grand_parent: Mitchell Libraries
parent: Basic Libraries
---
# Resizable Arrays

An array that can grow automatically as items are added to the end of it. Roughly
equivalent to `std::vector` in C++ -- i.e., it supports constant time item
retrieval and modification and amortized constant time appends.

Mutable [one-dimensional](http://sml-family.org/Basis/array.html) and
[two-dimensional fixed-size arrays](http://sml-family.org/Basis/array2.html)
are available from the Standard Basis Library. Immutable one-dimensional fixed-size
[vectors](http://sml-family.org/Basis/vector.html) are also available from the
Standard Basis Library.

## Basic usage

```sml
(* Create an empty array *)
val a = Mlarray.make (0, 0)
(* Append 12 to the array *)
val _ = Mlarray.pushback (a, 12)
(* ln = 1 *)
val ln = Mlarray.length (a)
(* set the first item to 99 *)
val _ = Mlarray.update (a, 0, 99)
```

## Interface

### Types

- `'a mlarray`
  - A resizable array with elements of type `'a`

### Methods

- `val makeInit : int * 'a -> 'a mlarray`
- `val make : int * 'a -> 'a mlarray`
- `val copy : 'a mlarray -> 'a mlarray`
- `val foldl : ('a * 'b -> 'b) * 'b * 'a mlarray -> 'b`
- `val foldli : (int * 'a * 'b -> 'b) * 'b * 'a mlarray -> 'b`
- `val fromList : 'a list -> 'a mlarray`
- `val length : 'a mlarray -> int`
- `val maxLen : 'a mlarray -> int`
- `val modify : ('a -> 'a) * 'a mlarray -> unit`
- `val modifyi : (int * 'a -> 'a) * 'a mlarray -> unit`
- `val sub : 'a mlarray * int -> 'a`
- `val update : 'a mlarray * int * 'a -> unit`
- `val toString : ('a -> string) * 'a mlarray -> string`
- `val toStringSub : ('a -> string) * 'a mlarray * (int * int) -> string`
- `val compre : ('a -> 'b) * 'a mlarray -> 'b mlarray`
- `val comprei : ((int * 'a) -> 'b) * 'a mlarray -> 'b mlarray`
- `val pushback : 'a mlarray * 'a -> unit`
- `val pop : 'a mlarray -> 'a`

## Method Overview

- `makeInit (nun, default)`
    - Makes an array of length `num` with every element having value `default`.
- `make(num, default)`.
    - Allocate an array that can store `num` items, but is initially empty
      (i.e., `Mlarray.length` will return 0). The `default` value is used to
      initialize the underlying storage.
- `copy arr`.
    - Creates a copy of `arr`.
- `foldl (f, base, arr)`.
  - Combines the elements of `arr` using the function `f`, starting with `base`.
    The elements are combined from left to right (lowest index to highest
    index). The function `f` should take as an argument a tuple of the next
    element of `arr` to process and the result accumulated so far.
- `foldli (f, base, arr)`.
    - Like foldl, but the function also takes indices as input.
- `fromList lst`
    - Creates an array containing the contents of the list `lst`.
- `length arr`
    - Returns the number of elements in the array.
- `maxLen arr`
    - Returns the current capacity of the array.
- `modify (f, arr)`
  - Replaces each value in `arr` with the result of applying `f` to the
    original value. This modifies `arr`.
- `modifyi (f, arr)`
    - Like modify, but the modification function also takes indices as input.
- `sub (arr, n)`.
    - Returns the `n`th element of `arr` (like `arr[n]` in other languages).
- `update (arr, idx, a)`.
    - Updates the `idx`th element of `arr` to be `a` (like `arr[idx] := a` in
      some languages).
- `toString (f, arr)`.
    - Converts `arr` to a string. The function `f` is a function for converting
      an individual element of the array to a string.
- `toStringSub (f, arr, (start, end))`
    - Like `toString`, but converts a sub-array to a string. The subarray ranges
      over indices [`start`,`end`) (that is, inclusive of `start` and exclusive
      of `end`).
- `compre (f, arr)`
    - Creates a new array, such that each index in the new array contains the
      result of applying `f` to the value at that index in the old array.
- `comprei (f, arr)`
    - Creates a new array, such that each index in the new array contains the
      result of applying `f` to the index and value at that index in the old
      array.
- `pushback (arr, a)`
    - Pushes an element to the end of array.
- `pop arr`
    - Pop an element from the end of array.
