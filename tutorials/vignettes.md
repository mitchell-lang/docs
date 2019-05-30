---
title: Mitchell Programming Exercises
parent: Mitchell Tutorials
---
# Mitchell Tutorial: Vignettes
{:.no_toc}

The previous tutorial introduced you to the basic syntax and data
structures found in Mitchell.  In this tutorial, we'll use these
elements to write useful programs.  We've chosen a few representative
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
distance of the path, keeping the smallest one seen thus far.  The
procedure returns the shortest route and its distance after all paths
have been explored.

### Mitchell Solution

Central to our solution is the need to enumerate all permutations of
routes.  To do this, we'll need a permutation function that takes the
list of cities that we want to visit and generates a list of paths,
where each path represents a list of cities.

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
list into its two possible shapes;  recall that the definition of a list
is defined by the following datatype definition that describes these
two shapes:

```sml
datatype 'a list = Nil | Cons of ('a * 'a list)
```

The first shape is the empty list.  Inserting an element into an empty
list results in a list containing a single result, namely the list
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
auxiliary function called `List.foldl`.  In Mitchell, `List.foldl` is
used to iterate over a list, allowing intermediate results produced in
one iteration to be available in the next one.  For example,
evaluating `List.foldl (fn (x,acc) => x + acc) 0 [1,2,3]` is
tantamount to evaluating `3 + 2 + (1 + 0)`.  The accumulator `acc` is
initially 0; in its first (internal) iteration, the first element of
the list (`1`) is added to acc, and the value of the resulting
computation (`1 + 0` which is `1`) becomes the value of the
accumulator for the next iteration, and so on.  This declarative way
of expressing iterative computation is very powerful, and as you'll
see when developing your own workloads leads to simpler and cleaner
computation because you don't have to explicitly manage the state that
gets manipulated from one iteration to the next the way you would need
to do using more imperative features like while- or for-loops.  For example,
we can express the behavior of `List.foldl` as used above in a more imperative style thus:

```
acc := 0;
for i = 0 to List.length l do
   acc := (List.nth i) + acc
return acc
```

For TSP, the `head` element in list `l` is inserted into every
distinct position of every list component of `restResult`.  The
`foldl` operator accumulates all these variations.  The body of the
argument function `(insert head list) @ r` appends the result of
`insert` (which is a list of lists) to `r` (which is also a list of
lists).  For example, evaluating `permute [1,2,3]` yields
`[[1,3,2],[3,1,2],[3,2,1],[1,2,3],[2,1,3],[2,3,1]]`.

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
val (distanceAdjMarix, start) = readDistanceAdjMarix "data.txt"

fun getDistance i j = Array.sub (Array.sub (distanceAdjMarix, i), j)
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

The `readDistanceAdjMatrix` function found in file
[tsp-io.sml](./tsp-io.sml) reads the data file and returns the
adjacency matrix (`distanceAdjMatrix`) and the origin city (`start`).
The matrix is represented as an array of arrays.  An array in Mitchell
is a contiguous collection of (updateable) elements that can be
accessed in constant time.

The `getDistance` function simply returns the entry stored in the
distance matrix that holds the distance between a pair of cities (`i`
and `j`).  The expression `Array.sub (distanceAdjMatrix, i)` returns
the array in the ith row, while `Array.sub (Array.sub
(distanceAdjMatrix, i), j` returns the jth element in this array.

Now, given a path (i.e., a list of cities), the function
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
    val (distanceAdjMarix, start) = readDistanceAdjMarix "data.txt"
    val nodes = Array.foldli (fn (i, _, r) => i :: r) [] distanceAdjMarix 
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

We first read the contents of the distance adjacency matrix as
described above.  We then use the `Array.foldli` function to collect
the list of nodes.  The function argument to `Array.foldli` takes
three arguments - an index into the outer array, the value at that
index (which is another array, but ignored here - hence, the use of
`_`), and the value of the accumulator.  The function argument to
`Array.foldli` simply accumulates the array index into a list, so the
value to bound to `nodes` is simply a list of numbers representing the
names of the cities.  We bind the permutation of the list of all nodes
other than the start nodes to `permu`, and the list of all paths with
the start node as both the first and last node to `paths`.  We then
compute path distances of all these paths, binding these distances and
paths to `pathandDistance`.  We then iterate over all these paths,
recording the smallest distance, printing this path as the output of
the program.

Try putting the various pieces of this program into a single file and
experiment with changing the contents of ``data.txt``.  Once you are
comfortable with what the program is doing, experiment with different
variations.  For example, change the program to return the path that
has the greatest distance (easy).  Or, have the program return the *k*
shortest routes for some input *k* (moderate).  If you are feeling
particularly adventurous, modify the program to find the shortest
route upto a fixed path length (harder).


## PageRank
### Background

