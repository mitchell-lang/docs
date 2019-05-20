---
has_children: true
permalink: /lib/
has_toc: false
---
# Mitchell Libraries

## Using Libraries

Mitchell uses the Standard ML module system. You can read about how to use
modules provided by libraries [here](faq/modules.md).

## The Standard Basis Library

Mitchell includes most of the Standard Basis Library for Standard ML.
Documentation for the Standard Basis Library can be found
[here](http://sml-family.org/Basis/). Documentation for the individual modules
from the library can be found [here](http://sml-family.org/Basis/manpages.html)

The Standard Basis Library includes several modules for interacting with the
operating system or for performing IO. We have provided that functionality here
to assist you with inputting data into your program, with outputting results
from your program, and with debugging. However, IO is not supported on the
hardware accelerator where your implementation will eventually run. We ask that
you keep any IO that you need to do separate from the rest of your algorithm.

The following modules from the Standard Basis Library may be particularly useful
to you:

- [Lists](http://sml-family.org/Basis/list.html)
- [Fixed-Size Mutable Arrays](http://sml-family.org/Basis/array.html)
- [Fixed-Size Mutable 2D Arrays](http://sml-family.org/Basis/array2.html)
- [Fixed-Size Immutable Vectors](http://sml-family.org/Basis/vector.html)
- [Strings](http://sml-family.org/Basis/string.html) and
  [Substrings](http://sml-family.org/Basis/substring.html)
  - See the [IO and parsing tutorial](tutorials/tutorial-io-parsing.md) for
    examples of use.
- [Math](http://sml-family.org/Basis/math.html)
- [Integer](http://sml-family.org/Basis/integer.html),
  [Word](http://sml-family.org/Basis/word.html), and
  [Real](http://sml-family.org/Basis/real.html)
- [Text IO](http://sml-family.org/Basis/text-io.html)
  - See the [IO and parsing tutorial](tutorials/tutorial-io-parsing.md) for
    examples of use.

## Data Structures and Utilities

The following data structures and utilities are provided by Mitchell.

- [Hash Tables (Dictionaries)](./lib/basic/hashtable.md)
- [Hash Sets](./lib/basic/hashset.md)
- [Graphs](./lib/basic/mlgraph.md)
- [Vectors](./lib/basic/mlvector.md)
- [Matrices](./lib/basic/mlmatrix.md)
- [Resizable Arrays](./lib/basic/mlarray.md)
- [Heaps](./lib/basic/mlheap.md)
- [Random Number Generation](./lib/basic/mlrandom.md)
- [Trees](./lib/basic/mltree.md)
- [Sorting Lists and Arrays](./lib/basic/sort.md)
- [Math](./lib/basic/math.md)
  - This module includes additional convenience functions not provided by the
    Standard Basis Library math module.

## Algorithms

- [Nonlinear Activation Functions](./lib/algo/nonlinear.md)
- [Decision Trees](./lib/algo/dt.md)
- [Classification and Regression Trees (CART)](./lib/algo/cart.md)
- [Gradient Boosted Decision Trees (GBDT)](./lib/algo/gbdt.md)
- [Random Walks (Weisfeiler-Lehman)](./lib/algo/wlkernel.md)
- [Negative Sampling](./lib/algo/negsample.md)
- [Skip Gram](./lib/algo/skipgram.md)
- [Recurrent Neural Networks (RNNs)](./lib/algo/rnn.md)
- [Representing Graph Clusters (Communities)](./lib/algo/communities.md)
- [Graph Clustering (Louvain)](./lib/algo/louvain.md)
- [Shortest Path (Dijkstra)](./lib/algo/shortest-path.md)
- [Hierarchical Hub Labeling (HHL)](./lib/algo/hhl.md)
