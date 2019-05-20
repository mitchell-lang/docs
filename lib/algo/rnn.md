# Recurrent Neural Networks

Recurrent neural network.

##### Dependencies

mlvector, mlmatrix, nonlinear.

##### Methods

- Rnn. When create a rnn module, need indicate the `innode`, `hidenode` and `outnode`. See lstm example code for details. Rnn has type `rnn`. 
    + `run init(((int, int) -> real) f)`. Init rnn, the input argument will give all element in matrix a initial value by their indices.
    + `(matrix, (rnnrecord list)) forward(rnn rnn, mlmatrix data)`. Forward, input and output is both matrix, and rnn will also output a record for backward.
    + `unit backward(rnn rnn, (rnnrecord list) records, mlmatrix data, mlmatrix ans, real learningRate)`. Backward. The second argument is one of output of forward, the forth argument is the expected answers.
    + `unitd train(rnn rnn, ((mlmatrix, mlmatrix) list) data, real learningRate)`. Run forward and then backward. the second argument is input data and expected answers.
