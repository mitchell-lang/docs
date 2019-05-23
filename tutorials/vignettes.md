---
title: Mitchell Programming Exercises
parent: Mitchell Tutorials
---
# Mitchell Tutorial: Vignettes
{:.no_toc}

The previous tutorial introduced you to the basic syntax and data
structures found in Mitchell.  In this tutorial, we'll use these
elements to write programs.  We've chosen three representative
examples to highlight core Mitchell functionality that you're likely
to find useful when developing your solutions.  

1. Generated Toc
{:toc}

## Travelling Salesman
### Background

The travelling salesman problem (TSP) is a well-known algorithm that is
applied to many different kinds of scheduling problems.  Abstractly,
the problem is easily stated: given a list of cities and the distances
between each pair of cities, what is the shortest possible route that
visits each city and returns to the origin city?

The pseudo-code for TSP is as follows:

```
Init {
adjMat := distance Adjacancy marix.
nodes := a set of all nodes.
start := the start node.
}

permu := permute (nodes\{start})
minDistance := 999999
minPath := []
forach path in permu:
    distanceSum = CalDisSum path
    if distanceSum < minDistance
        then minDistance := distanceSum
        else minPath := path
return (minDistance, minPath)
```

Here, we represent the set of cities and their distances in an
adjacency matrix, an *nxn* matrix (where *n* is the number of cities),
where each entry in the matrix represents the distance between a pair
of cities.  A naive implementation of TSP considers all permutations
of routes that includes all cities.  Having computed this permutation,
we iterate over each path in the permutation, calculating the total
distance of the path, keeping the smallest one seen.  The procedure
returns the shortest route and its distance after all paths have been
explored.  

### Mitchell Solution

Central to our solution is the need to enumerate all permutations of
routes.  To do this, we'll need a permutation function that takes the
list of cities that we want to visit and generates a list of paths,
where each path is represented as a list of cities.

```sml
fun insert elem l =
    case l of
        [] => [[elem]]
      | head :: rest =>
        let
            val restResult = insert elem rest 
            val result =
                List.map (fn r => head :: r) restResult 
        in
            (elem :: head :: rest) :: result
        end

fun permute l =
    case l of
        [] => [[]]
      | head :: rest =>
        let
            val restResult = permute rest 
            val result =
                List.foldl (fn (list, r) =>
                               (insert head list) @ r 
                           ) [] restResult
        in
            result
        end;

```

We generate permutations using two functions.  The first, ``insert``
given an element ``elem`` and a list ``l`` returns a list of lists, where
each list component reflects the insertion of `elem` in a different
position in `l`.  Intuitively, for a list containing *k* elements,
there are *k+1* ways to insert a new element into the list - at
the beginning of the list, at the end, and in-between each of the
*k* elements.

Thus, evaluating `insert 3 [1,2,4]` yields

```sml
[[3,1,2,4],[1,3,2,4],[1,2,3,4],[1,2,4,3]] 
```

To see how this function works, observe that we first deconstruct the
list into its two possible shapes.  The first shape is the empty list.
Here, the result is a list containing a single result, namely the list
containing the element being inserted.  If the list is non-empty, it
must have two components, a head and a tail (written `rest` in the
function).  A useful idiom when programming in declarative languages
like Mitchell is to use recursion to build intermediate state.  Here,
the expression `result = insert elem rest` recursively invokes
`insert` to generate all lists in which `elem` is inserted into `l`'s
tail.  In other words, if `l` is the list `[1,2,3,4]`, and `elem` is
`5`, then `rest` is the list `[2,3,4]`, and `insert elem rest` is thus
`[[5,2,3,4], [2,5,3,4], [2,3,5,4], [2,3,4,5]]`.

We can now consider all ways to insert the head of the list into this
intermediate list by using the `List.map` function.  This function is
known as a *higher-order* function because its first argument is
itself a function.  The `map` function applies its function argument
to every element in its second argument, which is expected to be a
list.  Thus, in this program, the expression `List.map (fn r => head
:: r) restResult` inserts `head` to every list component found in
`restResult`.  Since `head` is the number 1, and `restResult` is
`[[5,2,3,4], [2,5,3,4], [2,3,5,4], [2,3,4,5]]`, then `List.map (fn r
=> head :: r) restResult` yields
`[[1,5,2,3,4],[1,2,5,3,4],[1,2,3,5,4],[1,2,3,4,5]]`.  Adding
`[5,1,2,3,4]` to this list, yields the desired result, namely a list
of lists in which `elem` (the number 5) is injected into every
position of the original list.

