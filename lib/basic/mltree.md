---
grand_parent: Mitchell Libraries
parent: Data Structures and Utilities
---
# Multi-Way Trees (Rose Trees)

This library provides multi-way trees (rose trees) with labels on both the
leaves and the internal nodes.

## Basic Usage

```sml
val tree = Mltree.makeNd (1, [Mltree.makeLf 2, Mltree.makeNd (3, [Mltree.makeLf 4])])
fun intTreeToString t = Mltree.toString (Int.toString, t)
val _ = print ("tree=\n" ^ intTreeToString tree ^ "\n")
val doubledTree = Mltree.compre ((fn x => x * 2), tree)
val _ = print ("doubledTree=\n" ^ intTreeToString doubledTree)
```

This results in the output

```
tree=
1
  3
    4
  2

doubledTree=
2
  6
    8
  4
```

To write recursive functions on trees, one can pattern match on the nodes to
determine if they are leaves or internal nodes.

```sml
val tree = Mltree.makeNd (1, [Mltree.makeLf 2, Mltree.makeNd (3, [Mltree.makeLf 4])])
fun maximum lst = List.foldl Int.max 0 lst
fun depth tree =
    case tree of
        Mltree.Lf _ => 1
      | Mltree.Nd (_, trees) => 1 + (maximum (List.map depth trees))
val _ = print (Int.toString (depth tree) ^ "\n")
```

This results in the output

```
3
```

## Interface

### Types
- `datatype 'a tree = Lf of 'a | Nd of 'a * 'a tree list`
  - A tree where `'a` is the type of the labels on the nodes.

### Methods

- `val makeLf: 'a -> 'a tree`
- `val makeNd: 'a * 'a tree list -> 'a tree`
- `val num: 'a tree -> int`
- `val root: 'a tree -> 'a`
- `val compre: ('a -> 'b) * 'a tree -> 'b tree`
- `val toString: ('a -> string) * 'a tree -> string`

## Method Overview
- `makeLf label`
  - Create a tree that contains a single node with the label `label`.
- `makeNd (a, forest)`.
  - Create a tree whose root is labeled with `a` and where the children of the
    root are given by `forest`.
- `num tree`
  - Returns the number of (internal and leaf) nodes in the tree.
- `root tree`
  - Returns the root of the tree.
- `compre (f, tree)`
  - Creates a new tree with the same structure as `tree`, but whose labels are
    given by the result of applying `f` to the label on the equivalent node in
    the original tree.
- `toString (f, tree)`
  - Converts `tree` to a string. The function `f` is a function for converting
    an individual label on a node in the tree to a string.
