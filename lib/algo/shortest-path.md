---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Shortest Path (Dijkstra)

This library provides an implementation of Dijkestra's algorithm for finding the
shortest path between two nodes in a graph.

## Interface

To create an instance of the Dijkstra module, use

```sml
structure D = Dijkstra (structure T = Mltree;
                        structure G = BaseGraph;
                        structure H = Mlheap(Mlarray))
```

and then prefix the types and functions below with `D.`.

## Types

 - `structure G : GRAPH`
  - The shortest path library is parameterized by the graph library, which
    provide the graph type used.
    See the [graph documentation](../basic/mlgraph.md) for information on graphs.
 - `type node = int`
   - Nodes are represented as integers. The label corresponding to a node ID can
     be found using `G.getNodeById`.
 - `type distance = (int * node) option`
   - The distance to a specific node.

## Methods

- `val shortestPath: ('a, 'b) G.t * node -> distance array`
- `val toTree: node * distance array -> node T.tree`

## Method Overview

- `shortestPath (graph, nodeid)`
  - Return the distances from the source node given by `nodeid` to all other
    nodes. In the resulting array, the index into the array is the target node
    id, the value is the distance.
- `toTree (nodeid, arr)`
  - Builds a shortest-path tree from the distances array.
