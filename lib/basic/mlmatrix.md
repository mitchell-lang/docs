---
grand_parent: Mitchell Libraries
parent: Basic Libraries
---
# Matrices

This library provides support for creating and manipulating matrices of real
numbers, including some math functions on matrices.

For high-performance dense matrices that support only a finite set of
mathematical operations, see the [GSL bindings](./gsl.md).

## Basic Usage

```sml
structure M = Mlmatrix(Mlvector);

(* Make a 3x3 matrix with all entries set to 0.0 *)
val m = M.make (3, 3, 0.0)

(* Set the diagonal to 1.0 to make the identity matrix *)
val _ = M.set (m, (0, 0), 1.0)
val _ = M.set (m, (1, 1), 1.0)
val _ = M.set (m, (2, 2), 1.0)

(* Scale m by 2 *)
val m2 = M.mulScalar (m, 2.0)

(* Create a matrix from a list of lists *)
val m3 = M.fromList
           ([[1.0, 2.0, 3.0],
             [4.0, 5.0, 6.0],
             [7.0, 8.0, 9.0]])

(* Multiply two matrices *)
val m4 = M.mul (m2, m3)

val _ = print (M.toString m4)
```

## Interface

### Types

- `type scalar`
  - The `scalar` type is a synonym for `real`.
- `type mlvector`
  - The type of rows and columns in the matrix. These are [vectors](./mlvector.md).
- `type mlmatrix`
  - The type of the matrix itself.

### Methods

- `val size : mlmatrix -> (int * int)`
- `val makeInit : (int -> mlvector) * int -> mlmatrix`
- `val make : (int * int * real) -> mlmatrix`
- `val sub : mlmatrix * (int * int) -> scalar`
- `val row : mlmatrix * int -> mlmatrix`
- `val col : mlmatrix * int -> mlmatrix`
- `val onerow : mlmatrix * int -> mlvector`
- `val onecol : mlmatrix * int -> mlvector`
- `val set : mlmatrix * (int * int) * scalar -> unit`
- `val update : (scalar -> scalar) * mlmatrix * (int * int) -> unit`
- `val modify : (scalar -> scalar) * mlmatrix -> unit`
- `val modifyi : ((int * int * scalar) -> scalar) * mlmatrix -> unit`
- `val modifyrowi : ((int * mlvector) -> unit) * mlmatrix -> unit`
- `val copy : mlmatrix -> mlmatrix`
- `val vec2mat : mlvector -> mlmatrix`
- `val squeeze1 : mlmatrix -> mlvector`
- `val squeeze2 : mlmatrix -> mlvector`
- `val squeeze12 : mlmatrix -> scalar`
- `val map : (scalar -> scalar) * mlmatrix -> mlmatrix`
- `val mapi : ((int * int * scalar) -> scalar) * mlmatrix -> mlmatrix`
- `val map2 : ((scalar * scalar) -> scalar) * mlmatrix * mlmatrix -> mlmatrix`
- `val map2i : ((int * int * scalar * scalar) -> scalar) * mlmatrix * mlmatrix -> mlmatrix`
- `val foldl : (('a * scalar) -> 'a) * 'a * mlmatrix -> 'a`
- `val foldli : (('a * int * int * scalar) -> 'a) * 'a * mlmatrix -> 'a`
- `val foldRowl : ('a * mlmatrix -> 'a) * 'a * mlmatrix -> 'a`
- `val foldRowVecl : ('a * mlvector -> 'a) * 'a * mlmatrix -> 'a`
- `val transpose : mlmatrix -> mlmatrix`
- `val mulScalar : mlmatrix * scalar -> mlmatrix`
- `val mul : mlmatrix * mlmatrix -> mlmatrix`
- `val add : mlmatrix * mlmatrix -> mlmatrix`
- `val addModify : mlmatrix * mlmatrix -> unit`
- `val elemwise : mlmatrix * mlmatrix -> mlmatrix`
- `val elemwiseInplace : mlmatrix * mlmatrix -> mlmatrix`
- `val matMulVec : mlmatrix * mlvector -> mlvector`
- `val fromArray2 : scalar array array -> mlmatrix`
- `val fromList : scalar list list -> mlmatrix`
- `val toStringF : (scalar -> string) * mlmatrix -> string`
- `val toString : mlmatrix -> string`

## Method Overview

- `size mat`.
    - Returns the dimensions of the matrix. The resulting value is `(numRows, numColumns)`.
