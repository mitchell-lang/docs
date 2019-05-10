#### mlvector

A vector of real numbers, which includes some math functions on vectors.

##### Dependencies

None.

##### Methods

- Mlvector. Mlvector has type `A mlvector`, where `A` is the type of the elements.
    + `int size(mlvector vec)`. Return the length of vector.
    + `mlvector make(int len, real default)`. Make a vector, fill every element to default value.
    + `mlvector makeInit((int -> real) f, int len)`. Make a vector, initialize every element by initialization function `f`. `f` maps a index to a polymorphic element.
    + `real sub(mlvector vec, int n)`. Return nth element in the vector.
    + `void set(mlvector vec, int n, real r)`. Update nth element in vector to `r`(like vec[n] := r in some languages).
    + `void update((real -> real) f, mlvector vec, int n)`. Update nth element with respect its old value(like vec[n] := f(vec[n]) in some languages).
    + `void modify((real -> real) f, mlvector vec)`. Modify a vector in place.
    + `void modifyi(((int, real) -> real) f, mlvector vec)`. Like modify, but the modification function also takes indices as input.
    + `A foldl(((A, real) -> A) f, A default, mlvector vec)`. Fold a function over the elements of a vector.
    + `A foldli(((A, int, real) -> A) f, A default, mlvector vec)`. Like fold, but the recursion function also takes indices as input.
    + `mlvector copy(mlvector vec)`. Copy a mlvector.
    + `real squeeze(mlvector vec)`. Squeeze a 1-dimension vector to a scalar. Return vec[0].
    + `mlvector map((real -> real) f, mlvector vec)`. Map an array to another with respect to the mapping function `f`.
    + `mlvector mapi(((int, real) -> real) f, mlvector vec)`. Like map, but the mapping function also takes the indices as input.
    + `mlvector map2(((real, real) -> real) f, mlvector vec1, mlvector vec2)`. Map over two vectors. The length of result vector is equal to the minimal length of `vec1` and `vec2`.
    + `mlvector elemwise(mlvector vec1, mlvector vec2)`. Element wisely multiply two vectors.
    + `mlvector add(mlvector vec1, mlvector vec2)`. Add two vectors.
    + `void addModify(mlvector vec1, mlvector vec2)`. Add two vectors, modify the first vec to the result in place.
    + `mlvector mulScalar(mlvector vec, real a)`. Multiply a vector with a scalar.
    + `real dot(mlvector vec1, mlvector vec2)`. Dot product.
    + `string toStringF((real -> string) f, mlvector vec)`. Convert a mlvector to String, the first argument describes how to convert the element to string.
    + `string toString(mlvector vec)`. Convert a mlvector to String using default format.
    + `mlvector fromList((real list) l)`. Convert a list of real numbers to mlvector.