The `permute` function uses `insert` to permute a list, i.e., generate
all unique combinations of list entries.  As before, we destructure a
list into two distinct shapes (empty and non-empty).  There is only
one permutation an empty list, namely the empty list.  When the list
is non-empty, containing a `head` element and a tail (represented by
`rest`), we apply the same idiom used in `insert` to generate all
permutations of sublists of `l`.  Having generated this permutation,
we now need to take care of handling the `head` element.  We do so by
using the `insert` function to insert the `head` in all positions of
every list found in `restResult`.  This function uses an important
auxiliary function called `foldl`.  In Mitchell, `List.foldl` is used
to iterate over a list, allowing intermediate results produced in one
iteration to be used in the next one.  For example, evaluating
`List.foldl (fn (x,acc) => x + acc) 0 [1,2,3]` is tantamount to
evaluating `3 + 2 + (1 + 0)`.  The accumulator `acc` is initially 0;
in its first (internal) iteration, the first element of the list (`1`)
is added to acc, and the result (`1`) becomes the value of the
accumulator for the next iteration, and so on.  This declarative way
of expressing iterative computation is very powerful, and as you'll
see when developing your own workloads leads to simpler and cleaner
computation.  In this example, the `head` element in list `l` is
inserted into every distinct position of every list component of
`restResult`.  The `foldl` operator accumulates all these variations.
The body of the argument function `(insert head list) @ r` appends the
result of `insert` (which is a list of lists) to `r` (which is also a
list of lists).

So, evaluating `permute [1,2,3]` yields `[[1,3,2],[3,1,2],[3,2,1],[1,2,3],[2,1,3],[2,3,1]]`.

Now that we know how to build permutations of lists, we're ready to
move on to directly solving TSP.  As we mentioned earlier, we'll represent
our input as an adjacency matrix, where row and column entries denote
distances between cities.  We might store this information in a file
(say "data.txt") that stores the adjacency matrix thus: 

```
    (* Data Format: *) 
    4   (* number of cities *)
    (* distance matrix *)
    0 2 9 10 
    1 0 6 4
    15 7 0 8
    6 3 12 0
    (* origin node *)
    0 
```

To compute TSP, we need to calculate the distance of a path.  We use
a pair of functions for that purpose:

```sml
val (distanceAdjMatrix, start) = readDistanceAdjMatrix "data.txt"

fun getDistance i j = Array.sub (Array.sub (distanceAdjMatrix, i), j)
fun pathDistance path =
    case path of
         [] => raise Fail "Bad Path" (* path has at least two nodes. *)
       | [e] => raise Fail "Bad Path" (* path has at least two nodes. *)
       | start :: rest =>
          let val (_, sum) =
               List.foldl (fn (next, (cur, sum)) => (next, (getDistance cur next) + sum))
                           (start, 0)
			   rest
            in
                sum
            end
```

The `getDistance` function simply returns the entry stored in the
distance matrix that holds the distance between a pair of cities (`i`
and `j`).  Now, given a path (i.e., a list of cities), the function
`pathDistance` returns the total distance.  It uses `List.foldl` to
calculate the sum of the distances between each of the elements in
input path.  In the expression, the accumulator initially holds the
first element in the path, with the path sum initialized to 0.  In
each iteration, the distance between the current node in the path
being examined (`cur`) and the next node in the path (generated by
iterating over `rest`) is computed.

The main body of the function can now be expressed:

```sml
let
    val (distanceAdjMatrix, start) = readDistanceAdjMatrix "data.txt"
    val nodes = Array.foldli (fn (i, _, r) => i :: r) [] distanceAdjMatrix 
    val nodesWithoutStart = List.filter (fn e => not (e = start)) nodes 
    val permu = permute nodesWithoutStart 
    val paths = List.map (fn path => start :: path @ [start]) permu 
    val pathAndDistance = List.map (fn path => (pathDistance path, path)) paths 
    val minOne = List.foldl
                     (fn ((distanceSum, path), r) => 
                        case r of
                            NONE => SOME (distanceSum, path) 
                          | SOME (minSum, _) =>
                            if distanceSum < minSum 
                            then
                                SOME (distanceSum, path)
                            else
                                r
                     ) NONE pathAndDistance
    val _ =
        case minOne of
            NONE => raise Fail "Bad Path"
          | SOME (sum, path) => print ((pathToString path) ^ ": " ^ (Int.toString sum) ^ "\n")
in
    ()
end;
```

We first read the contents of the distance adjacency matrix.  This
matrix is represented as a 1-dimensional array of 1-dimensional
arrays.  You can find the code to read the matrix in `io.sml`.  We
then use the `Array.foldli` function to collect the list of nodes.
The function argument to `Array.foldli` takes three arguments - an
index into the outer array, the value at that index (which is another
array, but ignored here - hence, the use of `_`), and the value of the
accumulator.  We bind the permutation of the list of all nodes other
than the start nodes to `permu`, and the list of all paths with the
start node as both the first and last node to `paths`.  We then
compute path distances of all these paths, binding these distances and
paths to `pathandDistance`.  We then iterate over all these paths,
recording the smallest distance, printing this path as the output of
the program.

Try putting the various pieces of this program into a single file and
experiment with changing the contents of ``data.txt``.  


