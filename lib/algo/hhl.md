---
parent: Mitchell Libraries
---
# Hierarchical Hub Labeling

Hub Labeling algorithm.

##### Dependencies

mlgraph, mltree, shortestpath.

##### Methods

- hhl.
    + `(((int * int) list, unit) G.t) hhl(((unit, unit) G.t) graph)`. Run hhl algorithm, return a new graph which binds hhl labels on each nodes.
    + `(int option) forward((((int, int) list, unit) G.t) graph, int source, int target)`. Get the shortest distance between source and target node. If they are not connected, return `NONE`.
