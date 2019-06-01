---
grand_parent: Mitchell Libraries
parent: Data Structures and Utilities
---
# Graphs

This library provides a undirected graph data structure and operations on that data
structure. The API is similar to the
[GraphX library from Apache Spark](https://spark.apache.org/graphx/).

## Basic Usage

```sml
val g = BaseGraph.fromMetisFile("g.graph");

(* Compute the average degree of of graph by adding up the number of neighbors each node has... *)
val total = BaseGraph.graphFoldiNodes (( fn (sum, (nid, _)) => sum + (List.length (BaseGraph.neighbors (g, nid)))), 0, g)

(* ... and divide by the total number of nodes *)
val averageDegree = (Real.fromInt total) / (Real.fromInt (List.length (BaseGraph.nodes g)));
```

## Interface

To use this library, prefix the types and functions below with `BaseGraph.`.

### Types

- `type ('a, 'b) t`
  - The type of a graph. `'a` is the type of the labels on nodes and `'b` is the
    type of the labels on edges. For an unlabeled graph, use `(unit, unit) t`.
- `type nodeid = int`
- `type edgeid = int * int`

### Methods

- `val empty : unit -> ('a, 'b) t`
- `val fromMaps : (nodeid, 'a) HashTable.hash_table * (edgeid, 'b) HashTable.hash_table -> ('a, 'b) t`
- `val fromMetisFile : string -> (unit, unit) t`
- `val addNode : ('a, 'b) t * int * 'a -> unit`
- `val updateNode : ('a -> 'a) * ('a, 'b) t * nodeid -> unit`
- `val addEdge : ('a, 'b) t * (int*int) * 'b -> unit`
- `val connected : ('a, 'b) t * (nodeid * nodeid) -> bool`
- `val getNodeById : ('a, 'b) t * nodeid -> 'a option`
- `val getEdgeById : ('a, 'b) t * edgeid -> 'b option`
- `val nodes : ('a, 'b) t -> 'a list`
- `val nodesi : ('a, 'b) t -> (nodeid * 'a) list`
- `val nodeids : ('a, 'b) t -> nodeid list`
- `val edges : ('a, 'b) t -> 'b list`
- `val edgesi : ('a, 'b) t -> (edgeid * 'b) list`
- `val edgeids : ('a, 'b) t -> edgeid list`
- `val neighbors : ('a, 'b) t * nodeid -> 'a list`
- `val neighborsi : ('a, 'b) t * nodeid -> (nodeid * 'a) list`
- `val graphFoldNodes : ('c * 'a -> 'c) * 'c * ('a, 'b) t -> 'c`
- `val graphFoldEdges : ('c * 'b -> 'c) * 'c * ('a, 'b) t -> 'c`
- `val graphFoldiNodes : ('c * (nodeid * 'a) -> 'c) * 'c * ('a, 'b) t -> 'c`
- `val graphFoldiEdges : ('c * (edgeid * 'b) -> 'c) * 'c * ('a, 'b) t -> 'c`
- `val neighborFoldNodes : ('c * 'a -> 'c) * 'c * (('a, 'b) t * nodeid) -> 'c`
- `val neighborFoldEdges : ('c * 'b -> 'c) * 'c * (('a, 'b) t * nodeid) -> 'c`
- `val neighborFoldiNodes : ('c * (nodeid * 'a) -> 'c) * 'c * (('a, 'b) t * nodeid) -> 'c`
- `val neighborFoldiEdges : ('c * (edgeid * 'b) -> 'c) * 'c * (('a, 'b) t * nodeid) -> 'c`
- `val graphMapNodes : ('a -> 'c) * ('a, 'b) t -> ('c, 'b) t`
- `val graphMapEdges : ('b -> 'd) * ('a, 'b) t -> ('a, 'd) t`
- `val graphMapiNodes : ((nodeid * 'a) -> 'c) * ('a, 'b) t -> ('c, 'b) t`
- `val graphMapiEdges : ((edgeid * 'b) -> 'd) * ('a, 'b) t -> ('a, 'd) t`
- `val graphModifyNodes : ('a -> 'a) * ('a, 'b) t -> unit`
- `val graphModifyEdges : ('b -> 'b) * ('a, 'b) t -> unit`
- `val graphModifyiNodes : (nodeid * 'a -> 'a) * ('a, 'b) t -> unit`
- `val graphModifyiEdges : (edgeid * 'b -> 'b) * ('a, 'b) t -> unit`
- `val numberOfNodes : ('a, 'b) t -> int`
- `val numberOfEdges : ('a, 'b) t -> int`
- `val copy: ('a, 'b) t -> ('a, 'b) t`
- `val toString : ('a, 'b) t -> string`

## Method Overview

- `empty ()`
  - Creates a new graph with no nodes and no edges.
- `fromMaps (nodeMap, edgeMap)`
  - Creates a new graph with the given node and edge maps. All nodes referenced
    in `edgeMap` must appear in `nodeMap`.
- `fromMetisFile fileName `
  - Creats a graph from a
    [METIS](https://people.sc.fsu.edu/~jburkardt/data/metis_graph/metis_graph.html)
    file.
- `addNode (graph, nodeId, nodeLabel)`
  - Adds a node to `graph`.
- `updateNode (f, graph, nodeId)`
  - Updates the label of the node identified by `nodeId` with the result of
    applying `f` to the node's original label. This modifies `graph`.
- `addEdge (graph, edgeId, edgeLabel)`
  - Adds an edge to a graph.
- `connected (graph, (nodeIdA, nodeIdB))`
  - Returns true if the given nodes are adjacent.
- `getNodeById (graph, nodeId)`
  - Gets the label of the node. If the node exists, `SOME label` is returned.
    Otherwise, `NONE` is returned.
- `getEdgeById (graph, edgeId)`
  - Gets the label of the edge. If the edge exists, `SOME label` is returned.
    Otherwise, `NONE` is returned.
- `nodes graph`
  - Returns a list of all nodes labels in the graph. If more than one node has
    a given label, the label will appear multiple times in the list.
- `nodesi graph`
  - Returns a list of all node ids in the graph with their associated labels.
- `nodeids graph`
  - Returns a list of all node ids in the graph.
- `edges graph`
  - Returns a list of all edge labels in the graph. If more than one edge has a
    given label, the label will appear multiple times in the list.
- `edgesi graph`
  - Returns a list of all edge ids in the graph with their associated labels.
- `edgeids graph`
  - Returns a list of all edge ids in the graph.
- `neighbors (graph, nodeId)`
  - Returns a list of the labels of the nodes adjacent to `nodeId` in the graph.
- `neighborsi graph`
  - Returns a list of the node ids of the nodes adjacent to `nodeId` in the graph with their associated labels.
- `graphFoldNodes (f, base, graph)`
  - Combines the labels on the nodes using `f`, starting from `base`. `f` takes
    a pair of the result so far and the next label as arguments and returns the
    result including that label.
- `graphFoldEdges (f, base, graph)`
  - Combines the labels on the edges using `f`, starting from `base`. `f` takes
    a pair of the result so far and the next label as arguments and returns the
    result including that label.
- `graphFoldiNodes (f, base, graph)`
  - Like `graphFoldNodes`, but `f` also takes the node ID.
- `graphFoldiEdges (f, base, graph)`
  - Like `graphFoldEdges`, but `f` also takes the edge ID.
- `neighborFoldNodes (f, base, (graph, nodeId))`
  - Combines the labels on the nodes neighboring `nodeId` using `f`, starting
    from `base`. `f` takes a pair of the result so far and the next label as
    arguments and returns the result including that label.
- `neighborFoldEdges (f, base, (graph, nodeId))`
  - Combines the labels on the edges incident to `nodeId` using `f`, starting
    from `base`. `f` takes a pair of the result so far and the next label as
    arguments and returns the result including that label.
- `neighborFoldiNodes (f, base, (graph, nodeId))`
  - Like `neighborFoldNodes`, but `f` also takes the node ID.
- `neighborFoldiEdges (f, base, (graph, nodeId))`
  - Like `neighborFoldEdges`, but `f` also takes the edge ID.
- `graphMapNodes (f, graph)`
  - Creates a new graph with the same structure and edge labels as `graph`, but
    whose node labels are the result of applying `f` to the original node
    labels.
- `graphMapEdges (f, graph)`
  - Creates a new graph with the same structure and node labels as `graph`, but
    whose edge labels are the result of applying `f` to the original edge
    labels.
- `graphMapiNodes (f, graph)`
  - Like `graphMapNodes`, but `f` also takes the node ID.
- `graphMapiEdges (f, graph)`
  - Like `graphMapEdge`, but `f` also takes the edge ID.
- `graphModifyNodes (f, graph)`
  - Updates the node labels of `graph` with the result of applying `f` to the
    original node labels. This modifies `graph`.
- `graphModifyEdges (f, graph)`
  - Updates the edge labels of `graph` with the result of applying `f` to the
    original edge labels. This modifies `graph`.
- `graphModifyiNodes (f, graph)`
  - Like `graphModifyNodes`, but `f` also takes the node ID.
- `graphModifyiEdges (f, graph)`
  - Like `graphModifyEdges`, but `f` also takes the edge ID.
- `numberOfNodes graph`
  - Returns the number of nodes in the graph.
- `numberOfEdges graph`
  - Returns the number of edges in the graph.
- `copy graph`
  - Creates a copy of a graph. Modifications to the original graph will not
    affect the copy and modifications to the copy will not affect the original
    graph.
- `toString graph`
  - Converts a graph to a string.
