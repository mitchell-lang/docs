---
parent: Mitchell Libraries
---
# Heaps

A heap implementation.

## Basic Usage

```sml
structure H = Mlheap(structure A = Mlarray);

(* Make a 2-ary heap with initial size 0 and 0 as default item value, using `<` as the comparison operator *)
val heap = H.make ((fn (a, b) => a < b), 2, 0, 0);

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

##### Dependencies

utils, mlarray.

##### Methods

- Kheap. Heap has type `A Mlheap.t`, where `A` is the type of the elements.
    + `(A t) make(((A, A) -> bool) comp, int k, int size, A default)`. 
       - Make a heap, which is implemented internally with a k-ary tree. The second element indicate the number of branches in the explicit tree -- this should be at least two; empirically, we observe good performance when `k = 4`. The first argument is used to compare two elements: it should return `true` if its
       first argument is less than the second.
    + `unit push((A t) heap, A a)`. 
       - Push an element into the heap.
    + `unit pop((A t) heap)`. 
       - Pop the element at the top of heap. 
    + `bool empty((A t) heap)`. 
       - Return true if the heap is empty.
    + `A top((A t) heap)`. 
       - Return the top of the heap.
    + `(B t) compre((A -> B) f,((B, B) -> bool) comp, (A t) heap)`. 
       - Comprehension that maps one heap to another in parallel. 'comp' is a comparison function.
    + `string toString((A -> string) f, (A t) heap)`.
       - Convert a heap to a string.
