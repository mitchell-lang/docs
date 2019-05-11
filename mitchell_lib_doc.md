## Mitchell Libraries

### Basic Libraries

- utils
- sort
- hashtable
- unique
- mlrandom
- mlarray
- mlheap
- mltree
- mlvector
- mlmatrix
- mlgraph
- hashset
- binary

#### utils

Utils. Includes some syntax sugars, some functions used frequently and extensions of SML list and array module.

##### Dependencies

None.

##### Methods

- Syntax sugar.
  + `A return(A a)`. Just return the input argument. 
  + `(B list) foreach((A -> B) f, (A list) l)`. Just map a list`l` to another with respect to mapping function `f`.
- Functions used frequently.
  + `int intPow(int a, int b)`. Return `a^b`.
  + `real mlsq(real a)`. Return `a^2`.
  + `(A option) betterOpt(((A, A) -> bool) comp, (A option) opt1, (A option) opt2)`. Return the better one in two input arguments with respect to the comparing function `comp`. If one of them is `NONE`, choose another one.
- ExtendedList. A complement to the List module.
  + `(B list) mapi(((int, A) -> B) f, (A list) l)`. Like map, but the mapping function also takes the indices as input.
  + `B foldli(((B, int, A) -> B) f, B default, (A list) l)`. Like fold, but the recursion function also takes the indices as input.
  + `string toString((A -> string) f, (A list) l))`. Convert a list to a string, the first argument describes how to convert the polymorphic element to a string.
  + `(A option) bestOpt(((A, A) -> bool) comp, (A list) l)`. Find the best one in a list with respect to a comparing function. If the list is empty, return `NONE`.
  + `(A list) subtract(((A, A) -> bool) eq, (A list) l1, (A list) l2)`. Subtract l2 from l1. The first argument is equality function which describes when two polymorphic element are the same.
  + `A bestDefault(((A, A) -> bool) comp, A default, (A list) l)`. Like bestOpt, but return default value instead of `NONE`.
- ExtendedArray. A complement to the Array module.
  + `string toString((A -> string) f, (A array) arr)`. Convert a array to a string, the first argument describes how to convert the polymorphic element to a string.
  + `(A array) copy((A array) arr)`. Copy an array.
  + `(B array) map((A -> B) f, (A array) arr)`. Map an array to another with respect to the mapping function `f`.

#### sort

Sorting functions(quick sort for list and array).

##### Dependencies

None.

##### Methods

- `void quickSortArray(((A, A) -> bool) comp, (A array) arr)`. Sort an array using quick sort algorithm in place. The first argument describes how to compare two polymorphic elements.
- `(A list) quickSortList(((A, A) -> bool) comp, (A list) l)`. Sort a list using quick sort algorithm and return sorted list. The first argument describes how to compare two polymorphic elements.
- `(int list) quickSortListIncrease(((int, int) -> bool) comp, (int list) l)`. Sort int list with increasing order by quickSortList.

#### hashtable

A hashtable module from SML/NJ.

##### Dependencies

None.

##### Methods
- HashString. 
  + `val hashString: string -> word`. Hash a string to a word, which is a binary number, its length is depends on the architecture.
