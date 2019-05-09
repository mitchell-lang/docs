## Mitchell Libraries

### Basic Libraries

- utils
- sort
- hashtable
- unique
- mlrandom
- mlarray
- mlheap
- mltree
- mlvector
- mlmatrix
- mlgraph
- hashset
- binary

#### utils

Utils. Includes some syntax sugars, some functions used frequently and extensions of SML list and array module.

##### Dependencies

None.

##### Methods

- Syntax sugar.
  + `A return(A a)`. Just return the input argument. 
  + `(B list) foreach((A -> B) f, (A list) l)`. Just map a list`l` to another with respect to mapping function `f`.
- Functions used frequently.
  + `int intPow(int a, int b)`. Return `a^b`.
  + `real mlsq(real a)`. Return `a^2`.
  + `(A option) betterOpt(((A, A) -> bool) comp, (A option) opt1, (A option) opt2)`. Return the better one in two input arguments with respect to the comparing function `comp`. If one of them is `NONE`, choose another one.
- ExtendedList. A complement to the List module.
  + `(B list) mapi(((int, A) -> B) f, (A list) l)`. Like map, but the mapping function also takes the indices as input.
  + `B foldli(((B, int, A) -> B) f, B default, (A list) l)`. Like fold, but the recursion function also takes the indices as input.
  + `string toString((A -> string) f, (A list) l))`. Convert a list to a string, the first argument describes how to convert the polymorphic element to a string.
  + `(A option) bestOpt(((A, A) -> bool) comp, (A list) l)`. Find the best one in a list with respect to a comparing function. If the list is empty, return `NONE`.
  + `(A list) subtract(((A, A) -> bool) eq, (A list) l1, (A list) l2)`. Subtract l2 from l1. The first argument is equality function which describes when two polymorphic element are the same.
  + `A bestDefault(((A, A) -> bool) comp, A default, (A list) l)`. Like bestOpt, but return default value instead of `NONE`.
- ExtendedArray. A complement to the Array module.
  + `string toString((A -> string) f, (A array) arr)`. Convert a array to a string, the first argument describes how to convert the polymorphic element to a string.
  + `(A array) copy((A array) arr)`. Copy an array.
  + `(B array) map((A -> B) f, (A array) arr)`. Map an array to another with respect to the mapping function `f`.

#### sort

Sorting functions(quick sort for list and array).

##### Dependencies

None.

##### Methods

- `void quickSortArray(((A, A) -> bool) comp, (A array) arr)`. Sort an array using quick sort algorithm in place. The first argument describes how to compare two polymorphic elements.
- `(A list) quickSortList(((A, A) -> bool) comp, (A list) l)`. Sort a list using quick sort algorithm and return sorted list. The first argument describes how to compare two polymorphic elements.
- `(int list) quickSortListIncrease(((int, int) -> bool) comp, (int list) l)`. Sort int list with increasing order by quickSortList.

#### hashtable

A hashtable module from SML/NJ.

##### Dependencies

None.

##### Methods
- HashString. 
  + `val hashString: string -> word`. Hash a string to a word, which is a binary number, its length is depends on the architecture.
- HashTable. hashtable has type `(A, B) hash_table`, `A` is the type of the key, `B` is the type of value.
  + `((A,B) hash_table) mkTable((A -> word) hashf, ((A * A) -> bool) comp, int len)`. Given a hashing function(hash a object to a word, which is a binary number, its length is depends on the architecture) and an equality predicate, create a new table; the int is a size hint and the exception is to be raised by find. `MLton.hash` is a general hash function works for all objects, `HashString.hashString` also works for string.
  + `void clear(((A, B) hash_table) table)`. Remove all elements from the table. 
  + `void insert(((A, B) hash_table) table, (A key, B value))` Insert an item. If the key already has an item associated with it, then the old item is discarded.
  + `bool inDomain(((A, B) hash_table) table, A key)`. Return true, if the key is in the domain of the table.
  + `B lookup(((A, B) hash_table) table, A key)`. Find an item, the table's exception is raised if the item doesn't exist. 
  + `(B option) find(((A, B) hash_table) table, A key)`. Look for an item, return NONE if the item doesn't exist.
  + `B remove(((A, B) hash_table) table, A key)`. Remove an item, returning the item. The table's exception is raised if the item doesn't exist.
  + `int numItems(((A, B) hash_table) table)`. Return the number of items in the table.
  + `(B list) listItems(((A, B) hash_table) table)`. Return a list of the items in the table.
  + `((A, B) list)) listItemsi(((A, B) hash_table) table)`. Return a list of the items and their keys in the table.
  + `void app((B -> void) f, ((A, B) hash_table) table)`. Apply a function to the values of the table.
  + `void appi(((A, B) -> void) f, ((A, B) hash_table) table)`. Apply a function to the entries of the table 
  + `((A, C) hash_table) map((B -> C) f, ((A, B) hash_table) table)`. Map a table to a new table that has the same keys.
  + `((A, C) hash_table) mapi(((A, B) -> C) f, ((A, B) hash_table) table)`. Like map, but mapping function also takes keys as input.
  + `C fold(((B, C) -> C) f, C default, ((A, B) hash_table) table)`. Fold a function over the values of a table.
  + `C foldi(((A, B, C) -> C) f, C default, ((A, B) hash_table) table)`. Like fold, but recursion function also takes keys as input.
  + `void modify((B -> B) f, ((A, B) hash_table) table)`. Modify the hash-table items in place. Notice that the input type in modification function is the same as output type, which is different from mapping function.
  + `void modifyi(((A, B) -> B) f, ((A, B) hash_table) table)`. Like modify, but modification function also takes keys as input.
  + `void filter((B -> bool) f, ((A, B) hash_table) table)`. Remove any hash table items that do not satisfy the given predicate.
  + `void filteri(((A, B) -> bool) f, ((A, B) hash_table) table)` Like filter, but predicate also takes keys as input.
  + `((A, B) hash_table) copy(((A, B) hash_table) table)`. Create a copy of a hash table.
  + `(int list) bucketSizes(((A, B) hash_table) table)`. Returns a list of the sizes of the various buckets. This is to allow users to gauge the quality of their hashing function.
  
#### hashtable

An unique(rename) module, which could map discrete instances to `0, 1, 2, 3...`.

##### Dependencies

None.

##### Methods

- Unique. Record all elements it have been given, and rename them to `0, 1, 2, 3...`. A unique module for `A` will have type `A Unique.t`.
  + `(A t) init(((A, A) -> bool) comp)`. Init a unique instance by a comparison function. The size of the instance can grow automatically,
  + `((A t), int) unique((A t) u, A a)`. Rename a object to a natural number, return the new unique instance and the number. If a object is recorded, the return number will be the same.
  + `int itemsNum((A t) u)`. Return how many items have been recorded.
    
#### mlrandom

Random int/real library,

##### Dependencies

Nonet.

##### Methods

- Mlrandom.
    + `void init()`. Init Mlrandom module.
    + `int rand()`. Return a random integer.
    + `int uniformInt(int l, int h)`. Return a integer in range [l, h).
    + `real uniformReal(real l, real h)`. Return a real number in range [l, h).