The PageRank algorithm is used to rank the relative importance of a
set of web pages.  It was used as part of the early search algorithm
deployed by Google.  The intuition underlying the algorithm is quite
simple - the importance of a web page is a function of the number of
links to that page.  The more incomimg links, the more important the
page is.  Similarly, the a page's pagerank influences the importance of
the pages it links to.  The core algorithm thus iterates over a graph
(conveniently represented as an adjacency matrix), where nodes
represent pages, and edges represent links to (and from) these pages.

The pseudo-code for a simple implementation of PageRank is as follows:

```
Init {
adjMat := adjacancy matrix of input graph
nodes := nodes in the graph
N := num of nodes
pr := page rank weight vector, initialized to 1/N.
d := damp factor, typically is set to 0.85.
threshold := threshold for convergence. When the difference betweem new pr and old one less than threshold, return.
}

prLoop:
    pr' := pr
    foreach node in nodes:
        inFlow := 0.0
        foreach node' in nodes:
            if adjMat[node'][node] = true:
                inFlow = inFlow + d * (pr[node'] / (outDegree node'))
        pr'[node] = inFlow + (1 - d) / N
    if diff(pr, pr') < threshold:
        return pr'

```

The damping factor models the likelihood that a particular link to a
page will be traversed.  A high damping factor is used to indicate
that most links will be explored.

### Mitchell Solution

First, we will represent the web graph as an adjacency matrix:

```sml
fun connected adjMat (i, j) =
    Array.sub (Array.sub (adjMat, i), j)

fun outDegree adjMat i =
    Array.foldl (fn (b, num) =>
                    if b then num + 1 else num) 0 (Array.sub (adjMat, i))
```

The ``connected`` function selects the *(i,j)*th element - if the
entry is 1, it means there is a link connecting node *i* (which is
intended to represent a web page) to node *j*; a 0 indicates there is
no such link.  Row *i* in the adjaency matrix captures the set of
links from node *i*.  The ``Array.foldl`` function simply counts the
number of 1's in this row which thus represents the node's outdegree.

The heart of the pagerank algorithm is captured by the following three
functions:

```sml
fun calNewPr nodeidx adjMat pr d =
    let
        val inFlow =
            (ExtendedList.foldli ((fn (sum, nodeidx', prNodeidx') =>
                           if connected adjMat (nodeidx', nodeidx)
                           then
                               let
                                   val l = outDegree adjMat nodeidx'
                               in
                                   sum + prNodeidx'/(Real.fromInt l)
                               end
                           else
                               sum
                        ), 0.0, pr)) * d
        val N = List.length pr
        val dampFlow = (1.0 - d)/(Real.fromInt N)
    in
        dampFlow + inFlow
    end

fun prDiff pr1 pr2 =
    ExtendedList.foldli ((
        fn (sum, i, prValue1) =>
           let
               val prValue2 = List.nth (pr2, i)
           in
               (prValue2 - prValue1) * (prValue2 - prValue1) + sum
           end
    ), 0.0, pr1)

fun prLoop adjMat pr d threshold =
    let
        val pr' =
            ExtendedList.mapi
                ((fn (i, _) =>
                    calNewPr i adjMat pr d
                 ), pr)
    in
        if (prDiff pr pr') < threshold
        then
            pr'
        else
            prLoop adjMat pr' d threshold
    end;
```

The ``callNewPr`` function calculates a new pagerank for a node with
id ``nodeidx`` given a link structure captured by ``adjMatrix``, an
existing list of pageranks (``pr``) and a damping factor ``d``.
The value bound to ``inflow`` uses the ``foldli`` function found in
the ``ExtendedList`` library that is part of the Mitchell ecosystem.
``foldli`` is similar to ``List.foldl`` except that its function
argument operates over a list element, an accumulator, and an integer
value:

```sml
fun foldli (f, r, l) =
    let
        fun aux r l i =
            case l of [] => r
                    | h :: t =>
                      aux (f (r, i, h)) t (i+1)
    in
        aux r l 0
z    end
```

In the context of ``calNewPr``, the ``foldli`` operation iterates over
a list of pageranks (``pr``) whose length is expected to be equivalent
to the dimension of the adjacency matrix (``adjMat``).  In each
iteration, the next element in the list (i.e., the pagerank for node
*i*) is bound to ``prNodeidx'`` and ``nodeidx'`` is bound to an
integer representing a page whose outgoing links we are examining.  If
this page has a link to ``nodeidx`` (the argument to the function)
then we compute the outdegree of the node, and use it to calculate the
contribution of this node to the pagerank for ``nodeidex``.  This
contribution is further refined by taking the damping factor in
account.  The ``prDiff`` function calculates the difference between
two pagerank weight vectors while ``prLoop`` repeatedly iterates over
the graph until the differences between the pageranks calculated between
successive iterations falls below a given threshold.


The top-level driver reads the adjacency matrix from a file, sets up
the damping factor and threshold, and initiates the call to ``prLoop`` -
the pagerank vector returned by the call is printed as the result:

```sml
let
    val (nodesNum, adjMat) = fromFile "data.txt"
    val pr = List.tabulate (nodesNum, fn _ => 1.0 / (Real.fromInt nodesNum))
    val d = 0.85
    val threshold = 0.001
    val pr = p
    rLoop adjMat pr d threshold
    val _ = print ((prToString pr) ^ "\n")
in
    ()
end;
```

