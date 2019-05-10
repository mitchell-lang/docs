#### unique

An unique(rename) module, which could map discrete instances to `0, 1, 2, 3...`.

##### Dependencies

None.

##### Methods

- Unique. Record all elements it have been given, and rename them to `0, 1, 2, 3...`. A unique module for `A` will have type `A Unique.t`.
  + `(A t) init(((A, A) -> bool) comp)`. Init a unique instance by a comparison function. The size of the instance can grow automatically,
  + `((A t), int) unique((A t) u, A a)`. Rename a object to a natural number, return the new unique instance and the number. If a object is recorded, the return number will be the same.
  + `int itemsNum((A t) u)`. Return how many items have been recorded.
