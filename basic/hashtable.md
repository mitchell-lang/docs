---
parent: Mitchell Libraries
---
# Hash Tables (Dictionaries)

This library provides mutable hash-based dictionary data structures called hash
tables. The module `HashString` defines a hash function for strings for use with
hash tables. The module `HashTable` provides the hash table type and operations.

## Basic Usage

```sml
(* Crate an empty hash table. *)
val table = HashTable.mkTable(HashString.hashString, op=, 10);
val x = table.find(table, "hello");
(* val x = NONE *)
val _ = table.insert(table, ("hello", 42));
val y = table.find(table, "hello");
(* val y = SOME 42 *)
val _ = table.insert(table, ("hello", 43));
val z = table.find(table, "hello");
(* val z = SOME 43 *)
val _ = table.remove(table, "hello");
val w = table.find(table, "hello");
(* val w = NONE *)
```

## HashString

### Interface
- `val hashString: string -> word`{:.language-sml}

### Description

- `hashString str`{:.language-sml}
  - Hash a string to a [word](http://sml-family.org/Basis/word.html)

## HashTable

### Interface
- `type ('k, 'v) hash_table`

- `((A,B) hash_table) mkTable((A -> word) hashf, ((A * A) -> bool) comp, int len)`. Given a hashing function(hash an object to a word, which is a binary number, whose length depends on the architecture) and an equality predicate, create a new table; len is a size hint.  `MLton.hash` is a general hash function that works for all objects, `HashString.hashString` is designed for strings.
- `unit clear(((A, B) hash_table) table)`. Remove all elements from the table.
- `unit insert(((A, B) hash_table) table, (A key, B value))` Insert an item. If the key already has an item associated with it, then the old item is discarded.
- `bool inDomain(((A, B) hash_table) table, A key)`. Return true, if the key is in the domain of the table.
- `B lookup(((A, B) hash_table) table, A key)`. Find an item; an exception is raised if the item doesn't exist.
- `(B option) find(((A, B) hash_table) table, A key)`. Look for an item, return NONE if the item doesn't exist.
- `B remove(((A, B) hash_table) table, A key)`. Remove an item, returning the item. An exception is raised if the item doesn't exist.
- `int numItems(((A, B) hash_table) table)`. Return the number of items in the table.
- `(B list) listItems(((A, B) hash_table) table)`. Return a list of the items in the table.
- `((A, B) list)) listItemsi(((A, B) hash_table) table)`. Return a list of the items and their keys in the table.
- `unit app((B -> unit) f, ((A, B) hash_table) table)`. Apply a function to the values of the table.
- `unit appi(((A, B) -> unit) f, ((A, B) hash_table) table)`. Apply a function to the entries of the table
- `((A, C) hash_table) map((B -> C) f, ((A, B) hash_table) table)`. Map a table to a new table that has the same keys.
- `((A, C) hash_table) mapi(((A, B) -> C) f, ((A, B) hash_table) table)`. Like map, but the mapping function also takes keys as input.
- `C fold(((B, C) -> C) f, C default, ((A, B) hash_table) table)`. Fold a function over the values of a table.
- `C foldi(((A, B, C) -> C) f, C default, ((A, B) hash_table) table)`. Like fold, but the recursive function also takes keys as input.
- `unit modify((B -> B) f, ((A, B) hash_table) table)`. Modify the hash-table items in place. Notice that the input type in the modification function is the same as output type, which is different from the mapping function.
- `unit modifyi(((A, B) -> B) f, ((A, B) hash_table) table)`. Like modify, but modification function also takes keys as input.
- `unit filter((B -> bool) f, ((A, B) hash_table) table)`. Remove any hash table items that do not satisfy the given predicate.
- `unit filteri(((A, B) -> bool) f, ((A, B) hash_table) table)` Like filter, but the predicate argument also takes keys as input.
- `((A, B) hash_table) copy(((A, B) hash_table) table)`. Create a copy of a hash table.
- `(int list) bucketSizes(((A, B) hash_table) table)`. Returns a list of the sizes of the various buckets. This is to allow users to gauge the quality of their hashing function.


## Method Overview
- HashTable. hashtable has type `(A, B) hash_table`, `A` is the type of the key, `B` is the type of value.
  + `((A,B) hash_table) mkTable((A -> word) hashf, ((A * A) -> bool) comp, int len)`. Given a hashing function(hash an object to a word, which is a binary number, whose length depends on the architecture) and an equality predicate, create a new table; len is a size hint.  `MLton.hash` is a general hash function that works for all objects, `HashString.hashString` is designed for strings.
  + `unit clear(((A, B) hash_table) table)`. Remove all elements from the table.
  + `unit insert(((A, B) hash_table) table, (A key, B value))` Insert an item. If the key already has an item associated with it, then the old item is discarded.
  + `bool inDomain(((A, B) hash_table) table, A key)`. Return true, if the key is in the domain of the table.
  + `B lookup(((A, B) hash_table) table, A key)`. Find an item; an exception is raised if the item doesn't exist.
  + `(B option) find(((A, B) hash_table) table, A key)`. Look for an item, return NONE if the item doesn't exist.
  + `B remove(((A, B) hash_table) table, A key)`. Remove an item, returning the item. An exception is raised if the item doesn't exist.
  + `int numItems(((A, B) hash_table) table)`. Return the number of items in the table.
  + `(B list) listItems(((A, B) hash_table) table)`. Return a list of the items in the table.
  + `((A, B) list)) listItemsi(((A, B) hash_table) table)`. Return a list of the items and their keys in the table.
  + `unit app((B -> unit) f, ((A, B) hash_table) table)`. Apply a function to the values of the table.
  + `unit appi(((A, B) -> unit) f, ((A, B) hash_table) table)`. Apply a function to the entries of the table
  + `((A, C) hash_table) map((B -> C) f, ((A, B) hash_table) table)`. Map a table to a new table that has the same keys.
  + `((A, C) hash_table) mapi(((A, B) -> C) f, ((A, B) hash_table) table)`. Like map, but the mapping function also takes keys as input.
  + `C fold(((B, C) -> C) f, C default, ((A, B) hash_table) table)`. Fold a function over the values of a table.
  + `C foldi(((A, B, C) -> C) f, C default, ((A, B) hash_table) table)`. Like fold, but the recursive function also takes keys as input.
  + `unit modify((B -> B) f, ((A, B) hash_table) table)`. Modify the hash-table items in place. Notice that the input type in the modification function is the same as output type, which is different from the mapping function.
  + `unit modifyi(((A, B) -> B) f, ((A, B) hash_table) table)`. Like modify, but modification function also takes keys as input.
  + `unit filter((B -> bool) f, ((A, B) hash_table) table)`. Remove any hash table items that do not satisfy the given predicate.
  + `unit filteri(((A, B) -> bool) f, ((A, B) hash_table) table)` Like filter, but the predicate argument also takes keys as input.
  + `((A, B) hash_table) copy(((A, B) hash_table) table)`. Create a copy of a hash table.
  + `(int list) bucketSizes(((A, B) hash_table) table)`. Returns a list of the sizes of the various buckets. This is to allow users to gauge the quality of their hashing function.

