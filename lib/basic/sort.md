---
grand_parent: Mitchell Libraries
parent: Data Structures and Utilities
---
# Sorting Lists and Arrays

Sort lists and arrays using quicksort.

## Basic Usage

```sml
val orig = [23, 1, 4, ~3]
val sorted = quickSortList (op<, orig)
val first = List.hd sorted
(* List has been sorted; prints -3 *)
val _ = print (Int.toString first)
```

## Interface

### Methods

- `val quickSortArray : ('a * 'a -> bool) * 'a array -> unit`
- `val quickSortList : ('a * 'a -> bool) * 'a list -> 'a list`
- `val quickSortListIncrease : int list -> int list`

## Method Overview

- `quickSortArray (comp, arr)`
  - Sorts an array using an in-place quicksort algorithm. `comp` is a comparison
    function, which should return `true` for `(a, b)` when `a` is less than `b`.
    This modifies `arr`.
- `quickSortList (comp, lst)`
  - Sorts a list using the quicksort algorithm, returning the sorted list.
    `comp` is a comparison function, which should return `true` for `(a, b)`
    when `a` is less than `b`.
- `quickSortListIncrease lst`
  - A sort implementation specialized for integers. Integers are sorted in
    increasing order.
