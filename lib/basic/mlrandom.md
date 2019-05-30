---
grand_parent: Mitchell Libraries
parent: Data Structures and Utilities
---
# Random Number Generation

This library provides a simple interface for generating random numbers and for
other simple randomized operations, such as shuffling an array.

## Basic Usage

To generate a random integer between 1 and 6, the following can be used.

```sml
(* Initialize once at the beginning of your program. *)
val _ = Mlrandom.init ()

fun rollD6 () = Mlrandom.uniformInt (1, 7)
val _ = print (Int.toString (rollD6 ()) ^ "\n")
```

This results in output like

```
3
```

To shuffle an array, the following can be used.

```sml
structure A = ArrayToString(type t = int; val toString = Int.toString)

(* Initialize once at the beginning of your program. *)
val _ = Mlrandom.init ()

val data = Array.fromList [1,2,3,4,5]
val _ = print ("Before: " ^ A.toString data ^ "\n")

val _ = Mlrandom.shuffle data
val _ = print ("After: " ^ A.toString data ^ "\n")
```

This results output like

```
Before: Array.fromList [1,2,3,4,5]
After: Array.fromList [3,2,1,5,4]
```

## Interface

- `val init : unit -> unit`
- `val rand : unit -> int`
- `val uniformInt : (int * int) -> int`
- `val uniformReal : (real * real) -> real`
- `val shuffle : 'a array -> unit`

## Method Overview

- `init ()`
  - Initialize the random number generator with a random seed. Skipping this
    call with result in deterministic behavior, which may be useful for testing.
- `uniformInt (l, h)`
  - Return an integer in range `[l, h)`.
- `uniformReal (l, h)`
  - Return a real number in range `[l, h)`.
- `rand ()`
  - Return a random integer.
- `shuffle arr`
  - Shuffles `arr` in-place using the
    [Fisher-Yates algorithm](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle).
