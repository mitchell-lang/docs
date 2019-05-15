---
has_children: true
permalink: /basic/
---
## Mitchell Libraries

* [Basic Libraries](#basic-libraries)
   * [utils](#utils)
      * [Dependencies](#dependencies)
      * [Methods](#methods)
   * [sort](#sort)
      * [Dependencies](#dependencies-1)
      * [Methods](#methods-1)
   * [hashtable](#hashtable)
      * [Dependencies](#dependencies-2)
      * [Methods](#methods-2)
   * [unique](#unique)
      * [Dependencies](#dependencies-3)
      * [Methods](#methods-3)
   * [mlrandom](#mlrandom)
      * [Dependencies](#dependencies-4)
      * [Methods](#methods-4)
   * [mlarray](#mlarray)
      * [Dependencies](#dependencies-5)
      * [Methods](#methods-5)
   * [mltree](#mltree)
      * [Dependencies](#dependencies-6)
      * [Methods](#methods-6)
   * [mlheap](#mlheap)
      * [Dependencies](#dependencies-7)
      * [Methods](#methods-7)
   * [mlvector](#mlvector)
      * [Dependencies](#dependencies-8)
      * [Methods](#methods-8)
   * [mlmatrix](#mlmatrix)
      * [Dependencies](#dependencies-9)
      * [Methods](#methods-9)
   * [mlgraph](#mlgraph)
      * [Dependencies](#dependencies-10)
      * [Methods](#methods-10)
   * [hashset](#hashset)
      * [Dependencies](#dependencies-11)
      * [Methods](#methods-11)
   * [binary](#binary)
      * [Dependencies](#dependencies-12)
      * [Methods](#methods-12)
* [Advanced Libraries](#advance-libraries)
   * [nonlinear](#nonlinear)
      * [Dependencies](#dependencies-13)
      * [Methods](#methods-13)
   * [dt](#dt)
      * [Dependencies](#dependencies-14)
      * [Methods](#methods-14)
   * [cart](#cart)
      * [Dependencies](#dependencies-15)
      * [Methods](#methods-15)
   * [gbdt](#gbdt)
      * [Dependencies](#dependencies-16)
      * [Methods](#methods-16)
   * [wlKernel](#wlkernel)
      * [Dependencies](#dependencies-17)
      * [Methods](#methods-17)
   * [negsample](#negsample)
      * [Dependencies](#dependencies-18)
      * [Methods](#methods-18)
   * [skipgram](#skipgram)
      * [Dependencies](#dependencies-19)
      * [Methods](#methods-19)
   * [rnn](#rnn)
      * [Dependencies](#dependencies-20)
      * [Methods](#methods-20)
   * [community](#community)
      * [Dependencies](#dependencies-21)
      * [Methods](#methods-21)
   * [louvain](#louvain)
      * [Dependencies](#dependencies-22)
      * [Methods](#methods-22)
   * [shortestpath](#shortestpath)
      * [Dependencies](#dependencies-23)
      * [Methods](#methods-23)
   * [hhl](#hhl)
      * [Dependencies](#dependencies-24)
      * [Methods](#methods-24)

#### utils

Utils. Includes some syntactic sugar, functions that are frequently used, and extensions of SML's list and array libraries.

##### Dependencies

None.

##### Methods

- Syntactic sugar.
  + `A return(A a)`. Just return the input argument. 
  + `(B list) foreach((A -> B) f, (A list) l)`. Just map a list`l` to another with respect to mapping function `f`.
- Functions used frequently.
  + `int intPow(int a, int b)`. Return `a^b`.
  + `real mlsq(real a)`. Return `a^2`.
  + `(A option) betterOpt(((A, A) -> bool) comp, (A option) opt1, (A option) opt2)`. Return one of the two input arguments with respect to the comparing function `comp`. If one of them is `NONE`, choose the other.
- ExtendedList. A complement to the List module.
  + `(B list) mapi(((int, A) -> B) f, (A list) l)`. Like map, but the mapping function also takes the indices as input.
  + `B foldli(((B, int, A) -> B) f, B default, (A list) l)`. Like fold, but the recursive function also takes the indices as input.
  + `string toString((A -> string) f, (A list) l))`. Convert a list to a string; the first argument describes how to convert the polymorphic element to a string.
  + `(A option) bestOpt(((A, A) -> bool) comp, (A list) l)`. Find the best element in a list with respect to a comparison function. If the list is empty, return `NONE`.
  + `(A list) subtract(((A, A) -> bool) eq, (A list) l1, (A list) l2)`. Subtract l2 from l1. The first argument is an equality function that describes when two polymorphic element are the same.
  + `A bestDefault(((A, A) -> bool) comp, A default, (A list) l)`. Like bestOpt, but return default value instead of `NONE`.
- ExtendedArray. A complement to the Array module.
  + `string toString((A -> string) f, (A array) arr)`. Convert an array to a string; the first argument describes how to convert the polymorphic element to a string.
  + `(A array) copy((A array) arr)`. Copy an array.
  + `(B array) map((A -> B) f, (A array) arr)`. Map an array to another with respect to the mapping function `f`.

#### sort

Sorting functions(quicksort for lists and arrays).

##### Dependencies

None.

##### Methods

- `unit quickSortArray(((A, A) -> bool) comp, (A array) arr)`. Sort an array using an in-place quicksort algorithm. The first argument is the comparison function.
- `(A list) quickSortList(((A, A) -> bool) comp, (A list) l)`. Sort an input list using the quicksort algorithm and return the sorted list. The first argument is the comparison function.
- `(int list) quickSortListIncrease(((int, int) -> bool) comp, (int list) l)`. Sort a list of integers.

#### hashtable

A hashtable module from SML/NJ.

##### Dependencies

None.

##### Methods
- HashString. 
  + `val hashString: string -> word`. Hash a string to a word, which is a binary number, whose size depends on the underlying architecture.
- HashTable. hashtable has type `(A, B) hash_table`, `A` is the type of the key, `B` is the type of value.
  + `((A,B) hash_table) mkTable((A -> word) hashf, ((A * A) -> bool) comp, int len)`. Given a hashing function(hash an object to a word, which is a binary number, whose length depends on the architecture) and an equality predicate, create a new table; len is a size hint.  `MLton.hash` is a general hash function that works for all objects, `HashString.hashString` is designed for strings.
  + `unit clear(((A, B) hash_table) table)`. Remove all elements from the table. 
  + `unit insert(((A, B) hash_table) table, (A key, B value))` Insert an item. If the key already has an item associated with it, then the old item is discarded.
  + `bool inDomain(((A, B) hash_table) table, A key)`. Return true, if the key is in the domain of the table.
  + `B lookup(((A, B) hash_table) table, A key)`. Find an item; an exception is raised if the item doesn't exist. 
  + `(B option) find(((A, B) hash_table) table, A key)`. Look for an item, return NONE if the item doesn't exist.
  + `B remove(((A, B) hash_table) table, A key)`. Remove an item, returning the item. An exception is raised if the item doesn't exist.
  + `int numItems(((A, B) hash_table) table)`. Return the number of items in the table.
  + `(B list) listItems(((A, B) hash_table) table)`. Return a list of the items in the table.
  + `((A, B) list)) listItemsi(((A, B) hash_table) table)`. Return a list of the items and their keys in the table.
  + `unit app((B -> unit) f, ((A, B) hash_table) table)`. Apply a function to the values of the table.
  + `unit appi(((A, B) -> unit) f, ((A, B) hash_table) table)`. Apply a function to the entries of the table 
  + `((A, C) hash_table) map((B -> C) f, ((A, B) hash_table) table)`. Map a table to a new table that has the same keys.
  + `((A, C) hash_table) mapi(((A, B) -> C) f, ((A, B) hash_table) table)`. Like map, but the mapping function also takes keys as input.
  + `C fold(((B, C) -> C) f, C default, ((A, B) hash_table) table)`. Fold a function over the values of a table.
  + `C foldi(((A, B, C) -> C) f, C default, ((A, B) hash_table) table)`. Like fold, but the recursive function also takes keys as input.
  + `unit modify((B -> B) f, ((A, B) hash_table) table)`. Modify the hash-table items in place. Notice that the input type in the modification function is the same as output type, which is different from the mapping function.
  + `unit modifyi(((A, B) -> B) f, ((A, B) hash_table) table)`. Like modify, but modification function also takes keys as input.
  + `unit filter((B -> bool) f, ((A, B) hash_table) table)`. Remove any hash table items that do not satisfy the given predicate.
  + `unit filteri(((A, B) -> bool) f, ((A, B) hash_table) table)` Like filter, but the predicate argument also takes keys as input.
  + `((A, B) hash_table) copy(((A, B) hash_table) table)`. Create a copy of a hash table.
  + `(int list) bucketSizes(((A, B) hash_table) table)`. Returns a list of the sizes of the various buckets. This is to allow users to gauge the quality of their hashing function.
  
#### unique

A unique(rename) module, which could map discrete instances to `0, 1, 2, 3...`.

##### Dependencies

None.

##### Methods

- Unique. Record all elements it has been given, and rename them to `0, 1, 2, 3...`. A unique module for `A` will have type `A Unique.t`.
  + `(A t) init(((A, A) -> bool) comp)`. Initiazlie a unique instance using 'comp' as a comparison function. The size of the instance can grow automatically,
  + `((A t), int) unique((A t) u, A a)`. Rename an object to a natural number, and return the new unique instance and the number. If an object is recorded, the returned number will be the same.
  + `int itemsNum((A t) u)`. Return how many items have been recorded.
    
#### mlrandom

Random int/real library,

##### Dependencies

None.

##### Methods

- Mlrandom.
    + `unit init()`. Initialize the Mlrandom module.
    + `int rand()`. Return a random integer.
    + `int uniformInt(int l, int h)`. Return an integer in range [l, h).
    + `real uniformReal(real l, real h)`. Return a real number in range [l, h).

#### mlarray

An array can grow automatically. If a supplied index exceeds the current size, the length of the array will be increased to accommodate the new index.

##### Dependencies

None.

##### Methods

- Mlarray. Array has type `A mlarray`, where `A` is the type of the elements.
    + `(A mlarray) makeInit(int num, A default)`. Make and initialize every element in the array.
    + `(A mlarray) make(int num, A default)`. Allocate the memory, but do not init.
    + `(A mlarray) copy((A mlarray) arr)`. Copy an array.
    + `B foldl(((A, B) -> B) f, B default, (A mlarray) arr)`. Fold a function over the elements of a array.
    + `B foldli(((int, A, B) -> B) f, B default, (A mlarray) arr)`. Like fold, but the recursion function also takes indices as input.
    + `(A mlarray) fromList((A list) l)`. Convert a list to mlarray.
    + `int length((A mlarray) arr)` Return the actual number of elements in the array.
    + `int maxLen((A mlarray) arr)`. The size(space usage) of the array (including indices not yet bound to values.)
    + `unit modify((A -> A) f, (A mlarray) arr)`. Modify an mlarray in place. 
    + `unit modifyi(((int,  A) -> A) f, (A mlarray) arr)`. Like modify, but the modification function also takes indices as input.
    + `A sub((A mlarray) arr, int n)`. Return the nth element in array(like arr[n] in some languages).
    + `unit update((A mlarray) arr, int idx, A a)`. Update the element in the idx position to `a`(like arr[idx] := a in some languages).
    + `string toString((A -> string) f, (A mlarray) arr)`. Convert a mlarray to string, the first argument describes how to convert the polymorphic element to string.
    + `string toStringSub((A -> string) f, (A mlarray) arr, (int start, int end))`. Like `toString`, but convert a subarray to string. The third argument is a tuple which describes the position of subarray: [start, end).
    + `(B mlarray) compre((A -> B) f, (A mlarray) arr)`. Comprehension, like map, but can run in parallel.
    + `(B mlarray) comprei(((int, A) -> B) f, (A mlarray) arr)`. Comprehension, like mapi, but can run in parallel.
    + `unit pushback((A mlarray) arr, A a)`. Push an element to the end of array. If the index exceeds the size of the array, the length of array will be doubled.
    + `A pop((A mlarray) arr)`. Pop an element from the end of array.  The memory allocated to the array is not reduced.

#### mltree

A tree module, supporting multi-ary trees.

##### Dependencies

None.

##### Methods

- Mltree. Tree has type `A Mltree.tree`, where `A` is the type of the nodes in tree.
    + `string toString((A -> string) f,  (A tree) tree)`. Convert a tree to a string.
    + `(B tree) compre((A -> B) f, (A tree) tree)`. Comprehension. map a tree to another in parallel. The second argument how to compre two polymorphic elements.
    + `(A tree) makeLf(A a)`. Build a tree with a single leaf.
    + `(A tree) makeNd(A a, ((A tree) list) l)`. Build a tree from an element and a list of subtrees.
    + `A root((A tree) tree)`. Return the root of tree.
    + `int num((A tree) tree)`. Return the number of elements in the tree(the sum of the tree's nodes and leaves)

#### mlheap

A heap module.

##### Dependencies

utils, mlarray.

##### Methods

- Kheap. Heap has type `A Mlheap.t`, where `A` is the type of the elements.
    + `(A t) make(((A, A) -> bool) comp, int k, int size, A default)`. Make a heap, which implemented by a k-ary tree. The second element indicate the number of branches in the explicit tree. Empirically, we observe good performance when `k = 4`. The first argument describes how to compare two polymorphic elements.
    + `unit push((A t) heap, A a)`. Push an element into the heap.
    + `unit pop((A t) heap)`. Pop the element at the top of heap. 
    + `bool empty((A t) heap)`. Return true if the heap is empty.
    + `A top((A t) heap)`. Return the top of the heap.
    + `(B t) compre((A -> B) f,((B, B) -> bool) comp, (A t) heap)`. Comprehension that maps one heap to another in parallel. 'comp' is a comparison function.
    + `string toString((A -> string) f, (A t) heap)`. Convert a heap to a string.
    
#### mlvector

A vector of real numbers, which includes some math functions on vectors.

##### Dependencies

None.

##### Methods

- Mlvector. Mlvector has type `A mlvector`, where `A` is the type of the elements.
    + `int size(mlvector vec)`. Return the length of vector.
    + `mlvector make(int len, real default)`. Make a vector, filling every element to a default value.
    + `mlvector makeInit((int -> real) f, int len)`. Make a vector, initializing every element using initialization function `f`. `f` maps the contents of an index to a default value.
    + `real sub(mlvector vec, int n)`. Return the nth element in the vector.
    + `unit set(mlvector vec, int n, real r)`. Update the nth element in a vector to `r`(e.g., vec[n] := r).
    + `unit update((real -> real) f, mlvector vec, int n)`. Update the nth element with respect to its old value(e.g., vec[n] := f(vec[n])).
    + `unit modify((real -> real) f, mlvector vec)`. Modify a vector in place.
    + `unit modifyi(((int, real) -> real) f, mlvector vec)`. Like modify, but the modification function also takes indices as input.
    + `A foldl(((A, real) -> A) f, A default, mlvector vec)`. Fold a function over the elements of a vector.
    + `A foldli(((A, int, real) -> A) f, A default, mlvector vec)`. Like fold, but the recursive function also takes indices as input.
    + `mlvector copy(mlvector vec)`. Copy an mlvector.
    + `real squeeze(mlvector vec)`. Squeeze a 1-dimension vector to a scalar. Return vec[0].
    + `mlvector map((real -> real) f, mlvector vec)`. Map one vector to another with respect to the mapping function `f`.
    + `mlvector mapi(((int, real) -> real) f, mlvector vec)`. Like map, but the mapping function also takes the indices as input.
    + `mlvector map2(((real, real) -> real) f, mlvector vec1, mlvector vec2)`. Map over two vectors. The length of the result vector is equal to the minimal length of `vec1` and `vec2`.
    + `mlvector elemwise(mlvector vec1, mlvector vec2)`. Element-wise multiply two vectors.
    + `mlvector add(mlvector vec1, mlvector vec2)`. Add two vectors.
    + `unit addModify(mlvector vec1, mlvector vec2)`. Add two vectors, modify the first vec to the result in place.
    + `mlvector mulScalar(mlvector vec, real a)`. Multiply a vector with a scalar.
    + `real dot(mlvector vec1, mlvector vec2)`. Dot product.
    + `string toStringF((real -> string) f, mlvector vec)`. Convert a mlvector to string, where the first argument describes how to convert the element to string.
    + `string toString(mlvector vec)`. Convert a mlvector to string using default format.
    + `mlvector fromList((real list) l)`. Convert a list of real numbers to an mlvector.

#### mlmatrix

A matrix of real numbers, which includes some math functions on matrices.

##### Dependencies

mlvector.

##### Methods

- Mlmatrix. Mlmatrix has type `A mlmatrix`, where `A` is the type of the elements.
	+ `(int, int) size(mlmatrix mat)`. Return the size(the first element in tuple is height, second is width) of a matrix.
	+ `mlmatrix makeInit((int -> mlvector) f, int height)`. Make and init a matrix, each row of matrix will be set by `f`. `f` takes the index of height as input.
    + `mlmatrix make(int height, int width, real default)`. Make a matrix, and set every elements in it to default value.
	+ `real sub(mlmatrix mat, (int idx1, int idx2))`. Return mat[idx1][idx2].
	+ `mlmatrix row(mlmatrix mat, int idx)`. Return one row of a matrix as a "1 x n" matrix.
    + `mlmatrix col(mlmatrix mat, int idx)`. Return one column of a matrix as a "m x 1" matrix.
    + `mlvector onerow(mlmatrix mat, int idx)`. Like `row`, but squeeze the result to vector.
    + `mlvector onecol(mlmatrix mat, int idx)`. Like `col`, but squeeze the result to vector.
    + `unit set(mlmatrix mat, (int idx1, int idx2), real r)`. Update the element in mat[idx1][idx2] to `r`.
    + `unit update((real -> real) f, mlmatrix mat, (int idx1, int idx2))`. Update the element in mat[idx1][idx2] to `f(mat[idx1][idx2])`.
    + `unit modify((real -> real) f, mlmatrix mat)`. Modify every element in matrix by `f` in place.
    + `unit modifyi(((int, int, real) -> real) f, mlmatrix mat)`. Like modify, but the modification function takes indices as input too.
    + `unit modifyrowi(((int, mlvector) -> unit) f, mlmatrix mat)`. Modify a matrix by rows in place.
    + `mlmatrix copy(mlmatrix mat)`. Copy a matrix.
    + `mlmatrix vec2mat(mlvector vec)`. Convert a vector to "1 x n" matrix.
    + `mlvector squeeze1(mlmatrix mat)`. Squeeze a "1 x n" matrix to a vector.
    + `mlvector squeeze2(mlmatrix mat)`. Squeeze a "m x 1" matrix to a vector.
    + `real squeeze12(mlmatrix mat)`. Squeeze a "1 x 1" matrix to a real number.
	+ `mlmatrix map((real -> real) f, mlmatrix mat)`. Map an matrix to another with respect to the mapping function `f`.
	+ `mlmatrix mapi(((int, int, real) -> real) f, mlmatrix mat)`. Like map, but the mapping function also takes the indices as input.
    + `mlmatrix map2(((real, real) -> real) f, mlmatrix mat1, mlmatrix mat2)`. Map on two matrices, the result will have the minimal size of these two matrices.
    + `mlmatrix map2i(((int, int, real, real) -> real) f, mlmatrix mat1, mlmatrix mat2)`. Like map2, but the mapping function also takes the indices as input.
	+ `A foldl(((A, real) -> A) f, A default, mlmatrix mat)`. Fold a function over the elements of a table.
	+ `A foldli(((A, int, int, real) -> A) f, A default, mlmatrix mat)`. Like fold, but recursion function also takes keys as input.
    + `A foldRowl((A, mlmatrix) -> A) f, A default, mlmatrix mat)`. Fold a function over the rows of a table.
    + `A foldRowVecl((A, mlvector) -> A), A default, mlmatrix mat)`. Like foldRowl, but treat a row as a vector instead of a matrix.
    + `mlmatrix transpose(mlmatrix mat)`. Transpose a matrix.
    + `mlmatrix mulScalar(mlmatrix mat, real a)`. Multiply a matrix with a real number.
    + `mlmatrix mul(mlmatrix mat1, mlmatrix mat2)`. Multiply two matrices.
    + `mlmatrix add(mlmatrix mat1, mlmatrix mat2)`. Add two matrices.
    + `unit addModify(mlmatrix mat1, mlmatrix mat2)`. Like Add, but modify the first matrix instead of return a new matrix.
    + `mlmatrix elemwise(mlmatrix mat1, mlmatrix mat2)`. Element wisely multiply two matrices, the result will have the minimal size of these two matrices.
    + `unit elemwiseInplace(mlmatrix mat1, mlmatrix mat2)`. Like elemwise, but modify the first matrix instead of return a new matrix.
    + `mlmatrix matMulVec(mlmatrix mat, mlvector vec)`. Multiply a matrix with a vector, treat the vector as a "m x 1" matrix.
    + `mlmatrix fromArray2((real array array) arr2)`. Convert an array of array of real to mlmatrix.
    + `mlmatrix fromList((real list list) l2)`. Convert an list of list of real to mlmatrix.
    + `string toStringF((real -> string) f, mlmatrix mat)`. Convert a matrix to a string, the first argument describes how to convert the element to string.
    + `string toString(mlmatrix mat)`.  Convert a matrix to a string using default format.


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

#### hashset

Hashset.

##### Dependencies

hashtbl.

##### Methods

- Hashset. hashset has type `A Hashset.t`, where `A` is the element of the set.
    + `(A t) make((A, A) -> bool) comp, int size)`. Make a hashset. The first describes how to compare two elements.
    + `int numSet((A t) hs)`. Return the number of sets in a hashset.
    + `int numElement((A t) hs)`. Return the number of elements in a hashset.
    + `unit normalize((A t) hs)`. Rename the set id, from `0`.
    + `int whichSet((A t) hs, A a)`. Find which set the element `a` is belonged.
    + `bool sameSet((A t) hs, A a, A a)`. Return if two elements are in the same set.
    + `unit insert((A t) hs, A a)`. Insert a element to a new set.
    + `bool merge((A t) hs, ((A, A) list) l)`. Merge sets by a list of element pair. If the sets is changed, return true; else return false.
    + `bool equal((A t) hs1, (A t) hs2)`. Compare two hashsets.
    + `(A list) getSetMember((A t) hs, A a)`. Return all elements in the same set with input element.
    + `unit add((A t) hs, A a)`. Add a element even if it already inserted.
    + `unit toString((A -> string) f, (A t) hs)`. Convert a hashset to string, the first argument describes how to convert a polymorphic element to string.
    + `B fold(((B, A) -> B) f, B default, (A t) hs)`. Fold over all elements.
    + `(B t) compre((A -> B) f, ((B, B) -> bool) comp, (A t) hs)`. Map over all elements. the second argument describes how to compare two elements.

    
#### binary 

Binary number with fixed length.

##### Dependencies

None.

##### Methods

- Binary. binary has type `binary`.
    + `int length()`. Return the fixed length.
    + `binary max()`. Return the max binary number.
    + `binary zero()`.  Return zero.
    + `binary fromInt(int n)`. Convert a integer to binary number.

### Advance Libraries

- nonlinear
- dt
- cart
- gbdt
- wlkernel
- negsample
- skipgram
- rnn
- community
- louvain
- shortestpath
- hhl


#### nonlinear

Nonlinear functions(activation functions).

##### Dependencies

None.

##### Methods

- Nonlinear.
    + `real sigmoid(real x)`. Sigmoid, return `1.0 / (1.0 + (e^(-x)))`.
    + `real dsigmoid(real x)`. Derivative of sigmoid.
    + `real tanh(real x)`. Tanh.
    + `real dtanh(real x)`. Derivative of tanh.
    + `real sigmoidf(real x)`. Also Sigmoid.
    + `real sigmoidh(real x)`. Return `2.0 / (1.0 + (e^(-x))) - 1.0`.
    + `real sigmoidg(real x)`. Return `4.0 / (1.0 + (e^(-x))) - 2.0`.
    + `real softmax((real array) arr, int n)`. Softmax.
    + `real exp(real x)` Return e^x.
    + `real log(real x)`. Return ln(x). 


#### dt

Decision tree.

##### Dependencies

None.

##### Methods

- DecisionTree(for discrete situation, feature and label is integer: `label = int`) and DecisionTreeReal(for continuous situation, feature and label is real: `label = real`). A decision tree has type `DecisionTree.t` or `DecisionTreeReal.t`. `features` is a collection of features which has type `label array`, it is `int array` or `real array` respectively.
    + `bool lessFeature(features ft, (int, label) p))`. Compare that if the input value is less than the nth feature in the features array.
    + `label forward(t dt, features a)`. Forward of decision tree: given a collection of features as input, return predicted label by decision tree.
    + `t makeLf(label a)`. Make a decision tree from a single label.
    + `t makeNd(t dt1, feature ft, t dt2)`. Make a decision tree from two other subtrees and a feature.
    + `string toString(t dt)`. Convert a decision tree to a string.
    + `((features, label) list), ((features, label) list) split(((features, label) list) data, (int * label) p)`. Split a list of input data by one specific feature. The input data is actually a collection of features and its label. 
    + `t recordsToString(((features, label) list) l)`. Convert a list of data to string.
    + `t leafNum(t dt)`. Return how many leaves in the decision tree.

#### cart

Decision tree training algorithm: CART.

##### Dependencies

dt.

##### Methods

- Cart(for discrete situation, using DecisionTree) and CartReal(for continuous situation, using DecisionTreeReal). Cart can train and prune a decision tree.
    + `DT.t  train(((DT.features, DT.label) list) data)`. Train a decision tree, no pruning.
    + `((real, DT.t) list)  prune(DT.t dt, ((DT.features, DT.label) list) data)`. Prune a tree, generate a collection of pruned trees. Each tree has a evaluation value: alpha(See CART papers for details). User can choose one of these tree as pruned result.
    + `DT.t  crossValidationTrain(((DT.features, DT.label) list) data)`. Use cross validation training to find the best pruned tree. `70%` data will be used in training, the rest of data will be use to test.
    + `real  error(DT.t dt, ((DT.features * DT.label) list) data)`. Return the error of a decision tree on the input data.
    
#### gbdt

Gradient boosting decision tree.

##### Dependencies

dt, cart.

##### Methods

- GBDT uses CartReal and DecisionTreeReal. A Gbdt is a collection of decision trees, which has type `Gbdt.t`.
    + `DT.label  forward(t gbdt, DT.features ft)`. Forward of gbdt: given a collection of features as input, return predicted label by gbdt.
    + `real  error(t gbdt, ((DT.features, DT.label) list) data)`. Return the error of a gbdt ob the input data.
    + `t  train(((DT.features, DT.label) list) data, real learningRate, int num).` Train a gbdt, the third variable is how many epochs to train.
    + `string toString(t gbdt)`. Convert a gbdt to a string.

#### wlKernel

Random walk kernel.

##### Dependencies

NONE

##### Methods

- WlKernel.
    + `(word list list) wlGraph((((int, int), (int list)) list list) graph, int depth)`. Random walk to embed graphs. The first argument is a collection of graphs, each graph is represented a list, each line in list includes the index of node in the graph, the information bound, and a list of int represents its neighbors' indices. The second argument is the depth of walking. The result is a list of embedding of input graphs. Each graph is embedded as a list of word(See graph2vec papers for details).

#### negsample

negative sampling.

##### Dependencies

NONE

##### Methods

- Negsample.
    + `t dict((int array array) data, int vocabSize).` Statistic the frequency of vocabularies. The vocabularies as represented as integers, from `0` to `vocabSize - 1`. The input data is treated as a list of paragraph, a paragraph is a list of words.
    + `(int, (int list)) sampleContext(t ns, int numContext)`. Sample the context of a word. Randomly choose a word(weighted by its frequency), return its context(the words appear front and ahead of it).
    + `(int list) negSample(t ns, int pid, int numNeg)`. Sample the words not in a specific paragraph(pid).
    + `int vocabSize(t ns)`. Return the number of vocabularies.

#### skipgram

skip-grammar.

##### Dependencies

mlvector, mlmatrix, nonlinear.

##### Methods

- Skipgram. A Skipgram instance has type `Skipgram.t`
    + `t make(mlmatrix embed, mlmatrix w)`. Make a Skipgram neural network by two matrices: embedding matrix and weighted output matrix.
    + `t init(int paragraphNum, int vocabNum, int embedingLength) -> t`. Make a Skipgram neural network by the size of embedding matrix and weighted output matrix. Embedding matrix has size: `paragraphNum` x `embedingLength`, which means each paragraph is embedded to a vector with length `embedingLength`. Output matrix has size: `vocabNum` x `embedingLength`, which means for each given word, the skipgram will try to find the probability it appears in a paragraph.
    + `real train(t sg, (int, (int list), (int list)) data, real learningRate)`. Forward and backward execution. The second argument is input data which is a tuple: first element is the sampling word, the second element is a list containing the words in its context (i.e., those that appear near it in document), the third element is a list containing negative samples, which are words that are not in its context. The return result is the error. The skipgram will updates itself after each forward step.
    
#### rnn

Recurrent neural network.

##### Dependencies

mlvector, mlmatrix, nonlinear.

##### Methods

- Rnn. When create a rnn module, need indicate the `innode`, `hidenode` and `outnode`. See lstm example code for details. Rnn has type `rnn`. 
    + `run init(((int, int) -> real) f)`. Init rnn, the input argument will give all element in matrix a initial value by their indices.
    + `(matrix, (rnnrecord list)) forward(rnn rnn, mlmatrix data)`. Forward, input and output is both matrix, and rnn will also output a record for backward.
    + `unit backward(rnn rnn, (rnnrecord list) records, mlmatrix data, mlmatrix ans, real learningRate)`. Backward. The second argument is one of output of forward, the forth argument is the expected answers.
    + `unitd train(rnn rnn, ((mlmatrix, mlmatrix) list) data, real learningRate)`. Run forward and then backward. the second argument is input data and expected answers.
    
#### community

A data structure used in louvain algorithm, which is basically a int hashset.

##### Dependencies

hashset.

##### Methods

- Community. Community has type `Community.t`.
    + `t make(int size)`. Init a Community with size.
    + `int numSet(t commu)`. Return the number of sets in Community.
    + `unit normalize(t commu)`. Rename the set id, from `0`.
    + `int whichSet(t commu, int id)`. Return the set which includes that element id.
    + `bool sameSet(t commu, int id1, int id2)`. Return if two elements are in the same set.
    + `bool merge(t commu, ((int * int) list) l)`.  Merge sets by a list of element pair. If the sets is changed, return true; else return false.
    + `bool equal(t commu1, t commu2)`. Compare two communities.
    + `(int list) getSetMember(t commu, int id)`. Return all elements in the same set with input element.

#### louvain

louvain algorithm.

##### Dependencies

community, mlgraph.

##### Methods

- Louvain. Mlgraph has type `G.t` for short, community has type `C.t` for short.
    + `((unit, int) G.t) newGraph((int array array) adj)`. Build a graph from adjacency matrix for louvain algorithm.
    + `real calDeltaQ(((unit, int) G.t) graph, int nid, (int list) group)`. Calculate delta Q value(see louvain papers for details).
    + `((unit, unit) G.t) merge(((unit, int) G.t) graph, C.t commu)`. Merge a graph by community.
    + `string graphToString(((unit, int) G.t) graph)`. Convert a graph to string.
    
#### shortestpath

Find the shortest path of a graph.

##### Dependencies

mlgraph, mltree.

##### Methods

- Dijkstra.
    + `(int array) shortestPath(((A, B) G.t) graph, int nodeid)`. Return the distances from source node to others. The result is an array, the index is the target node id, the value is the distance.
    + `(node Mltree.tree) toTree(int nodeid, (distance array) arr)`. Build a short path tree from the distances array.
    
#### hhl

Hub Labeling algorithm.

##### Dependencies

mlgraph, mltree, shortestpath.

##### Methods

- hhl.
    + `(((int * int) list, unit) G.t) hhl(((unit, unit) G.t) graph)`. Run hhl algorithm, return a new graph which binds hhl labels on each nodes.
    + `(int option) forward((((int, int) list, unit) G.t) graph, int source, int target)`. Get the shortest distance between source and target node. If they are not connected, return `NONE`.

