---
grand_parent: Mitchell Libraries
parent: Data Structures and Utilities
---
# Vectors

This library provides support for creating and manipulating vectors of real
numbers, including some math functions on vectors.

## Basic Usage

```sml
val v = Mlvector.make (5, 0.0)
(* v is a vector of length 5 containing all 0s. *)
val _ = Mlvector.set (v, 0, 2.0)
(* v now has a 2.0 at index 0. *)

val v2 = Mlvector.fromList [1.0, 2.0, 3.0, 4.0, 5.0]
val d = Mlvector.dot (v2, v2)
(* d is 55.0, the result of taking the dot product of v2 and itself *)
```

## Interface

### Types

- `type scalar = real`
  - The `scalar` type is a synonym for `real`.
- `type mlvector`
  - The type of a vector.

### Methods

- `val size : mlvector -> int`
- `val make : (int * scalar) -> mlvector`
- `val makeInit : (int -> scalar) * int -> mlvector`
- `val sub : mlvector * int -> scalar`
- `val set : mlvector * int * scalar -> unit`
- `val update : (scalar -> scalar) * mlvector * int -> unit`
- `val modify : (scalar -> scalar) * mlvector -> unit`
- `val modifyi : ((int * scalar) -> scalar) * mlvector -> unit`
- `val foldl : (('a * real) -> 'a) * 'a * mlvector -> 'a`
- `val foldli : (('a * int * real) -> 'a) * 'a * mlvector -> 'a`
- `val copy : mlvector -> mlvector`
- `val squeeze : mlvector -> scalar`
- `val map : (scalar -> scalar) * mlvector -> mlvector`
- `val mapi : ((int * scalar) -> scalar) * mlvector -> mlvector`
- `val map2: ((scalar * scalar) -> scalar) * mlvector * mlvector -> mlvector`
- `val elemwise : mlvector * mlvector -> mlvector`
- `val add : mlvector * mlvector -> mlvector`
- `val addModify : mlvector * mlvector -> unit`
- `val mulScalar : mlvector * scalar -> mlvector`
- `val dot : mlvector * mlvector -> real`
- `val toStringF : (scalar -> string) * mlvector -> string`
- `val toString : mlvector -> string`
- `val fromList : real list -> mlvector`

## Method Overview

- `size vec`
  - Returns the length of the vector.
- `make (len, default)`
  - Creates a vector of length `len` with every value set to `default`.
- `makeInit (f, len)`
  - Creates a vector of length `len` with the value at index `i` set to `f i`.
- `sub (vec, n)`
  - Returns the value at index `n` in the vector.
- `set (vec, n, r)`
  - Sets the value at index `n` in `vec` to be `r` (e.g., `vec[n] := r`). This
    modifies `vec`.
- `update (f, vec, n)`.
  - Sets the value at index `n` in `vec` to be the result of applying `f` to the
    original value at that index (e.g., `vec[n] := f(vec[n])`). This modifies
    `vec`.
- `modify (f, vec)`
  - Sets the value at each index in `vec` to be the result of applying `f` to
    the original value. This modifies `vec`.
- `modifyi (f, vec)`
  - Like modify, but `f` also take the index as input.

- `A foldl(((A, real) -> A) f, A default, mlvector vec)`. Fold a function over the elements of a vector.
- `A foldli(((A, int, real) -> A) f, A default, mlvector vec)`. Like fold, but the recursive function also takes indices as input.

- `copy vec`
  - Creates a new vector with the same contents as `vec`.
- `squeeze vec`
  - Returns the value at the 0th index in `vec`.
- `map (f, vec)`
  - Creates a new vector where the value at each index is the result of applying
    `f` to the value at the same index in `vec`.
- `mapi (f, vec)`
  - Like map, but `f` also takes the index as input.
- `map2 (f, vec1, vec2)`
  - Creates a new vector where the value at each index is the result of applying
    `f` to the pair of values at the same index in `vec1` and `vec2`. The
    resulting vector is the same length as the smaller of `vec1` and `vec2`.
- `elemwise (vec1, vec2)`
  - Creates a new vector whose contents are the element-wise product of `vec1`
    and `vec2`.
- `add (vec1, vec2)`
  - Creates a new vector whose contents are the element-wise sum of `vec1` and
    `vec2`.
- `addModify (vec1, vec2)`.
  - Updates `vec1` so that it is contains the element-wise sum of the original
    value of`vec1` and `vec2`. This modifies `vec1`.
- `mulScalar (vec, a)`
  - Creates a new vector where each element is equal to the product of `a` and
    the element of the same index in `vec`.
- `dot (vec1, vec2)`
  - Returns the dot product of `vec1` and `vec2`.
- `toString vec`
  - Converts `vec` to a string.
- `fromList lst`
  - Creates a vector whose contents are the same as that of the list `lst`.
