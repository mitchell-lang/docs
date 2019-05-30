---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Classification and Regression Trees (CART)

This library provides support for training and pruning
[classification and regression trees](https://en.wikipedia.org/wiki/Decision_tree_learning#Decision_tree_types).
For an example of how to use this library, see the
[Gradient Boosted Decision Trees tutorial](../../tutorials/tutorial-gbdt.md).

## Basic usage

```sml
structure DT = DecisionTreeReal
structure C = CartReal(structure DT = DT);

(* Construct a decision tree to predict whether water will be
   solid or liquid at a given temperature and pressure. We'll
   first train the tree with a list of conditions and then ask
   it to predict with conditions it hasn't seen before. *)

(* Return a feature array (DT.features) from a temperature
   (in Celcius) and pressure (in atmospheres) *)
fun features (temp, pressure) =
	Array.fromList ([temp, pressure]);

(* A list of conditions to train on. Each element of the
   list is a pair of (features, label), where label is
   arbitrarily chosen to be 1.0 for "ice" and 0.0 for "not ice". *)
val conditions = [
	(features(~13.0, 1.0), 1.0),
	(features(7.0, 1.0), 0.0),
	(features(7.0, 1.0), 0.0),
	(features(30.0, 3.0), 0.0),
	(features(~20.0, 0.001), 0.0),
	(features(~15.0, 50.0), 1.0),
	(features(~30.0, 10.0), 1.0),
	(features(~70.0, 0.1), 1.0),
	(features(10.0, 100.0), 0.0),
	(features(~3.0, 0.5), 1.0),
	(features(~1.0, 0.001), 0.0),
	(features(~1.0, 0.5), 1.0)
];

(* Train the decision tree. crossValidationTrain should be used when there's
   more data, as it'll separate the data set into test/train sets and use
   pruning to avoid overfitting. *)
val dt = C.train conditions;

print ("Is water solid at -2 degrees, 1.1 atm? ");
print (Real.toString(DecisionTreeReal.forward (dt, (features (~2.0, 1.1)))));
print "\n";

print ("Is water solid at 3 degrees, 1.0 atm? ");
print (Real.toString(DecisionTreeReal.forward (dt, (features (3.0, 1.0)))));
print "\n";
```

## Interface

The interfaces to the classification and regression trees training and pruning
libraries are the same, except that one uses integer labels and one uses
real-valued labels.

### Types
- `structure DT : DECISION_TREE`
  - The CART libraries are parameterized by decision trees, which provide the
    label and feature types used. See the [decision tree documentation](./dt.md)
    for information on those types.

### Methods

- `val train: (DT.features * DT.label) list -> DT.t`
- `val prune: DT.t * (DT.features * DT.label) list -> (real * DT.t) list`
- `val crossValidationTrain: (DT.features * DT.label) list -> DT.t`
- `val error: DT.t * (DT.features * DT.label) list -> real`

## Method Overview

- `train data`.
  - Trains a decision tree on the given data. This does not performe pruning.
- `prune (dt, data)`
  - Prunes a tree, returning a family of trees and their alpha-values.
- `crossValidationTrain data`
  - Finds the best pruned true by using cross validation training. 70% data will
    be used in training, the rest of data will be use to test.
- `error (dt, data)`
  - Returns the error rate of a decision tree on the input data.