A sample ``data.txt`` file might look like:

```
5
0 1 1 0 0
0 0 0 1 0
0 0 0 1 1
0 0 0 0 1
1 0 0 0 0
```

The implementation of the reader that reads in a data file and builds the
adjacency matrix can be found in [pagerank-io.sml](./pagerank-io.sml).

Once you've understood how this simple pagerank implementation works,
you might consider implementing different
[variants](https://pdfs.semanticscholar.org/70f8/d27954ce7ef49e351aca6d4b6b368cfef1c7.pdf).
A more sophisticated set of algorithms is given
[here](http://www.w3c.ethz.ch/CDstore/www2002/poster/173.pdf).

## K-Means Clustering
### Background

The K-Means algorithm is a well-known unsupervised learning technique
to *cluster* a collection of data items.  The basic idea is to
associate every data item to a cluster (called a *centroid*).  If we
consider inputs to be points in some multi-dimensional space, then a
centroid *k* represents a point in that space such that all inputs
clustered with *k* are closer to *k* than any other centroid.  The
algorithm works by alternating between assigning input data points to
centroids and choosing new centroids based on the current assignment.
A simple algorithm for computing the inner loop of a k-means clusters implementation
can be expressed as follows:

```
Init {
data := a list of sample points.
centroids := a set of $k$ centroids, randomly generated.
}

kmeansLoop:
    Foreach centroid in centroids:
        set = []
        Foreach point in data:
            closestCentriod := None
            minDistance := 999999
            Foreach centroid' in centroids:
                d := calDistance point centroid'
                if d < minDistance:
                    minDistance := d
                    closestCentriod := centroid'
            if closestCentriod = centroid:
                set := set + [point]
        sumX = 0.0
        sumY = 0.0
        num = 0
        Foreach point in set:
            sumX = sumX + point.x
            sumY = sumY + point.y
            num = num + 1
        centroid := (sumX/num, sumX=Y/num)
```

The algorithm initially assigns centroids randomly.  It then iterates over
all data points, comparing the distance between the point and the collection
of centroids, assigning the point to the centroid that is closest to it.  Once
all points have been assigned to a centroid, we recalculate the centroid by
computing the average of all points associated with it.  We can repeat this
procedure for some fixed number of iterations or until no new assignments are
generated.  There are a number of resources that you can use to find more
details about this algorithm; one particularly accessible introduction can
be found [here](https://stanford.edu/~cpiech/cs221/handouts/kmeans.html).

### Mitchell Solution

For this vignette, we've omitted some parts of the implementation that
we'd like you to fill-in.  Once you're done, you can test your
solutions using the data file found [here](./kmeans-data.txt); this
file considers an input of 200 randomly- generated points dispersed in
a two-dimensional plane.  You can find the implementation of the
reader that reads a data file [here](./kmeans-io.sml).  Compare your
implementation to [ours](./kmeans-sol.sml), but please try to
avoid looking at our solution before you've written your own.

```sml
(* Calculate distance of two points. *)
fun distance ((x1, y1), (x2, y2)) : real=
    (* ... fill-in here ... *)

(* Generate *n* random centroids in given range. *)
fun centroidGen n (rangeX, rangeY) =
    let
        fun aux i =
            if i = n then [] else
            let
                val x = Mlrandom.uniformReal rangeX
                val y = Mlrandom.uniformReal rangeY
            in
                (x, y) :: (aux (i + 1))
            end
    in
        aux 0
    end

(* For a sample point in original data, calculate which centroid is closest. *)
(* You might find ExtendedList.foldli and the use of option types useful here *)
fun whichCentroid centroids point =
  (* ... fill-in here ... *)

(* Calculate new ith new centroid. *)
fun calCentroid centroids data ith =
   (* ... fill-in here ... *)

(* Training loop. *n* represents the number of iterations we want the algorithm to run for *)
fun kmeansLoop centroids data n =
    if n = 0 then centroids else
    let
        val centroids =
            ExtendedList.mapi (* For each centroid, update it to a new one. *)
                ((fn (i, _) => calCentroid centroids data i),
                 centroids)
    in
        kmeansLoop centroids data (n - 1)
    end;

let
    (* The data is a list of points (a pair of real number). *)
    val data = fromFile "data.txt" 
    (*
    Data Format: data.txt:
    200 ----------> how many points
    99.3556817478 102.316592324 ----------> a point
    101.866292917 98.475273676
    ...
    *)

    (* Generate two initial centroids randomly in range [0, 100] * [0, 100]. *)
    val centroids = centroidGen 2 ((0.00, 100.00), (0.00, 100.00))

    (* Train 3 times. *)
    val centroids = kmeansLoop centroids data 3
    
    val _ = print ("Centroids:\n" ^ (centroidsToString centroids)) (* Print the result. *)
in
    ()
end;
```

