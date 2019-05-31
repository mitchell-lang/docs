---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Gradient Boosted Decision Trees (GBDT)

This library provides support for gradient boosted decision trees.

## Basic Usage

For an example of how to use this library, see the
[Gradient Boosted Decision Trees tutorial](../../tutorials/tutorial-gbdt.md).

## Interface

To create an instance of the GBDT module, use

```sml
structure C = CartReal(structure D = DecisionTreeReal)
structure Gbdt = Gbdt(structure CART = C)
```

and then prefix the types and functions below with `Gbdt.`.

### Types
- `structure DT : DECISION_TREE`
- `structure CART : CART_REAL`
  - The GBDT libraries are parameterized by the decision trees and CART
    libraries, which provide the label and feature types used. See the
    [decision tree](./dt.md) and [CART](./cart.md) documentation for information
    on those types.
- `type t`
  - The type of an ensemble of decision trees.

### Methods

- `val forward: t * DT.features -> DT.label`
- `val error: t * (DT.features * DT.label) list -> real`
- `val train: (DT.features * DT.label) list * real * int -> t`
- `val toString: t -> string`

## Method Overview

- `forward (gbdt, ft)`
  - Uses the ensemble `gbdt` to predict the label for the feature vector `ft`.
- `error (gbdt, data)`
  - Returns the error of the ensemble `gbdt` on the labeled data.
- ` train (data, learningRate, numEpochs)`
  - Trains ensemble of decision trees on the given data, using the learning
    rate, for the given number of epochs.
- `toString gbdt`
  - Converts an ensemble to a string.
