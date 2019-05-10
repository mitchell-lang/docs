#### sort

Sorting functions(quick sort for list and array).

##### Dependencies

None.

##### Methods

- `void quickSortArray(((A, A) -> bool) comp, (A array) arr)`. Sort an array using quick sort algorithm in place. The first argument describes how to compare two polymorphic elements.
- `(A list) quickSortList(((A, A) -> bool) comp, (A list) l)`. Sort a list using quick sort algorithm and return sorted list. The first argument describes how to compare two polymorphic elements.
- `(int list) quickSortListIncrease(((int, int) -> bool) comp, (int list) l)`. Sort int list with increasing order by quickSortList.
