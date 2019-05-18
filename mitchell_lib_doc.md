---
has_children: true
permalink: /basic/
---
# Mitchell Libraries

## Using Libraries

Mitchell uses the Standard ML module system. You can read about how to use
modules provided by libraries [here](faq/modules.md).

## The Standard Basis Library

Mitchell includes most of the Standard Basis Library for Standard ML.
Documentation for the Standard Basis Library can be found
[here](http://sml-family.org/Basis/). Documentation for the individual modules
from the library can be found [here](http://sml-family.org/Basis/manpages.html)

The Standard Basis Library includes several modules for interacting with the
operating system or for performing IO. We have provided that functionality here
to assist you with inputting data into your program, with outputting results
from your program, and with debugging. However, IO is not supported on the
hardware accelerator where your implementation will eventually run. We ask that
you keep any IO that you need to do separate from the rest of your algorithm.

The following modules from the Standard Basis Library may be particularly useful
to you:

- [Lists](http://sml-family.org/Basis/list.html)
- [Fixed-Size Mutable Arrays](http://sml-family.org/Basis/array.html)
- [Fixed-Size Mutable 2D Arrays](http://sml-family.org/Basis/array2.html)
- [Fixed-Size Immutable Vectors](http://sml-family.org/Basis/vector.html)
- [Strings](http://sml-family.org/Basis/string.html) and
  [Substrings](http://sml-family.org/Basis/substring.html)
  - See the [IO and parsing tutorial](tutorials/tutorial-io-parsing.md) for
    examples of use.
- [Math](http://sml-family.org/Basis/math.html)
- [Integer](http://sml-family.org/Basis/integer.html),
  [Word](http://sml-family.org/Basis/word.html), and
  [Real](http://sml-family.org/Basis/real.html)
- [Text IO](http://sml-family.org/Basis/text-io.html)
  - See the [IO and parsing tutorial](tutorials/tutorial-io-parsing.md) for
    examples of use.

## Data Structures and Utilities

The following data structures and utilities are provided by Mitchell.

- [Hash Tables (Dictionaries)](./basic/mlhashtable.md)
- [Hash Sets](./basic/mlhashset.md)
- [Graphs](./basic/mlgraph.md)
- [Vectors](./basic/mlvector.md)
- [Matrices](./basic/mlmatrix.md)
- [Heaps](./basic/mlheap.md)
- [Random Number Generation](./basic/mlrandom.md)
- [Trees](./basic/mltree.md)
- [Sorting for Lists and Arrays](./basic/sort.md)
- [Math](./basic/math.md)
  - This module includes additional convenience functions not provided by the
    Standard Basis Library math module.

## Algorithms

- Activation Functions
- Decision Trees
- Classification and Regression Trees (CART)
- Gradient Boosted Decision Trees (GBDT)
- Random Walks
- negsample
- skipgram
- Recurrent Neural Networks (RNNs)
- Communities
- Louvain
- Shortest Path
- Hierarchical Hub Labeling (HHL)


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