- HashTable. hashtable has type `(A, B) hash_table`, `A` is the type of the key, `B` is the type of value.
  + `((A,B) hash_table) mkTable((A -> word) hashf, ((A * A) -> bool) comp, int len)`. Given a hashing function(hash a object to a word, which is a binary number, its length is depends on the architecture) and an equality predicate, create a new table; the int is a size hint and the exception is to be raised by find. `MLton.hash` is a general hash function works for all objects, `HashString.hashString` also works for string.
  + `void clear(((A, B) hash_table) table)`. Remove all elements from the table. 
  + `void insert(((A, B) hash_table) table, (A key, B value))` Insert an item. If the key already has an item associated with it, then the old item is discarded.
  + `bool inDomain(((A, B) hash_table) table, A key)`. Return true, if the key is in the domain of the table.
  + `B lookup(((A, B) hash_table) table, A key)`. Find an item, the table's exception is raised if the item doesn't exist. 
  + `(B option) find(((A, B) hash_table) table, A key)`. Look for an item, return NONE if the item doesn't exist.
  + `B remove(((A, B) hash_table) table, A key)`. Remove an item, returning the item. The table's exception is raised if the item doesn't exist.
  + `int numItems(((A, B) hash_table) table)`. Return the number of items in the table.
  + `(B list) listItems(((A, B) hash_table) table)`. Return a list of the items in the table.
  + `((A, B) list)) listItemsi(((A, B) hash_table) table)`. Return a list of the items and their keys in the table.
  + `void app((B -> void) f, ((A, B) hash_table) table)`. Apply a function to the values of the table.
  + `void appi(((A, B) -> void) f, ((A, B) hash_table) table)`. Apply a function to the entries of the table 
  + `((A, C) hash_table) map((B -> C) f, ((A, B) hash_table) table)`. Map a table to a new table that has the same keys.
  + `((A, C) hash_table) mapi(((A, B) -> C) f, ((A, B) hash_table) table)`. Like map, but mapping function also takes keys as input.
  + `C fold(((B, C) -> C) f, C default, ((A, B) hash_table) table)`. Fold a function over the values of a table.
  + `C foldi(((A, B, C) -> C) f, C default, ((A, B) hash_table) table)`. Like fold, but recursion function also takes keys as input.
  + `void modify((B -> B) f, ((A, B) hash_table) table)`. Modify the hash-table items in place. Notice that the input type in modification function is the same as output type, which is different from mapping function.
  + `void modifyi(((A, B) -> B) f, ((A, B) hash_table) table)`. Like modify, but modification function also takes keys as input.
  + `void filter((B -> bool) f, ((A, B) hash_table) table)`. Remove any hash table items that do not satisfy the given predicate.
  + `void filteri(((A, B) -> bool) f, ((A, B) hash_table) table)` Like filter, but predicate also takes keys as input.
  + `((A, B) hash_table) copy(((A, B) hash_table) table)`. Create a copy of a hash table.
  + `(int list) bucketSizes(((A, B) hash_table) table)`. Returns a list of the sizes of the various buckets. This is to allow users to gauge the quality of their hashing function.
  
#### hashtable

An unique(rename) module, which could map discrete instances to `0, 1, 2, 3...`.

##### Dependencies

None.

##### Methods

- Unique. Record all elements it have been given, and rename them to `0, 1, 2, 3...`. A unique module for `A` will have type `A Unique.t`.
  + `(A t) init(((A, A) -> bool) comp)`. Init a unique instance by a comparison function. The size of the instance can grow automatically,
  + `((A t), int) unique((A t) u, A a)`. Rename a object to a natural number, return the new unique instance and the number. If a object is recorded, the return number will be the same.
  + `int itemsNum((A t) u)`. Return how many items have been recorded.
    
#### mlrandom

Random int/real library,

##### Dependencies

Nonet.

##### Methods

- Mlrandom.
    + `void init()`. Init Mlrandom module.
    + `int rand()`. Return a random integer.
    + `int uniformInt(int l, int h)`. Return a integer in range [l, h).
    + `real uniformReal(real l, real h)`. Return a real number in range [l, h).

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

- DecisionTree(for discrete situation, feature and label is interger: `label = int`) and DecisionTreeReal(for continuous situation, feature and label is real: `label = real`). A decision tree has type `DecisionTree.t` or `DecisionTreeReal.t`. `features` is a collection of features which has type `label array`, it is `int array` or `real array` respectively.
    + `bool lessFeature(features ft, (int, label) p))`. Compare that if the input value is less than the nth feature in the features array.
    + `label forward(t dt, features a)`. Forward of decision tree: given a collection of features as input, return predicted label by dicision tree.
    + `t makeLf(label a)`. Make a decision tree from a single label.
    + `t makeNd(t dt1, feature ft, t dt2)`. Make a decision tree from two other subtrees and a feature.
    + `string toString(t dt)`. Convert a decision tree to a string.
    + `((features, label) list), ((features, label) list) split(((features, label) list) datas, (int * label) p)`. Split a list of input data by one specific feature. The input data is actually a collection of features and its label. 
    + `t recordsToString(((features, label) list) l)`. Convert a list of data to string.
    + `t leafNum(t dt)`. Return how many leaves in the decision tree.

#### cart

Decision tree trainning algorithm: CART.

##### Dependencies

dt.

##### Methods

- Cart(for discrete situation, using DecisionTree) and CartReal(for continuous situation, using DecisionTreeReal). Cart can train and prune a decision tree.
    + `DT.t  train(((DT.features, DT.label) list) datas)`. Train a decistion tree, no pruning.
    + `((real, DT.t) list)  prune(DT.t dt, ((DT.features, DT.label) list) datas)`. Prune a tree, generate a collection of pruned trees. Each tree has a evaluation value: alpha(See CART papers for details). User can choose one of these tree as pruned result.
    + `DT.t  crossValidationTrain(((DT.features, DT.label) list) datas)`. Use cross validation training to find the best pruned tree. `70%` data will be used in tranning, the rest of data will be use to test.
    + `real  error(DT.t dt, ((DT.features * DT.label) list) datas)`. Return the error of a dicision tree on the input data.
    
#### gbdt

Gradient boosting decision tree.

##### Dependencies

