#### mltree

A tree module, supporting multi-ary trees.

##### Dependencies

None.

##### Methods

- Mltree. Tree has type `A Mltree.tree`, where `A` is the type of the nodes in tree.
    + `string toString((A -> string) f,  (A tree) tree)`. Convert a tree to a string.
    + `(B tree) compre((A -> B) f, (A tree) tree)`. Comprehension. map a tree to another in parallel. The second argument how to compre two polymorphic elements.
    + `(A tree) makeLf(A a)`. Build a tree with a single leaf.
    + `(A tree) makeNd(A a, ((A tree) list) l)`. Build a tree from an element and a list of subtrees.
    + `A root((A tree) tree)`. Return the root of tree.
    + `int num((A tree) tree)`. Return the number of elements in the tree(the sum of the tree's nodes and leaves)
