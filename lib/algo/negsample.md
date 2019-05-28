---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Negative Sampling

negative sampling.

##### Dependencies

NONE

##### Methods

- Negsample.
    + `t dict((int array array) data, int vocabSize).` Statistic the frequency of vocabularies. The vocabularies as represented as integers, from `0` to `vocabSize - 1`. The input data is treated as a list of paragraph, a paragraph is a list of words.
    + `(int, (int list)) sampleContext(t ns, int numContext)`. Sample the context of a word. Randomly choose a word(weighted by its frequency), return its context(the words appear front and ahead of it).
    + `(int list) negSample(t ns, int pid, int numNeg)`. Sample the words not in a specific paragraph(pid).
    + `int vocabSize(t ns)`. Return the number of vocabularies.
