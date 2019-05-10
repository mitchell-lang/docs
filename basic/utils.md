#### utils

Utils. Includes some syntax sugars, some functions used frequently and extensions of SML list and array module.

##### Dependencies

None.

##### Methods

- Syntax sugar.
  + `A return(A a)`. Just return the input argument. 
  + `(B list) foreach((A -> B) f, (A list) l)`. Just map a list`l` to another with respect to mapping function `f`.
- Functions used frequently.
  + `int intPow(int a, int b)`. Return `a^b`.
  + `real mlsq(real a)`. Return `a^2`.
  + `(A option) betterOpt(((A, A) -> bool) comp, (A option) opt1, (A option) opt2)`. Return the better one in two input arguments with respect to the comparing function `comp`. If one of them is `NONE`, choose another one.
- ExtendedList. A complement to the List module.
  + `(B list) mapi(((int, A) -> B) f, (A list) l)`. Like map, but the mapping function also takes the indices as input.
  + `B foldli(((B, int, A) -> B) f, B default, (A list) l)`. Like fold, but the recursion function also takes the indices as input.
  + `string toString((A -> string) f, (A list) l))`. Convert a list to a string, the first argument describes how to convert the polymorphic element to a string.
  + `(A option) bestOpt(((A, A) -> bool) comp, (A list) l)`. Find the best one in a list with respect to a comparing function. If the list is empty, return `NONE`.
  + `(A list) subtract(((A, A) -> bool) eq, (A list) l1, (A list) l2)`. Subtract l2 from l1. The first argument is equality function which describes when two polymorphic element are the same.
  + `A bestDefault(((A, A) -> bool) comp, A default, (A list) l)`. Like bestOpt, but return default value instead of `NONE`.
- ExtendedArray. A complement to the Array module.
  + `string toString((A -> string) f, (A array) arr)`. Convert a array to a string, the first argument describes how to convert the polymorphic element to a string.
  + `(A array) copy((A array) arr)`. Copy an array.
  + `(B array) map((A -> B) f, (A array) arr)`. Map an array to another with respect to the mapping function `f`.
