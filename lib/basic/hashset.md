---
grand_parent: Mitchell Libraries
parent: Basic Libraries
---
# Hash Sets

This library provides a HashTable-based mutable set implementation.

The HashSet functor takes as arguments the type of the elements of the hash set,
the hashing function, and an equality comparison.

```sml
functor HashSet(type elem; val hash : elem -> word; val eq : eleme * elem -> bool) where type elem = elem
```

Most of the time (when using structural equality), one can use `MLton.hash` as
the hash function and `op=` as the equality comparison. See the basic usage
below for an example.

## Basic Usage

```sml
structure Set = HashSet(type elem = int; val hash = MLton.hash; val eq = op=)

val set = Set.makeEmpty ()
val _ = Set.addAllFromList (set, [1,3,5])
val has4 = Set.contains (set, 4)
val _ = print ("4: " ^ Bool.toString has4 ^ "\n")
val has5 = Set.contains (set, 5)
val _ = print ("5: " ^ Bool.toString has5 ^ "\n")
val _ = Set.remove (set, 5)
val has5 = Set.contains (set, 5)
val _ = print ("5: " ^ Bool.toString has5 ^ "\n")
```

This results in the output

```
4: false
5: true
5: false
```

## Interface

### Types
- `type elem`
  - The type of the elements in the set
- `type t`
  - The type of the set itself

### Methods

- `val makeEmpty : unit -> t`
- `val numItems : t -> int`
- `val isEmpty : t -> bool`
- `val fold : (elem * 'b -> 'b) * t * 'b -> 'b`
- `val all : (elem -> bool) * t -> bool`
- `val exists : (elem -> bool) * t -> bool`
- `val app : (elem -> unit) * t -> unit`
- `val filter : (elem -> bool) * t -> unit`
- `val contains : t * elem -> bool`
- `val containsAll : t * t -> bool`
- `val containsAllFromList : t * elem list -> bool`
- `val add : t * elem -> unit`
- `val addAll : t * t -> unit`
- `val addAllFromList : t * elem list -> unit`
- `val remove : t * elem -> unit`
- `val removeAll : t * t -> unit`
- `val removeAllFromList : t * elem list -> unit`
- `val equals : t * t -> bool`
- `val toList : t -> elem list`
- `val fromList : elem list -> t`

## Method Overview

- `makeEmpty ()`
  - Creates a new empty set.
- `numItems set`
  - Returns how many elements are in `set`.
- `isEmpty set`
  - Returns `true` if `set` is empty and `false` otherwise.
- `fold (f, set, base)`
  - Combines the elements of `set` using the function `f`, starting with `base`.
    The function `f` should take as an argument a tuple of the next element of
    `set` to process and the result accumulated so far.
- `all (f, set)`
  - Determines whether all of the elements of `set` satisfy the predicate `f`
    (i.e., whether `f` returns true for all of the elements).
- `exists (f, set)`
  - Determines whether any of the elements of `set` satisfy the predicate `f`
    (i.e., whether `f` returns true for at least one of the elements).
- `app (f, set)`
  - Applies `f` to each element in `set` for the purpose of the side effects.
    The order in which `f` will be applied is not guaranteed.
- `filter (f, set)`
  - Removes from `set` all of the elements that do not pass the predicate `f`.
- `contains (set, e)`
  - Determines whether `set` contains the element `e`.
- `containsAll (set, elems)`
  - Determines whether `set` contains all of the elements of `elems`. In other
    words, determines whether `elems` is a subset of `set`.
- `containsAllFromList (set, elems)`
  - Determines whether `set` contains all of the elements of `elems`.
- `add (set, e)`
  - Adds the element `e` to the set `set`. This modifies the set.
- `addAll (set, elems)`
  - Adds all of the elements of `elems` to the set `set`. This modifies `set` to
    be the union of `set` and `elems`.
- `addAllFromList (set, elems)`
  - Adds all of the elements of `elems` to the set `set`. This modifies `set`.
- `remove (set, e)`
  - Removes the element `e` from `set`. This modifies `set`.
- `removeAll (set, elems)`
  - Removes all of the elements of `elems` from `set`. This modifies `set` to be
    the set difference of `set` and `elems`.
- `removeAllFromList (set, elems)`
  - Removes all of the elements of `elems` from `set`. This modifies `set`.
- `equals (lhs, rhs)`
  - Determines whether the two sets are equal. Two sets are equal if they
    contain the same elements.
- `toList set`
  - Creates a list containing the elements of `set`.
- `fromList elems`
  - Creates a set containing the elements in the list.
