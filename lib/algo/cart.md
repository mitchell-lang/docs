# Classification and Regression Trees (CART)

Decision tree training algorithm: CART.

##### Dependencies

dt.

##### Methods

- Cart(for discrete situation, using DecisionTree) and CartReal(for continuous situation, using DecisionTreeReal). Cart can train and prune a decision tree.
    + `DT.t  train(((DT.features, DT.label) list) data)`. Train a decision tree, no pruning.
    + `((real, DT.t) list)  prune(DT.t dt, ((DT.features, DT.label) list) data)`. Prune a tree, generate a collection of pruned trees. Each tree has a evaluation value: alpha(See CART papers for details). User can choose one of these tree as pruned result.
    + `DT.t  crossValidationTrain(((DT.features, DT.label) list) data)`. Use cross validation training to find the best pruned tree. `70%` data will be used in training, the rest of data will be use to test.
    + `real  error(DT.t dt, ((DT.features * DT.label) list) data)`. Return the error of a decision tree on the input data.
