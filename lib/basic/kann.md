---
parent: Mitchell Libraries
---
# Neural Networks

Mitchell provides an API similar to the
[KANN library](https://github.com/attractivechaos/kann/blob/master/doc/01user.md)
for neural networks.
When running on x86, the KANN library is used as the underlying implementation.
Not all features of the library (e.g., recurrent neural networks) are available
at this time.

## Basic Usage

This example trains a single-hidden-layer network to evaluate `xor`.

| `A` | `B` | `A xor B` |
|:---:|:---:|:---------:|
|   0 |   0 |         0 |
|   0 |   1 |         1 |
|   1 |   0 |         1 |
|   l |   1 |         0 |

This network only uses a dense layer (`layerDense`) and the RELU activation
function (`relu`), but other kinds of layers and activation functions are
available below.

```sml
(* The definition of the network itself *)
fun create_xor_network (n_in, n_out, loss_type, n_h_neurons) =
let
  val t = Kann.layerInput n_in
  val t = Kann.layerDense (t, n_h_neurons)
  val t = Kann.relu t
  val t = Kann.layerCost (t, n_out, loss_type)
in
  Kann.new t
end

(* How to train a network *)
fun train (ann, input, output) =
let
  val learning_rate = 0.01      (* The learning rate *)
  val mini_size = 1             (* The batch size *)
  val max_epoch = 200           (* The number of epocs to train for *)
  val max_drop_streak = 10      (* The maximum dropout streak, to prevent overtraining *)
  val frac_val = 0.1            (* The fraction of the data used for validation *)
in
  Kann.trainFnn1 (ann, learning_rate, mini_size, max_epoch, max_drop_streak, frac_val, Array.length input, input, output)
end

(* Import the module for printing arrays of 32 bit reals (floats) *)
structure T = ArrayToString(struct type t = Real32.real; val toString = Real32.toString end)

(* Apply the network to the test data and accumulate the output, along with the
   input that resulted in the output
 *)
fun test (ann, inputs) =
    let
      fun test1 (input, outputs) = (input, Kann.apply1 (ann, input)) :: outputs
    in
      Array.foldr test1 [] inputs
    end

(* Print the input/output pair *)
fun printResult (input, output) =
    print (T.toString input ^ " = " ^ T.toString output ^ "\n")

(* Put it all together *)
fun train_and_test_xor () =
let
  (* Create the training data. Use Array.fromList to convert list literals to
     arrays.
   *)
  fun listsToArrays data = Array.fromList (map Array.fromList data)
  val input  = listsToArrays [[0.0,0.0],[0.0,1.0],[1.0,0.0],[1.0,1.0]]
  val expectedOutput = listsToArrays [[0.0],[1.0],[1.0],[0.0]]

  val ann = create_xor_network (2, 1, Kann.cCeb, 5)
  val status = train (ann, input, expectedOutput)
  val _ = print (Int.toString status ^ "\n")
  val results = test (ann, input)
  val _ = List.app printResult results
in
  ()
end

(* Run the program *)
val _ = train_and_test_xor ()
```

This results in the (abbreviated) output:

```
...
epoch: 199; training cost: 0.0229665 (class error: 0.00%)
epoch: 200; training cost: 0.0225713 (class error: 0.00%)
200
Array.fromList [0,0] = 0.0835272073746
Array.fromList [0,1] = 0.999737679958
Array.fromList [1,0] = 0.999255955219
Array.fromList [1,1] = 4.66978002805E~4
```

## Interface

### Types

This module defines the following types:

- `type kadnodetp`
  - The type of neural network that is being constructed. This is the type of
    value that can have additional layers added to it.
- `type kanntp`
  - The type of a neural network that has been fully constructed. This is the
    type of value that can be trained or run on data.

To convert between build a `kanntp` value from a `kadnodetp` value use `Kann.new`,
described below.

-
    ```
    datatype kannc =
          cCeb (* binary cross-entropy cost, used with sigmoid *)
        | cCem (* multi-class cross-entropy cost, used with softmax *)
        | cCebNeg (* binary cross-enytopy-like cost, used with tanh *)
        | cMse (* mean square error *)
    ```

  - This enumeration defines different cost functions that can be used for
    validation during training.

### Layers

- `val layerInput : int -> kadnodetp`
- `val layerInput2 : (int * int) -> kadnodetp`
- `val layerInput3 : (int * int * int) -> kadnodetp`
- `val layerDense : kadnodetp * int -> kadnodetp`
- `val layerCost : kadnodetp * int * kannc -> kadnodetp`
- `val layerDropout : kadnodetp * float -> kadnodetp`
- `val layerConv1d : kadnodetp * int * int * int * int -> kadnodetp`
- `val layerConv2d : kadnodetp * int * int * int * int * int * int * int -> kadnodetp`
- `val max1d : kadnodetp * int * int * int -> kadnodetp`
- `val max2d : kadnodetp * int * int * int * int * int * int -> kadnodetp`

### Activation Functions

- `val sigm : kadnodetp -> kadnodetp`
- `val tanh : kadnodetp -> kadnodetp`
- `val relu : kadnodetp -> kadnodetp`
- `val softmax : kadnodetp -> kadnodetp`

### Training and Running the Network

- `val new : kadnodetp -> kanntp`
- `val trainFnn1 : kanntp * float * int * int * int * float * int * float array array * float array array -> int`
- `val apply1 : kanntp * float array -> float array`
- `val dimOut : kanntp -> int`
- `val delete : kanntp -> unit`

## Method Overview

### Layers

- `layerInput size `
  - Creates an input layer.
- `layerInput2 (size1, size2) `
  - Creates a 2-dimensional input layer.
- `layerInput3 (size1, size2, size3) `
  - Creates a 3-dimensional input layer. For example, to create an input layer
    for the [MNIST dataset](https://en.wikipedia.org/wiki/MNIST_database), one
    would write
    ```sml
    val mnistInputLayer = layerInput3 (1, 28, 28)
    ```
    to create an input layer accepted one channel, a height of 28 pixels, and a
    width of 28 pixels.

    No matter the dimension, data should be arranged in to an array of arrays,
    where each inner array is one input to the neural network. The inner array
    should be arranged in order of dimension. <!-- TODO explain this better. -->
- `layerDense (input, size)`
  - Adds a fully-connected layer to a neural network definition.
- `layerCost (input, size, costFunction)`
  - Adds a cost layer to a neural network definition.
- `layerDropout (input, rate)`
  - Adds a dropout layer to a neural network definition.
- `layerConv1d (input, numFilters, size, stride, padding)`
  - Adds a 1-dimensional convolution layer to a neural network definition.
- `layerConv2d (input, numFilters, numRows, numCols, strideRows, strideCols, padRows, padCols)`
  - Adds a 2-dimensional convolution layer to a neural network definition.
- `max1d (input, kernelSize, stride, leftPad)`
  - Adds a 1-dimensional max pool layer to a neural network definition. The
    `kernelSize` is the spatial extent of the kernel.
- `max2d (input, kernelRowSize, kernelColSize, strideRows, strideCols, padTop, padLeft)`
  - Adds a 2-dimensional max pool layer to a neural network definition.

### Activation Functions

- `sigm input`
  - Adds a [sigmoid](https://en.wikipedia.org/wiki/Sigmoid_function) activation
    function to a neural network definition.
- `tanh input`
  - Adds a tanh activation function to a neural network definition.
- `relu input`
  - Adds a [ReLU](https://en.wikipedia.org/wiki/Rectifier_(neural_networks))
    activation function to a neural network definition.
- `softmax input`
  - Adds a [softmax](https://en.wikipedia.org/wiki/Softmax_function) activation
    function to a neural network definition.

### Training and Running the Network

- `new layers`
  - Construct the network from the definition of the layers
- `trainFnn1 (network, learningRate, batchSize, numEpochs, maxDropStreak, validationFraction, dataSize, input, expectedOutput)`
  - Train the neural network. The network is as constructed by `new`. The other
    parameters are standard. The data size should be equal to `Array.length input`,
    unless you want to use less data than is available in the array for training.
  - Returns the trained neural network.
- `apply1 (network, input)`
  - Apply a trained network to the input and returns the result vector.
- `dimOut network`
  - Gets the size of the output dimension of a neural network.
- `delete network`
  - Explicitly frees a neural network. This is not necessary unless you are
    generating many networks in your program.
