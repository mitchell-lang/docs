---
parent: Mitchell Libraries
---
# Matrices

A matrix of real numbers, which includes some math functions on matrices.

## Basic Usage

```sml
structure M = Mlmatrix(open Mlvector);

(* Make a 3x3 matrix with all entries set to 0.0 *)
val m = M.make(3, 3, 0.0);

(* Set the diagonal to 1.0 to make the identity matrix *)
M.set(m, (0, 0), 1.0);
M.set(m, (1, 1), 1.0);
M.set(m, (2, 2), 1.0);

(* Scale m by 2 *)
val m2 = M.mulScalar(m, 2.0);

(* Create a matrix from a list of lists *)
val m3 = M.fromList(
    [[1.0, 2.0, 3.0],
     [4.0, 5.0, 6.0],
     [7.0, 8.0, 9.0]]);


(* Multiply two matrices *)
val m4 = M.mul(m2, m3);

print (M.toString m4);
```

##### Dependencies

mlvector.

##### Methods

- Mlmatrix. Mlmatrix has type `A mlmatrix`, where `A` is the type of the elements.
	+ `(int, int) size(mlmatrix mat)`.
        - Return the size (the first element in tuple is height, second is width) of a matrix.
	+ `mlmatrix makeInit((int -> mlvector) f, int height)`.
        - Make and init a matrix, each row of matrix will be set by `f`. `f` takes the index of height as input.
    + `mlmatrix make(int height, int width, real default)`.
        - Make a matrix, and set every elements in it to default value.
	+ `real sub(mlmatrix mat, (int idx1, int idx2))`.
      - Return mat[idx1][idx2].
	+ `mlmatrix row(mlmatrix mat, int idx)`.
      - Return one row of a matrix as a "1 x n" matrix.
    + `mlmatrix col(mlmatrix mat, int idx)`.
      - Return one column of a matrix as a "m x 1" matrix.
    + `mlvector onerow(mlmatrix mat, int idx)`.
      - Like `row`, but squeeze the result to vector.
    + `mlvector onecol(mlmatrix mat, int idx)`.
      - Like `col`, but squeeze the result to vector.
    + `unit set(mlmatrix mat, (int idx1, int idx2), real r)`.
      - Update the element in mat[idx1][idx2] to `r`.
    + `unit update((real -> real) f, mlmatrix mat, (int idx1, int idx2))`.
      - Update the element in mat[idx1][idx2] to `f(mat[idx1][idx2])`.
    + `unit modify((real -> real) f, mlmatrix mat)`.
      - Modify every element in matrix by `f` in place.
    + `unit modifyi(((int, int, real) -> real) f, mlmatrix mat)`.
      - Like modify, but the modification function takes indices as input too.
    + `unit modifyrowi(((int, mlvector) -> unit) f, mlmatrix mat)`.
      - Modify a matrix by rows in place.
    + `mlmatrix copy(mlmatrix mat)`.
      - Copy a matrix.
    + `mlmatrix vec2mat(mlvector vec)`.
      - Convert a vector to "1 x n" matrix.
    + `mlvector squeeze1(mlmatrix mat)`.
      - Squeeze a "1 x n" matrix to a vector.
    + `mlvector squeeze2(mlmatrix mat)`.
      - Squeeze a "m x 1" matrix to a vector.
    + `real squeeze12(mlmatrix mat)`.
      - Squeeze a "1 x 1" matrix to a real number.
	+ `mlmatrix map((real -> real) f, mlmatrix mat)`.
      - Map an matrix to another with respect to the mapping function `f`.
	+ `mlmatrix mapi(((int, int, real) -> real) f, mlmatrix mat)`.
      - Like map, but the mapping function also takes the indices as input.
    + `mlmatrix map2(((real, real) -> real) f, mlmatrix mat1, mlmatrix mat2)`.
      - Map on two matrices, the result will have the minimal size of these two matrices.
    + `mlmatrix map2i(((int, int, real, real) -> real) f, mlmatrix mat1, mlmatrix mat2)`.
      - Like map2, but the mapping function also takes the indices as input.
	+ `A foldl(((A, real) -> A) f, A default, mlmatrix mat)`.
      - Fold a function over the elements of a table.
	+ `A foldli(((A, int, int, real) -> A) f, A default, mlmatrix mat)`.
      - Like fold, but recursion function also takes keys as input.
    + `A foldRowl((A, mlmatrix) -> A) f, A default, mlmatrix mat)`.
      - Fold a function over the rows of a table.
    + `A foldRowVecl((A, mlvector) -> A), A default, mlmatrix mat)`.
      - Like foldRowl, but treat a row as a vector instead of a matrix.
    + `mlmatrix transpose(mlmatrix mat)`.
      - Transpose a matrix.
    + `mlmatrix mulScalar(mlmatrix mat, real a)`.
      - Multiply a matrix with a real number.
    + `mlmatrix mul(mlmatrix mat1, mlmatrix mat2)`.
      - Multiply two matrices.
    + `mlmatrix add(mlmatrix mat1, mlmatrix mat2)`.
      - Add two matrices.
    + `unit addModify(mlmatrix mat1, mlmatrix mat2)`.
      - Like Add, but modify the first matrix instead of return a new matrix.
    + `mlmatrix elemwise(mlmatrix mat1, mlmatrix mat2)`.
      - Element wisely multiply two matrices, the result will have the minimal size of these two matrices.
    + `unit elemwiseInplace(mlmatrix mat1, mlmatrix mat2)`.
      - Like elemwise, but modify the first matrix instead of return a new matrix.
    + `mlmatrix matMulVec(mlmatrix mat, mlvector vec)`.
      - Multiply a matrix with a vector, treat the vector as a "m x 1" matrix.
    + `mlmatrix fromArray2((real array array) arr2)`.
      - Convert an array of array of real to mlmatrix.
    + `mlmatrix fromList((real list list) l2)`.
      - Convert an list of list of real to mlmatrix.
    + `string toStringF((real -> string) f, mlmatrix mat)`.
      - Convert a matrix to a string, the first argument describes how to convert the element to string.
    + `string toString(mlmatrix mat)`.
      -  Convert a matrix to a string using default format.
