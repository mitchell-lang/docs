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
