#### mlheap

A heap module.

##### Dependencies

utils, mlarray.

##### Methods

- Kheap. Heap has type `A Mlheap.t`, where `A` is the type of the elements.
    + `(A t) make(((A, A) -> bool) comp, int k, int size, A default)`. Make a heap, which implemented by a k-ary tree. The second element indicate how many branches in the explicit tree. Basically, when `k = 4`, it has a good performance. The first argument describes how to compre two polymorphic elements.
    + `void push((A t) heap, A a)`. Push a element into heap.
    + `void pop((A t) heap)`. Pop the element in the top of heap. 
    + `bool empty((A t) heap)`. Return if the heap is empty.
    + `A top((A t) heap)`. Return the top of the heap.
    + `(B t) compre((A -> B) f,((B, B) -> bool) comp, (A t) heap)`. Comprehension. map a heap to another in parallel. The second argument how to compre two polymorphic elements.
    + `string toString((A -> string) f, (A t) heap)`. Convert a heap to String, the first argument describes how to convert the polymorphic element to string.
