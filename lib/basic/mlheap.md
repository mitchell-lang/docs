---
grand_parent: Mitchell Libraries
parent: Data Structures and Utilities
---
# Heaps

A heap implementation.

## Basic Usage

```sml
structure H = Mlheap(structure A = Mlarray);

(* Make a 2-ary heap with initial size 0 and 0 as default item value, using `<` as the comparison operator *)
val heap = H.make (op<, 2, 0, 0);

(* Push some integers onto the heap *)
val _ = H.push (heap, 10);
val _ = H.push (heap, 20);
val _ = H.push (heap, 5);

(* The top of the heap is 5 *)
val _ = print (Int.toString (H.top heap));
(* Pop off the smallest item *)
val _ = H.pop heap;

(* The top of the heap is now 10 *)
val _ = print (Int.toString (H.top heap));
(* Pop off the smallest item *)
val _ = H.pop heap;

(* The top of the heap is now 20 *)
val _ = print (Int.toString (H.top heap));
(* Pop off the smallest item; heap is now empty *)
val _ = H.pop heap;
```

## Interface

### Types

- `type 'a t`
  - The type of a heap containing elements of type `'a`.

### Methods

- `val make : ('a * 'a -> bool) * int * int * 'a -> 'a t`
- `val push : 'a t * 'a -> unit`
- `val pop : 'a t -> unit`
- `val empty : 'a t -> bool`
- `val top : 'a t -> 'a`
- `val compre : ('a -> 'b) * ('b * 'b -> bool) * 'a t -> 'b t`
- `val toString : ('a -> string) * 'a t -> string`

## Method Overview

- `(A t) make(comp, k, size, default)`.
  - Creates a new heap. `comp` is a function that determines if one value in the
    heap is less than another. `comp a b` should return `true` when `a` is less
    than `b`. `k` is the branching number for the heap. This should be at
    least 2. If you don't know what to pick, use 4. `size` is the initial
    capacity of the heap. `default` is used to initialize the underlying
    data structure.
- `push (heap, a)`
  - Pushes an element into the heap.
- `pop heap`
  - Removes the smallest element from the heap and returns it.
- `empty heap`
  - Returns true if the heap is empty.
- `top heap`
  - Returns the smallest element in the heap without removing it.
- `compre (f, comp,  heap)`
  - Creates a new heap whose contents are the result of applying `f` to each
    element in `heap`. The `comp` function is a less-than function as required
    by `make`.
- `toString (f, heap)`
  - Converts `heap` to a string. The function `f` is a function for converting
    an individual element of the heap to a string.
