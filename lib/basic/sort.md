---
parent: Mitchell Libraries
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

##### Dependencies

None.

##### Methods

- `unit quickSortArray(((A, A) -> bool) comp, (A array) arr)`. 
  - Sort an array using an in-place quicksort algorithm. The first argument is the comparison function.
- `(A list) quickSortList(((A, A) -> bool) comp, (A list) l)`.
  - Sort an input list using the quicksort algorithm and return the sorted list. The first argument is the comparison function.
- `(int list) quickSortListIncrease((int list) l)`.
  - Sort a list of integers.
