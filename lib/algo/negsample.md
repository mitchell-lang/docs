---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Negative Sampling

This library provides support for negative sampling.

## Interface

To use this library, prefix the types and functions below with `Negsample.`.

### Types

- `type t`
  - The representation of the statistics computed for a document.

### Methods

- `val dict : int array array * int -> t`
- `val sampleContext : t * int -> (int * (int list))`
- `val negSample : t * int * int -> (int list)`
- `val vocabSize : t -> int`

## Method Overview

- `t dict((int array array) data, int vocabSize).`
  - Computes statistics on vocabulary frequency. Words as represented as
    integers, from `0` to `vocabSize - 1`. The input data is treated as an array
    of paragraphs, where a paragraph is a array of words.
- `sampleContext (ns, numContext)`
 - Samples the context of a word. Randomly chooses a word (weighted by its
   frequency), and returns its context (the words appear immediately before and
   after it).
- `negSample (ns, pid, numNeg)`
  - Samples the words not in a specific paragraph, where the paragraph is given
    by the ID `pid`.
- `vocabSize ns`
  - Returns the vocabulary size.
