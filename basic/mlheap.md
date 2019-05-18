---
parent: Mitchell Libraries
---
# Heaps

A heap module.

##### Dependencies

utils, mlarray.

##### Methods

- Kheap. Heap has type `A Mlheap.t`, where `A` is the type of the elements.
    + `(A t) make(((A, A) -> bool) comp, int k, int size, A default)`. Make a heap, which implemented by a k-ary tree. The second element indicate the number of branches in the explicit tree. Empirically, we observe good performance when `k = 4`. The first argument describes how to compare two polymorphic elements.
    + `unit push((A t) heap, A a)`. Push an element into the heap.
    + `unit pop((A t) heap)`. Pop the element at the top of heap. 
    + `bool empty((A t) heap)`. Return true if the heap is empty.
    + `A top((A t) heap)`. Return the top of the heap.
    + `(B t) compre((A -> B) f,((B, B) -> bool) comp, (A t) heap)`. Comprehension that maps one heap to another in parallel. 'comp' is a comparison function.
    + `string toString((A -> string) f, (A t) heap)`. Convert a heap to a string.
