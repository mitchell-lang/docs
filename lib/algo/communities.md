---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Representing Graph Clusters (Communities)

A data structure used in the Louvain algorithm to track clusters of nodes in a
graph, or communities.

## Interface

To use this module, prefix types and functions with `Community.`.

### Types

- `type t`
  - The type of a community.

### Methods

- `val make : int -> t`
- `val numSet : t -> int`
- `val normalize : t -> unit`
- `val whichSet : (t * int) -> int`
- `val sameSet : (t * int * int) -> bool`
- `val merge : t * (int * int) list -> bool`
- `val equal : (t * t) -> bool`
- `val getSetMember : (t * int) -> int list`

## Method Overview

- `make size`
  - Creates a set of `size` communities, each with a single member. The
    communities and members are each represented by integers.
- `numSet commu`
  - Returns the number of communities.
- `normalize commu`
  - Renames the identifiers, so that they are integers starting from 0. This
    modifies `commu`.
- `whichSet (commu, id)`
  - Returns the community that `id` belongs to.
- `sameSet (commu, id1, id2)`
  - Returns true if `id1` and `id2` are in the same community and false
    otherwise.
- `merge (commu, l)`
  - Merge the communities indicated in the list. If any community membership is
    changed return true, otherwise return false.
- `equal (commu1, commu2)`
  - Returns true if the two communities are equal and false otherwise.
- `getSetMember (commu, id)`
  - Return all elements in the same community as the given member.
