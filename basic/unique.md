#### unique

A unique(rename) module, which could map discrete instances to `0, 1, 2, 3...`.

##### Dependencies

None.

##### Methods

- Unique. Record all elements it has been given, and rename them to `0, 1, 2, 3...`. A unique module for `A` will have type `A Unique.t`.
  + `(A t) init(((A, A) -> bool) comp)`. Initiazlie a unique instance using 'comp' as a comparison function. The size of the instance can grow automatically,
  + `((A t), int) unique((A t) u, A a)`. Rename an object to a natural number, and return the new unique instance and the number. If an object is recorded, the returned number will be the same.
  + `int itemsNum((A t) u)`. Return how many items have been recorded.