- `makeInit (f, height)`
    - Creates a matrix where each row in the matrix is the result of applying
      `f` to the index of that row.
- `make (numRows, numColumns, default)`
    - Creates a `numRows`-by-`numColumns` matrix with every element set to `default`.
- `sub (mat, (row, column))`.
  - Returns the element of the matrix at the given row and column.
- `row (mat, idx)`.
  - Returns one row of a matrix as a 1-by-n matrix.
- `col (mat, idx)`.
  - Returns one column of a matrix as a m-by-1 matrix.
- `onerow (mat, idx)`.
  - Like `row`, but converts the result to vector.
- `onecol (mat, idx)`.
  - Like `col`, but converts the result to vector.
- `set (mat, (row, col), r)`.
  - Updates the element in `mat` at the `row`th row and `col`th column to be
    `r`. This modifies `mat`.
- `update (f, mat, (idx1, idx2))`.
  - Updates the element in `mat` at the `row`th row and `col`th column to be the
    result of applying `f` to the original value at that index. This modifies
    `mat`.
- `modify (f, mat)`
  - Updates every element in `mat` to be the result of applying `f` to the
    original value at each index. This modifies `mat`.
- `modifyi (f, mat)`
  - Like `modify`, but the modification function also takes the row and column
    numbers as input.
- `modifyrowi (f, mat)`
  - Like `modifyi`, but `f` operates on a whole row at a time, with the row
    represented as a vector.
- `copy mat`
  - Creates a new matrix with the same contents as `mat`.
- `vec2mat vec`
  - Converts a vector to a 1-by-n matrix.
- `squeeze1 mat`
  - Extracts the first row of a matrix as a vector.
- `mlvector squeeze2(mlmatrix mat)`
  - Extracts the first column of a matrix as a vector.
- `real squeeze12(mlmatrix mat)`
  - Equivalent to `sub (mat, (0, 0))`.
- `map (f, mat)`
  - Creates a new matrix such that the value at each index in the new matrix is
    the result of applying `f` to the value at the same index in the original
    matrix.
- `mapi (f, mat)`
  - Like `map`, but `f` also takes the row and column numbers as input.
- `map2 (f, mat1, mat2)`
  - Map over two matrices. The resulting matrix will have the smaller size of these two matrices.
- `map2i (f, mat1, mat2)`
  - Like `map2`, but `f` also takes the row and column numbers as input.
- `foldl (f, base, mat)`
  - Combines the elements of `mat` using the function `f`, starting with `base`.
    The function `f` should take as an argument a tuple of the result
    accumulated so far and the next element of `arr` to process.
- `foldli (f, base, mat)`
  - Like `fold`, but `f` also the row and column number as input.
- `foldRowl (f, base, mat)`
  - Combines the rows of `mat` using the function `f`, starting with `base`. The
    function `f` should take as an argument a tuple of the result accumulated so
    far and the next row of `arr`, represented as a matrix, to process.
- `foldRowVecl (f, base, mat)`
  - Combines the rows of `mat` using the function `f`, starting with `base`. The
    function `f` should take as an argument a tuple of the result accumulated so
    far and the next row of `arr` to process.
- `transpose mat`
  - Creates a new matrix that is the transpose of `mat`.
- `mulScalar (mat, a)`
  - Creates a new matrix that is `mat` with each element multiplied by `a`.
- `mul (mat1, mat2)`
  - Creates a new matrix that is the product of `mat1` and `mat2`.
- `add (mat1, mat2)`
  - Creates a new matrix that is the sum of `mat1` and `mat2`.
- `addModify (mat1, mat2)`
  - Like `add`, but modifies the first matrix in-place instead of returning a
    new matrix. This modifies `mat1`.
- `elemwise (mat1, mat2)`
  - Creates a new matrix that is the element-wise product of `mat1` and `mat2`.
- `elemwiseInplace (mat1, mat2)`
  - Like `elemwise`, but modifies the first matrix in-place instead of returning
    a new matrix. This modifies `mat1`.
- `matMulVec (mat, vec)`
  - Creates a new matrix that is the product of the `mat` and `vec` treated as a
    m-by-1 matrix.
- `fromArray2 arr2`
  - Converts an array of arrays of reals to a matrix. Modifications to the
    resulting matrix will modify the original array, and modifications to the
    array will modify the matrix.
- `fromList l2`
  - Converts a list of lists of reals to a matrix.
- `toString mat`
  -  Converts a matrix to a string.
