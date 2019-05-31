---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Graph Clustering (Louvain)

This library provides support for the
[Louvain graph clustering algorithm](https://en.wikipedia.org/wiki/Louvain_Modularity).

## Interface

To use the this library, prefix the types and functions below with `Louvain.`.

### Types

- `structure G : GRAPH`
- `structure C : COMMUNITY`
  - The Louvain library makes use of the graph library and community library,
    including the type for graphs `G.t` and the type for communities `C.t`. See
    the [graph documentation](../basic/mlgraph.md) for information on graphs and
    the the [community documentation](../basic/community.md) for information on
    communities.

### Methods

- `val newGraph : int array array -> (unit, int) G.t`
- `val calDeltaQ : (unit, int) G.t * int * int list -> real`
- `val merge : (unit, int) G.t * C.t -> (unit, int) G.t`
- `val graphToString : (unit, int) G.t -> string`

## Method Overview

- `newGraph adj`
  - Builds a graph from an adjacency matrix represented as an array of arrays.
- `calDeltaQ (graph, nid, group)`
  - Calculate the [delta-Q value](https://en.wikipedia.org/wiki/Louvain_Modularity#Algorithm).
- `merge (graph, commu)`
  - Merge a graph by community.
- `graphToString graph`
  - Converts a graph to a string.
