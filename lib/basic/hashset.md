---
grand_parent: Mitchell Libraries
parent: Basic Libraries
---
# Hash Sets

Hashset.

##### Dependencies

hashtbl.

##### Methods

- Hashset. hashset has type `A Hashset.t`, where `A` is the element of the set.
    + `(A t) make((A, A) -> bool) comp, int size)`. Make a hashset. The first describes how to compare two elements.
    + `int numSet((A t) hs)`. Return the number of sets in a hashset.
    + `int numElement((A t) hs)`. Return the number of elements in a hashset.
    + `unit normalize((A t) hs)`. Rename the set id, from `0`.
    + `int whichSet((A t) hs, A a)`. Find which set the element `a` is belonged.
    + `bool sameSet((A t) hs, A a, A a)`. Return if two elements are in the same set.
    + `unit insert((A t) hs, A a)`. Insert a element to a new set.
    + `bool merge((A t) hs, ((A, A) list) l)`. Merge sets by a list of element pair. If the sets is changed, return true; else return false.
    + `bool equal((A t) hs1, (A t) hs2)`. Compare two hashsets.
    + `(A list) getSetMember((A t) hs, A a)`. Return all elements in the same set with input element.
    + `unit add((A t) hs, A a)`. Add a element even if it already inserted.
    + `unit toString((A -> string) f, (A t) hs)`. Convert a hashset to string, the first argument describes how to convert a polymorphic element to string.
    + `B fold(((B, A) -> B) f, B default, (A t) hs)`. Fold over all elements.
    + `(B t) compre((A -> B) f, ((B, B) -> bool) comp, (A t) hs)`. Map over all elements. the second argument describes how to compare two elements.
