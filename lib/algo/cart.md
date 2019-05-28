---
parent: Mitchell Libraries
---
# Classification and Regression Trees (CART)

Decision tree training algorithm: CART.

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

##### Dependencies

dt.

##### Methods

- Cart(for discrete situation, using DecisionTree) and CartReal(for continuous situation, using DecisionTreeReal). Cart can train and prune a decision tree.
    + `DT.t  train(((DT.features, DT.label) list) data)`.
      - Train a decision tree, no pruning.
    + `((real, DT.t) list)  prune(DT.t dt, ((DT.features, DT.label) list) data)`.
      - Prune a tree, generate a collection of pruned trees. Each tree has a evaluation value: alpha(See CART papers for details). User can choose one of these tree as pruned result.
    + `DT.t  crossValidationTrain(((DT.features, DT.label) list) data)`.
      - Use cross validation training to find the best pruned tree. `70%` data will be used in training, the rest of data will be use to test.
    + `real  error(DT.t dt, ((DT.features * DT.label) list) data)`.
      - Return the error of a decision tree on the input data.
