---
parent: Mitchell Libraries
---
# Resizable Arrays

An array can grow automatically. If a supplied index exceeds the current size, the length of the array will be increased to accommodate the new index.

##### Dependencies

None.

##### Methods

- Mlarray. Array has type `A mlarray`, where `A` is the type of the elements.
    + `(A mlarray) makeInit(int num, A default)`. Make and initialize every element in the array.
    + `(A mlarray) make(int num, A default)`. Allocate the memory, but do not init.
    + `(A mlarray) copy((A mlarray) arr)`. Copy an array.
    + `B foldl(((A, B) -> B) f, B default, (A mlarray) arr)`. Fold a function over the elements of a array.
    + `B foldli(((int, A, B) -> B) f, B default, (A mlarray) arr)`. Like fold, but the recursion function also takes indices as input.
    + `(A mlarray) fromList((A list) l)`. Convert a list to mlarray.
    + `int length((A mlarray) arr)` Return the actual number of elements in the array.
    + `int maxLen((A mlarray) arr)`. The size(space usage) of the array (including indices not yet bound to values.)
    + `unit modify((A -> A) f, (A mlarray) arr)`. Modify an mlarray in place. 
    + `unit modifyi(((int,  A) -> A) f, (A mlarray) arr)`. Like modify, but the modification function also takes indices as input.
    + `A sub((A mlarray) arr, int n)`. Return the nth element in array(like arr[n] in some languages).
    + `unit update((A mlarray) arr, int idx, A a)`. Update the element in the idx position to `a`(like arr[idx] := a in some languages).
    + `string toString((A -> string) f, (A mlarray) arr)`. Convert a mlarray to string, the first argument describes how to convert the polymorphic element to string.
    + `string toStringSub((A -> string) f, (A mlarray) arr, (int start, int end))`. Like `toString`, but convert a subarray to string. The third argument is a tuple which describes the position of subarray: [start, end).
    + `(B mlarray) compre((A -> B) f, (A mlarray) arr)`. Comprehension, like map, but can run in parallel.
    + `(B mlarray) comprei(((int, A) -> B) f, (A mlarray) arr)`. Comprehension, like mapi, but can run in parallel.
    + `unit pushback((A mlarray) arr, A a)`. Push an element to the end of array. If the index exceeds the size of the array, the length of array will be doubled.
    + `A pop((A mlarray) arr)`. Pop an element from the end of array.  The memory allocated to the array is not reduced.