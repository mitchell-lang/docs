---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Decision Trees

Decision tree.

For an example of how to use this library, see the
[Gradient Boosted Decision Trees tutorial](../../tutorials/tutorial-gbdt.md).

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
