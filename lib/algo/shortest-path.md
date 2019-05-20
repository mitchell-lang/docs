---
parent: Mitchell Libraries
---
# Shortest Path (Dijkstra)

Find the shortest path of a graph.

##### Dependencies

mlgraph, mltree.

##### Methods

- Dijkstra.
    + `(int array) shortestPath(((A, B) G.t) graph, int nodeid)`. Return the distances from source node to others. The result is an array, the index is the target node id, the value is the distance.
    + `(node Mltree.tree) toTree(int nodeid, (distance array) arr)`. Build a short path tree from the distances array.
