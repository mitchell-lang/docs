---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Hierarchical Hub Labeling

This library provides an implementaiton of a
[hub labeling](https://en.wikipedia.org/wiki/Hub_labels)
algorithm.

## Interface

To create an instance of the HHL module, use

```sml
structure D = Dijkstra (structure T = Mltree;
                        structure G = BaseGraph;
                        structure H = Mlheap(Mlarray))
structure H = Hhl(structure S = D)
```

and then prefix the types and functions below with `H.`.

### Types

- `structure G : GRAPH`
  - The HHL library is parameterized by the graph library, which provide the
    graph type used. See the [graph documentation](../basic/mlgraph.md)
    for information on graphs.

### Methods

- `val hhl : (unit, unit) G.t -> ((int * int) list, unit) G.t`
- `val forward : ((int * int) list, unit) G.t * G.nodeid * G.nodeid -> int option`

## Method Overview

- `hhl graph`
  - Runs the HHL algorithm, returning a new graph which labels nodes with the
    HHL results.
- `forward (graph, source, target)`
  - Gets the shortest distance between source and target node in a HHL-labeled
    graph. If they are not connected, returns `NONE`.