dt, cart.

##### Methods

- GBDT uses CartReal and DecisionTreeReal. A Gbdt is a collection of decision trees, which has type `Gbdt.t`.
    + `DT.label  forward(t gbdt, DT.features ft)`. Forward of gbdt: given a collection of features as input, return predicted label by gbdt.
    + `real  error(t gbdt, ((DT.features, DT.label) list) datas)`. Return the error of a gbdt ob the input data.
    + `t  train(((DT.features, DT.label) list) datas, real learningRate, int num).` Train a gbdt, the third variable is how many epochs to train.
    + `string toString(t gbdt)`. Convert a gbdt to a string.

#### wlKernel

Random walk kernel.

##### Dependencies

NONE

##### Methods

- WlKernel.
    + `(word list list) wlGraph((((int, int), (int list)) list list) graph, int depth)`. Random walk to embed graphs. The first argument is a collection of graphs, each graph is represented a list, each line in list includes the index of node in the graph, the information binded, and a list of int represents its neighbors' indices. The second argument is the depth of walking. The result is a list of embeding of input graphs. Each graph is embeded as a list of word(See graph2vec papers for details).

#### negsample

negtive sampling.

##### Dependencies

NONE

##### Methods

- Negsample.
    + `t dict((int array array) datas, int vocabSize).` Statistic the frequency of vocabularies. The vocabularies as represented as intergers, from `0` to `vocabSize - 1`. The input data is treated as a list of paragraph, a paragraph is a list of words.
    + `(int, (int list)) sampleContext(t ns, int numContext)`. Sample the context of a word. Randomly choose a word(weighted by its frequency), return its context(the words appear front and ahead of it).
    + `(int list) negSample(t ns, int pid, int numNeg)`. Sample the words not in a specific paragraph(pid).
    + `int vocabSize(t ns)`. Return the number of vocabularies.

#### skipgram

skip-grammar.

##### Dependencies

mlvector, mlmatrix, nonlinear.

##### Methods

- Skipgram. A Skipgram instance has type `Skipgram.t`
    + `t make(mlmatrix embed, mlmatrix w)`. Make a Skipgram nerual network by two matrices: embeding matrix and weighted output matrix.
    + `t init(int paragraphNum, int vocabNum, int embedingLength) -> t`. Make a Skipgram nerual network by the size of embeding matrix and weighted output matrix. Embeding matrix has size: `paragraphNum` x `embedingLength`, which means each paragraph is embeded to a vector with length `embedingLength`. Output matrix has size: `vocabNum` x `embedingLength`, which means for each given word, the skipgram will try to find the probility it appears in a paragraph.
    + `real train(t sg, (int, (int list), (int list)) data, real learningRate)`. Forward and backward. The second argument is input data which is a tuple: first element is the sampling word, the second element is a list contains the words in its context(appears near it in document), the third element is a list contains negtive sampling, which is the words do not in its context. The return result is the error. The skipgram will updates itself after each forward.
    
#### rnn

Recurrent nerual network.

##### Dependencies

mlvector, mlmatrix, nonlinear.

##### Methods

- Rnn. When create a rnn module, need indicate the `innode`, `hidenode` and `outnode`. See lstm example code for details. Rnn has type `rnn`. 
    + `run init(((int, int) -> real) f)`. Init rnn, the input argument will give all element in matrix a initial value by their indices.
    + `(matrix, (rnnrecord list)) forward(rnn rnn, mlmatrix data)`. Forward, input and output is both matrix, and rnn will also output a record for backward.
    + `void backward(rnn rnn, (rnnrecord list) records, mlmatrix data, mlmatrix ans, real learningRate)`. Backward. The second argument is one of output of forward, the forth argument is the expected answers.
    + `void train(rnn rnn, ((mlmatrix, mlmatrix) list) data, real learningRate)`. Run forward and then backward. the second argument is input data and expected answers.
    
#### community

A data structure used in louvain algorithm, which is basically a int hashset.

##### Dependencies

hashset.

##### Methods

- Community. Community has type `Community.t`.
    + `t make(int size)`. Init a Community with size.
    + `int numSet(t commu)`. Return the number of sets in Community.
    + `void normalize(t commu)`. Rename the set id, from `0`.
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
    + `((void, int) G.t) newGraph((int array array) adj)`. Build a graph from adjacency matrix for louvain algorithm.
    + `real calDeltaQ(((void, int) G.t) graph, int nid, (int list) group)`. Calculate delta Q value(see louvain papers for details).
    + `((void, void) G.t) merge(((void, int) G.t) graph, C.t commu)`. Merge a graph by community.
    + `string graphToString(((void, int) G.t) graph)`. Convert a graph to string.
    
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

