---
parent: Mitchell Libraries
---
# Representing Graph Clusters (Communities)

A data structure used in louvain algorithm, which is basically a int hashset.

##### Dependencies

hashset.

##### Methods

- Community. Community has type `Community.t`.
    + `t make(int size)`. Init a Community with size.
    + `int numSet(t commu)`. Return the number of sets in Community.
    + `unit normalize(t commu)`. Rename the set id, from `0`.
    + `int whichSet(t commu, int id)`. Return the set which includes that element id.
    + `bool sameSet(t commu, int id1, int id2)`. Return if two elements are in the same set.
    + `bool merge(t commu, ((int * int) list) l)`.  Merge sets by a list of element pair. If the sets is changed, return true; else return false.
    + `bool equal(t commu1, t commu2)`. Compare two communities.
    + `(int list) getSetMember(t commu, int id)`. Return all elements in the same set with input element.

