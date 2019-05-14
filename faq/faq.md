---
title: FAQ
has_children: true
permalink: /faq
---
# FAQ

## Why does Mitchell say something is wrong at a spot in my code that looks fine?

Mitchell checks your code to make sure that you are using types of data in a
consistent way. It reports errors where it finds a problem, but that isn't
always where the root cause of the problem is. Details on how to pin down a type
error in your program can be found [here](faq/using-types.md).

## How to write tests in Mitchell?

There currently is no library to support unit testing in Mitchell.
However, anything that you write at the top-level in your `.sml` file
(e.g., `val _ = print “hello”`{:.sml}) will be
executed when you run your program with `run-mitchell`.
That can be used to implement tests manually as a workaround.

## How to generate random numbers in Mitchell?

Use the `MLton.Random` module. The interface to the module is defined
[here](http://www.mlton.org/MLtonRandom).

These three functions are not yet supported on the hardware accelerator,
however, so you should use a fixed seed.

```
val seed: unit -> word option
val srand: word -> unit
val useed: unit -> word option
```

## How do I print values?

TODO

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
