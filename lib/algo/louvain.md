---
parent: Mitchell Libraries
---
# Graph Clustering (Louvain)

louvain algorithm.

##### Dependencies

community, mlgraph.

##### Methods

- Louvain. Mlgraph has type `G.t` for short, community has type `C.t` for short.
    + `((unit, int) G.t) newGraph((int array array) adj)`. Build a graph from adjacency matrix for louvain algorithm.
    + `real calDeltaQ(((unit, int) G.t) graph, int nid, (int list) group)`. Calculate delta Q value(see louvain papers for details).
    + `((unit, unit) G.t) merge(((unit, int) G.t) graph, C.t commu)`. Merge a graph by community.
    + `string graphToString(((unit, int) G.t) graph)`. Convert a graph to string.
