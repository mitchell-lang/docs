---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Random Walks (Weisfeiler-Lehman)

This library provides an implementation of the
[Weisfeiler-Lehman Graph Kernel](http://www.jmlr.org/papers/volume12/shervashidze11a/shervashidze11a.pdf)
based on [graph2vec](https://arxiv.org/pdf/1707.05005.pdf).

## Interface

To use this library, prefix the types and functions below with `WlKernel.`.

### Methods

- `val wlGraph: ((int * int) * (int list)) list list * int -> word list list`

## Method Overview

- `wlGraph (graph, depth)`
  - Random walk to embed graphs. The first argument is a collection of graphs,
    each graph is represented a list, each line in list includes the index of
    node in the graph, the information bound, and a list of int represents its
    neighbors' indices. The second argument is the depth of walking. The result
    is a list of embedding of input graphs. Each graph is embedded as a list of
    word (See [graph2vec](https://arxiv.org/pdf/1707.05005.pdf) for details).
