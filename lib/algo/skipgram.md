# Skip Gram

This library provides support for skip-grammars.

## Interface

To create an instance of the HHL module, use

```sml

structure S = Skipgram(structure M = Mlmatrix(Mlvector);
                       structure N = Nonlinear)
```

and then prefix the types and functions below with `S.`.

### Types

- `type t`
- `type matrix`

### Methods

- `val make : matrix * matrix -> t`
- `val init : int * int * int -> t`
- `val train : t * input * real -> real`

## Method Overview

- `t make(mlmatrix embed, mlmatrix w)`
  - Make a Skipgram neural network by two matrices: embedding matrix and
    weighted output matrix.
- `t init(int paragraphNum, int vocabNum, int embedingLength) -> t`
  - Make a Skipgram neural network by the size of embedding matrix and weighted
    output matrix. Embedding matrix has size: `paragraphNum` x `embedingLength`,
    which means each paragraph is embedded to a vector with length
    `embedingLength`. Output matrix has size: `vocabNum` x `embedingLength`,
    which means for each given word, the skipgram will try to find the
    probability it appears in a paragraph.
- `real train(t sg, (int, (int list), (int list)) data, real learningRate)`
  - Forward and backward execution. The second argument is input data which is a
    tuple: first element is the sampling word, the second element is a list
    containing the words in its context (i.e., those that appear near it in
    document), the third element is a list containing negative samples, which
    are words that are not in its context. The return result is the error. The
    skipgram will updates itself after each forward step.
