# Random Walks (Weisfeiler-Lehman)
wlKernel

Random walk kernel.

##### Dependencies

NONE

##### Methods

- WlKernel.
    + `(word list list) wlGraph((((int, int), (int list)) list list) graph, int depth)`. Random walk to embed graphs. The first argument is a collection of graphs, each graph is represented a list, each line in list includes the index of node in the graph, the information bound, and a list of int represents its neighbors' indices. The second argument is the depth of walking. The result is a list of embedding of input graphs. Each graph is embedded as a list of word(See graph2vec papers for details).
