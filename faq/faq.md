---
title: FAQ
has_children: true
permalink: /faq/
---
# FAQ

## Why does Mitchell say something is wrong at a spot in my code that looks fine?

Mitchell checks your code to make sure that you are using types of data in a
consistent way. It reports errors where it finds a problem, but that isn't
always where the root cause of the problem is. Details on how to pin down a type
error in your program can be found [here](faq/using-types.md).

## How do I write tests in Mitchell?

There currently is no library to support unit testing in Mitchell.
However, anything that you write at the top-level in your `.sml` file
(e.g., `val _ = print “hello”`{:.sml}) will be
executed when you run your program with `run-mitchell`.
That can be used to implement tests manually as a workaround.

## How do I generate random numbers in Mitchell?

See the Mitchell
[`Random`](https://mitchell-lang.github.io/docs/lib/basic/mlrandom.html)
library.

## How do I print values?

See the [libraries for converting data to strings](../lib/basic/tostring.md).

<!--
## My program threw an exception. How do I find where the exception came from?

TODO
-->

## What Standard ML functions are available in Mitchell?

Everything in the
[Standard Basis Library](http://sml-family.org/Basis/manpages.html)
is available. Some functions are available without prefixing with the module
name. You can see the list of those functions
[here](Functions that are available without prefixing with the module names are listed here: http://sml-family.org/Basis/top-level-chapter.html).

For the purpose of this evaluation, we have included Standard ML libraries that
is not supported on the hardware accelerators. Therefore, while you may write
arbitrary Standard ML code as a Mitchell program, we ask that you keep any IO
you do separate from your core algorithm implementation. This will allow us to
re-target the implementation to the hardware accelerator for performance
evaluation.

## How to write a library in Mitchell?

You can build a library using Standard ML modules. See
[How Mitchell Builds on Standard ML](mitchell-standard-ml.md) for more
information on using Standard ML constructs within Mitchell, and see
[this reference](http://homepages.inf.ed.ac.uk/stg/NOTES/node95.html)
for information on the Standard ML module system.

## What is the difference between Mitchell and Standard ML?

Mitchell is currently Standard ML with the addition of new libraries for machine
learning and graph analytic, and with the removal of functionality that is not
supported on hardware accelerators.

See `/usr/local/bin/run-mitchell` for how Mitchell uses the MLton Standard ML
compiler.

## What does this compiler error mean?

See [Reading Compiler Errors](reading-compiler-errors.md).


## How do I get a value out of a pair or tuple?

There are two ways to use the invidivual values from a pair or tuple. One way is
via pattern matching:

```sml
val pair = (42, "hello")
val (leftValue, rightValue) = pair
(* Now leftValue = 42 and rightValue = "hello" *)
```

The other way is to use the projection functions:

```sml
val pair = (42, "hello")
val leftValue = #1 pair
val rightValue = #2 pair
(* Now leftValue = 42 and rightValue = "hello" *)
```

Both ways extend to larger-sized tuples.

## How do I get a value out of an array?

See the [`Array.sub`](http://sml-family.org/Basis/array.html#SIG:ARRAY.sub:VAL)
function in the Standard Basis Library.


## How do I get the inferred type of a specific variable?

The easiest way to find out what type a variable was inferred to be is to
annotate it with the `unit` type and get the inferred type from the error
message.

For example, compiling

```sml
val pair : unit = (42, 1.5)
```

Will produce the error

```
  Pattern and expression disagree.
    pattern:    [unit]
    expression: [int * real]
    in: val pair: unit = (42, 1.5)
```

where `int * real` is the inferred type of the variable.


## How do I convert between numeric types?

For converting between `int` and `real`, see the
[`Real.toInt`](http://sml-family.org/Basis/real.html#SIG:REAL.toInt:VAL)
and [`Real.fromInt`](http://sml-family.org/Basis/real.html#SIG:REAL.fromInt:VAL)
functions from the Standard Basis Library.

Numeric types of specific size (e.g., `Real32.real` and `Real64.real`) can be converted
between by converting to and from `LargeReal.real`
(using
[`Real<N>.toLarge`](http://sml-family.org/Basis/real.html#SIG:REAL.toLarge:VAL)
and
[`Real<N>.fromLarge`](http://sml-family.org/Basis/real.html#SIG:REAL.toLarge:VAL))
or `LargeInt.int` (using
[`Int<N>.toLarge`](http://sml-family.org/Basis/integer.html#SIG:INTEGER.toLarge:VAL)
and [`Int<N>.fromLarge`](http://sml-family.org/Basis/integer.html#SIG:INTEGER.toLarge:VAL)).

Similar functions are available for the [`word`](http://sml-family.org/Basis/word.html) types.
