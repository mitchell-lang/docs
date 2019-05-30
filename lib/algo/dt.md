---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Decision Trees

This library provides support for creating and applying decision trees.
For an example of how to use this library, see the
[Gradient Boosted Decision Trees tutorial](../../tutorials/tutorial-gbdt.md).

## Interface

This library includes support both for decision trees with integer features and
labels (`DecisionTree`) and for decision trees with real-valued features and
labels (`DecisionTreeReal`).

### Types

- `type label`
  - Labels (the decisions that a decision tree makes) are either `int` or `real`.
- `type feature`
  - Individual features are either `int * int` or `int * real`, where the left
    hand side is the feature ID and the right hand side is the feature value.
- `type features`
  - Feature vectors are either an `int array` or `real array`, where the index into the
    array is the feature ID.
- `type t`
  - `DecisionTree.t` and `DecisionTreeReal.t` are the types of the decision
    trees themselves.

### Methods

- `val lessFeature: features * (int * label) -> bool`
- `val forward: t * features -> label`
- `val makeLf: label -> t`
- `val makeNd: t * feature * t -> t`
- `val toString: t -> string`
- `val split: (features * label) list * (int * label) -> ((features * label) list) * ((features * label) list)`
- `val recordsToString: (features * label) list -> string`
- `val leafNum: t -> int`

## Method Overview

- `lessFeature (ft, (featureId, featureValue))`
  - Determine whether the value of the given feature is less than the feature
    value in the feature vector `ft`.
- `forward (dt, ft)`
  - Run the decision tree `dt` to produce a label for the feature vector `ft`.
- `makeLf label`
  - Creates a decision tree that is just a leaf node that always returns the
    same label `label`.
- `makeNd (dt1, feature, dt2)`
  - Creates a decision tree that uses the left tree to get a label if feature
    vector being processed is less than `feature` and uses the right tree otherwise.
- `toString dt`
  - Converts a decision tree to a string.
- `split (data, (featureId, featureValue))`
  - Splits a list of input data by a feature. The input data is a
    collection of feature vectors and labels.
- `recordsToString data`
  - Converts a list of feature vectors and their labels to a string.
- `leafNum dt`
  - Returns the number of leaves in a decision tree.
