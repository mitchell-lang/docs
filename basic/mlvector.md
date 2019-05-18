# Vectors

A vector of real numbers, which includes some math functions on vectors.

##### Dependencies

None.

##### Methods

- Mlvector. Mlvector has type `A mlvector`, where `A` is the type of the elements.
    + `int size(mlvector vec)`. Return the length of vector.
    + `mlvector make(int len, real default)`. Make a vector, filling every element to a default value.
    + `mlvector makeInit((int -> real) f, int len)`. Make a vector, initializing every element using initialization function `f`. `f` maps the contents of an index to a default value.
    + `real sub(mlvector vec, int n)`. Return the nth element in the vector.
    + `unit set(mlvector vec, int n, real r)`. Update the nth element in a vector to `r`(e.g., vec[n] := r).
    + `unit update((real -> real) f, mlvector vec, int n)`. Update the nth element with respect to its old value(e.g., vec[n] := f(vec[n])).
    + `unit modify((real -> real) f, mlvector vec)`. Modify a vector in place.
    + `unit modifyi(((int, real) -> real) f, mlvector vec)`. Like modify, but the modification function also takes indices as input.
    + `A foldl(((A, real) -> A) f, A default, mlvector vec)`. Fold a function over the elements of a vector.
    + `A foldli(((A, int, real) -> A) f, A default, mlvector vec)`. Like fold, but the recursive function also takes indices as input.
    + `mlvector copy(mlvector vec)`. Copy an mlvector.
    + `real squeeze(mlvector vec)`. Squeeze a 1-dimension vector to a scalar. Return vec[0].
    + `mlvector map((real -> real) f, mlvector vec)`. Map one vector to another with respect to the mapping function `f`.
    + `mlvector mapi(((int, real) -> real) f, mlvector vec)`. Like map, but the mapping function also takes the indices as input.
    + `mlvector map2(((real, real) -> real) f, mlvector vec1, mlvector vec2)`. Map over two vectors. The length of the result vector is equal to the minimal length of `vec1` and `vec2`.
    + `mlvector elemwise(mlvector vec1, mlvector vec2)`. Element-wise multiply two vectors.
    + `mlvector add(mlvector vec1, mlvector vec2)`. Add two vectors.
    + `unit addModify(mlvector vec1, mlvector vec2)`. Add two vectors, modify the first vec to the result in place.
    + `mlvector mulScalar(mlvector vec, real a)`. Multiply a vector with a scalar.
    + `real dot(mlvector vec1, mlvector vec2)`. Dot product.
    + `string toStringF((real -> string) f, mlvector vec)`. Convert a mlvector to string, where the first argument describes how to convert the element to string.
    + `string toString(mlvector vec)`. Convert a mlvector to string using default format.
    + `mlvector fromList((real list) l)`. Convert a list of real numbers to an mlvector.
