#### mlgraph

A graph module similar to `Spark.graphX`. There will be four implementations: `BaseGraph`, `Digraph`, `MultiGraph` and `MultiDiGraph`. Now, `BaseGraph` is available.

##### Dependencies

hashtable, utils.

##### Methods

- Graph. Graph has type `(A, B) t`, where `A` indicates the type of nodes, and `B` indicates the type of edges. For example, `(unit, unit) GRAPH.t` is actually a adjacency matrix. `(string, real) GRAPH.t` could be a traffic road map: each node has type string which is the name of place, each edge has type int which is the distance between two places. `nodeid = int` is actually integer, `edgeid = (nodeid, nodeid)` is a pair of integer(source and target node index) respectively.
    + `((unit, unit) t) fromMetisFile(string fileName)`. Read a graph from file.
    + `((A, B) t) fromAdj((int array array) adj, ((nodeid, A) HashTable.hash_table) nodeMap, ((edgeid, B) HashTable.hash_table) egdeMap)`. Build a graph by adjacency matrix. The second argument is a hashtable which map nodeid to element it binds, so does the third element. 
    + `((A, B) t) addNode(((A, B) t) graph, A a)`. Add a single node to a graph, return the new graph.
    + `((A, B) t) removeNode(((A, B) t) graph, A a)`. Remove a node from a graph, return the new graph. 
    + `unit updateNode((A -> A) f, ((A, B) t) graph, nodeid nid)`. Update a node by its id by `f` in place.
    + `((A, B) t) addEdge(((A, B) t) graph, edgeid eid, B b)`. Add a edge to a graph, return the new graph.
    + `((A, B) t) removeEdge(((A, B) t) graph, B b)`. Remove a edge from a graph, return the new graph. 
    + `unit updateEdge((B -> B) f, ((A, B) t) graph, edgeid eid)`. Update a edge by its id by `f` in place.
    + `(nodeid option) hasNode(((A, B) t) graph, A a)`. Return the nodeid by the value of the node. If the value doesn't exist, return `NONE`.
    + `(edgeid option) hasEdge(((A, B) t) graph, B b)`. Return the edgeid by the value of the edge. If the value doesn't exist, return `NONE`.
    + `bool connected(((A, B) t) graph, (nodeid, nodeid) nid)`. Return if there is a edge connects two nodes.
    + `(A option) getNodeById(((A, B) t) graph, nodeid nid)`. Get node by id, if the node id doesn't exist, return `NONE`.
    + `(B option) getEdgeById(((A, B) t) graph, edgeid eid)`. Get edge by id, if the edge id doesn't exist, return `NONE`.
    + `(A list) nodes(((A, B) t) graph)`. Squeeze all nodes to a list.
    + `((nodeid, A) list) nodesi((A, B) t) graph)`. Like nodes, but return both indices and nodes.
    + `(nodeid list) nodeids(((A, B) t))`. Like nodesi, but only return indices.
    + `(B list) egdes(((A, B) t) graph)`. Squeeze all edges to a list.
    + `((edgeid, B) list) egdesi(((A, B) t) graph)`. Like edges, but return both indices and edges.
    + `(edgeid list) egdeids(((A, B) t) graph)`. Like edgesi, but only return indices.
    + `(A list) neighbors(((A, B) t) graph, nodeid nid)`. Return the nodes which is connected with `nid`.
    + `((nodeid, A) list) neighborsi((A, B) t) graph)`. Like neighbors, but also return indices.
    + `(A, A) ends(((A, B) t) graph, edgeid eid)`. Return the source node and target node of a edge.
    + `((nodeid, A), (nodeid, A)) endsi(((A, B) t) graph, edgeid eid)`. Like ends, but also return indices.
    + `C graphFoldNodes(((C, A) -> C) f, C default, ((A, B) t) graph)`. Fold over all nodes in a graph.
    + `C graphFoldEdges(((C, B) -> C) f, C default, ((A, B) t) graph)`. Fold over all edges in a graph.
    + `C graphFoldiNodes(((C, (nodeid, A)) -> C), C default, ((A, B) t) graph)`. Like graphFoldNodes, but the recursion function also takes the indices as input.
    + `C graphFoldiEdges(((C, (edgeid, B)) -> C), C default, ((A, B) t) graph)`. Like graphFoldEdges, but the recursion function also takes the indices as input.
    + `C neighborFoldNodes(((C, A) -> C) f, C default, ((A, B) t) graph, nodeid nid)`. Fold over all nodes that is connected with a node.
    + `C neighborFoldEdges(((C, B) -> C) f, C default, ((A, B) t) graph, nodeid nid)`. old over all edges that is connected with a node.
    + `unit neighborFoldiNodes(((C, (nodeid, A) -> C) f, C default, ((A, B) t) graph, nodeid nid)`. Like neighborFoldNodes, but the recursion function also takes the indices as input.
    + `unit neighborFoldiEdges(((C, (edgeid, B) -> C) f, C default, ((A, B) t) graph, nodeid nid)`. Like neighborFoldEdges, but the recursion function also takes the indices as input.
    + `((C, B) t) graphMapNodes((A -> C) f, ((A, B) t) graph)`. Map a graph to another graph by a function over nodes.
    + `((A, D) t) graphMapEdges((B -> D) f, ((A, B) t) graph)`. Map a graph to another graph by a function over edges.
    + `((C, B) t) graphMapiNodes(((nodeid, A) -> C) f, ((A, B) t) graph)`. Like graphMapNodes, but the mapping function also takes the indices as input.
    + `((A, D) t) graphMapiEdges(((edgeid, B) -> D) f, ((A, B) t) graph)`. Like graphMapNodes, but the mapping function also takes the indices as input.
    + `unit graphModifyNodes((A -> A) f, ((A, B) t) graph)`. Modify a graph by a function over nodes in place.
    + `unit graphModifyEdges((B -> B) f, ((A, B) t) graph)`. Modify a graph by a function over edges in place.
    + `unit graphModifyiNodes(((nodeid, A) -> A) f, ((A, B) t) graph)`. Like graphModifyNodes, but the modification function also takes the indices as input.
    + `unit graphModifyiEdges(((edgeid, B) -> B) f, ((A, B) t) graph)`. Like graphModifyEdges, but the modification function also takes the indices as input. 
    + `unit neighborModifyNodes((A -> A) f, ((A, B) t) graph, nodeid nid)`. Modify all nodes that is connected with a node in place.
    + `unit neighborModifyEdges((B -> B) f, ((A, B) t) graph, nodeid nid)`. Modify all egdes that is connected with a edge in place.
    + `unit neighborModifyiNodes(((nodeid, A) -> A) f, ((A, B) t) graph, nodeid nid)`. Like neighborModifyNodes, but the modification function also takes the indices as input.
    + `unit neighborModifyiEdges(((edgeid, B) -> B) f, ((A, B) t) graph, nodeid nid)`. Like neighborModifyEdges, but the modification function also takes the indices as input.
    + `int numberOfNodes(((A, B) t) graph)`. Return the number of nodes in the graph.
    + `int numberOfEdges(((A, B) t) graph)`. Return the number of edges in the graph.
    + `(int list) degree(((A, B) t) graph)`. Return the degree of each node.
    + `((nodeid, int) list) degreei(((A, B) t) graph)`. Return the nodeids and the corresponding degrees.
    + `((A, B) t) copy(((A, B) t) graph)`. Copy a graph.
    + `((A, B) t) subgraphNodes(((A, B) t) graph, (nodeid list) l)`. Extract a sub graph by a list of node indices.
    + `((A, B) t) subgraphEdges(((A, B) t) graph, (edgeid list) l)`. Extract a sub graph by a list of edge indices.
    + `((A, B) t) subgraphNodeF((A -> bool) f, ((A, B) t) graph)`. Extract a sub graph by a filter function over nodes.
    + `((A, B) t) subgraphEdgeF((B -> bool) f, ((A, B) t) graph)`. Extract a sub graph by a filter function over edges.
    + `((A, B) t) subgraphNodeFi(((nodeid, A) -> bool) f, ((A, B) t) graph)`. Like subgraphNodeF, but the filter function also takes the indices as input.
    + `((A, B) t) subgraphEdgeFi(((edgeid, B) -> bool) f, ((A, B) t) graph)`. Like subgraphEdgeF, but the filter function also takes the indices as input.
    + `unit toFile(((A, B) t) graph, string fileName)`. Save a graph to file.
