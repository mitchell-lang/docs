---
parent: Mitchell Libraries
---
#### Gradient Boosted Decision Trees (GBDT)

Gradient boosting decision tree.

##### Dependencies

dt, cart.

##### Methods

- GBDT uses CartReal and DecisionTreeReal. A Gbdt is a collection of decision trees, which has type `Gbdt.t`.
    + `DT.label  forward(t gbdt, DT.features ft)`. Forward of gbdt: given a collection of features as input, return predicted label by gbdt.
    + `real  error(t gbdt, ((DT.features, DT.label) list) data)`. Return the error of a gbdt ob the input data.
    + `t  train(((DT.features, DT.label) list) data, real learningRate, int num).` Train a gbdt, the third variable is how many epochs to train.
    + `string toString(t gbdt)`. Convert a gbdt to a string.
