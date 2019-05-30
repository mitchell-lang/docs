---
grand_parent: Mitchell Libraries
parent: Basic Libraries
---
# Hash Tables (Dictionaries)

This library provides mutable hash-based dictionary data structures called hash
tables. The module `HashString` defines a hash function for strings for use with
hash tables. The module `HashTable` provides the hash table type and operations.
The implementation is based on the hash tables from SML/NJ.

## Basic Usage

```sml
(* Crate an empty hash table. *)
val table = HashTable.mkTable(HashString.hashString, op=, 10);
val x = table.find(table, "hello");
(* val x = NONE *)
val _ = HashTable.insert(table, ("hello", 42));
val y = HashTable.find(table, "hello");
(* val y = SOME 42 *)
val _ = HashTable.insert(table, ("hello", 43));
val z = HashTable.find(table, "hello");
(* val z = SOME 43 *)
val _ = HashTable.remove(table, "hello");
val w = HashTable.find(table, "hello");
(* val w = NONE *)
```

## HashString

### Interface
- `val hashString: string -> word`

### Description

- `hashString str`
  - Hash a string to a [word](http://sml-family.org/Basis/word.html)

## HashTable

### Interface

#### Types
- `type ('k, 'v) hash_table`
  - A hash table mapping keys of type `k` to values of type `v`.

#### Methods
- `val mkTable : (('a -> word) * (('a * 'a) -> bool)) * int -> ('a,'b) hash_table`
- `val clear : ('a, 'b) hash_table -> unit`
- `val insert : ('a, 'b) hash_table * ('a * 'b) -> unit`
- `val inDomain : ('a, 'b) hash_table * 'a -> bool`
- `val lookup : ('a, 'b) hash_table * 'a -> 'b`
- `val find : ('a, 'b) hash_table * 'a -> 'b option`
- `val remove : ('a, 'b) hash_table * 'a -> 'b`
- `val numItems : ('a, 'b) hash_table ->  int`
- `val listItems  : ('a, 'b) hash_table -> 'b list`
- `val listItemsi : ('a, 'b) hash_table -> ('a * 'b) list`
- `val app  : ('b -> unit) * ('a, 'b) hash_table -> unit`
- `val appi : (('a * 'b) -> unit) * ('a, 'b) hash_table -> unit`
- `val map  : ('b -> 'c) * ('a, 'b) hash_table -> ('a, 'c) hash_table`
- `val mapi : (('a * 'b) -> 'c) * ('a, 'b) hash_table -> ('a, 'c) hash_table`
- `val fold  : (('b *'c) -> 'c) * 'c * ('a, 'b) hash_table -> 'c`
- `val foldi : (('a * 'b * 'c) -> 'c) * 'c * ('a, 'b) hash_table -> 'c`
- `val modify  : ('b -> 'b) * ('a, 'b) hash_table -> unit`
- `val modifyi : (('a * 'b) -> 'b) * ('a, 'b) hash_table -> unit`
- `val filter  : ('b -> bool) * ('a, 'b) hash_table -> unit`
- `val filteri : (('a * 'b) -> bool) * ('a, 'b) hash_table -> unit`
- `val copy : ('a, 'b) hash_table -> ('a, 'b) hash_table`
- `val bucketSizes : ('a, 'b) hash_table -> int list`

### Method Overview
- `hash_table (hashf, eq, len)`
  - Creates a new empty hash table, using the given hashing function and
    equality predicate and initial hash table capacity. Most of the time (when
    using structural equality), one can use `MLton.hash` as the hash function
    and `op=` as the equality comparison for constructing a hash table.
    `HashString.hash` is a hash function that is specialized for strings.
- `clear table`
  - Removes all elements from the table. This modifies `table`.
- `insert (table, (key, value))`
  - Inserts an item into the table. If the key is already mapped to a value, the
    value is replaced. This modifies `table`.
- `inDomain (table, key)`
  - Determines if the table maps the key to some value.
- `lookup (table, key)`
  - Finds the value associated with a key in the table. If the table does not
    map the key to a value, an exception is raised. (It is recommended to use
    `find` instead.)
- `find (table, key)`
  - Finds the value associated with a key in the table. If the table maps the
    key to the value `v`, then the result as `SOME v`. If the table does not map
    the key to a value, the result is `NONE`.
- `remove (table, key)`
  - Removes the mapping for `key` from the table. The removed item is returned.
    If the table does not contain a mapping for `key` an exception is raised.
    This modifies `table`.
- `numItems table`
  - Returns the number of keys mapped by the table.
- `listItems table`
  - Returns a list of the values mapped to by keys in the table.
- `listItemsi table`
  - Returns an association list containing the mappings (pairs of keys and
    values) in the table.
- `app (f, table)`
  - Applies the function `f` to the values in the table.
- `appi (f, table)`
  - Applies the function `f` to the key-value pairs in the table.
- `map (f, table)`
  - Creates a new table with the same keys as `table` but with values determined
    by the result of applying `f` to the values in the original table.
- `mapi (f, table)`
  - Creates a new table with the same keys as `table` but with values determined
    by the result of applying `f` to the key-value pairs in the original table.
- `fold (f, base, table)`
  - Combines the values of `table` using the function `f`, starting with `base`.
    The function `f` should take as an argument a tuple of the next value in
    `table` to process and the result accumulated so far.
- `foldi (f, default, table)`
  - Combines the key-value pairs of table using the function `f`, starting with
    `base`. The function `f` should take as an argument a tuple of the next
    key-value pair in `table` to process and the result accumulated so far.
- `modify (f, table)`
  - Replaces each value in `table` with the result of applying `f` to the
    original value. This modifies `table`.
- `modifyi (f, table)`
  - Replaces each value in `table` with the result of applying `f` to the
    original key-value pair. This modifies `table`.
- `filter (f, table)`
  - Removes all of the mappings in `table` where the value does not make `f`
    true.
- `filteri (f, table)`
  - Removes all of the mappings in `table` where the key-value pair does not
    make `f` true.
- `copy table`
  - Creates a new copy of `table`.
- `bucketSizes table`
  - Returns a list of the sizes buckets used in the table. This is for debugging
    and improving the hash functions used with hash tables.
