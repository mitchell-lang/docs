#### mltree

A tree module, supports multi-ary tree.

##### Dependencies

None.

##### Methods

- Mltree. Tree has type `A Mltree.tree`, where `A` is the type of the nodes in tree.
    + `string toString((A -> string) f,  (A tree) tree)`. Convert a string to String, the first argument describes how to convert the polymorphic element to string.
    + `(B tree) compre((A -> B) f, (A tree) tree)`. Comprehension. map a tree to another in parallel. The second argument how to compre two polymorphic elements.
    + `(A tree) makeLf(A a)`. Build a tree with one single leaf.
    + `(A tree) makeNd(A a, ((A tree) list) l)`. Build a tree from a element and some subtrees.
    + `A root((A tree) tree)`. Return the root of tree.
    + `int num((A tree) tree)`. Return how many elements in the tree(the number of nodes pluses the number of leaves).
