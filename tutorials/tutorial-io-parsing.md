---
title: IO and Parsing
parent: Mitchell Tutorials
nav_order: 3
---
# Mitchell Tutorial: IO and Parsing
{:.no_toc}

This tutorial will walk you through the process of getting data from disk into
your Mitchell program. Note that Mitchell is a language that is meant to run on
hardware accelerators. Whenever possible, use the functions from the
Mitchell-specific IO libraries (such as `LibSVM.fromFile`) to implement your
program, so that they will be compatible with compilation to a hardware
accelerator.

**Note that you will not have to implement any parsing code for your assigned
workload. The data preparation and parsing has been done for you as part of the
scaffolding for the assigned workload.** However, you may find it useful
practice with the language to implement your own parser in Mitchell before
beginning working on the assigned workload.

In this tutorial, we will walk through the implementation of LibSVM parsing. In
general, it is a good idea to use external tools convert your data into a
simple-to-parse format for use with Mitchell.
LibSVM is a relatively simple format, and so is easy to parse with Mitchell.

1. Generated Toc
{:toc}

## The LibSVM Format

The DMatrix format is defined
[here](https://xgboost.readthedocs.io/en/latest/tutorials/input_format.html).
We will only be handling the subset of the format that is visible below:

```
0 2:1 5:1 6:1
1 2:1 6:0.5 12:1
0 3:1 5:1 12:1 13:1
```

We will assume

- the labels the integers 1 or 0,
- all feature are real-valued, and
- features not explicitly given for a datum have value 0.0.

## Reading the File

If the training and test data can fit into memory, then we can read the whole
file in at once, and then start processing on it. To read a the whole file, you
can do the following, using [`TextIO`](http://sml-family.org/Basis/text-io.html)
and [`Substring`](http://sml-family.org/Basis/substring.html) from the Standard
ML Basis Library:

```sml
val fileHandle = TextIO.openIn filename;
val content = Substring.full (TextIO.inputAll fileHandle);
val _ = TextIO.closeIn fileHandle;
```

These three lines open the file, read in the whole contents of the file as a
`string`, convert the string into a `substring` (which supports parsing
operations), and then closes the file.

## Helper functions

### Parsing Numbers

To help with parsing numbers, we define two helper functions. To convert
strings to integers we use the library function `Int.fromString`, and to convert
the strings to reals we use `Real.fromInt`.

```
fun intFromSubstring s =
    let
      val str = Substring.string s
    in
      case Int.fromString str of
          SOME n => n
        | NONE => raise Fail ("not an int: "^str)
    end;

fun realFromSubstring s =
    let
      val str = Substring.string s
    in
      case Real.fromString str of
          SOME n => n
        | NONE => raise Fail ("not a real: "^str)
    end;

```

Both `Int.fromString` and `Real.fromString` produce an `option` type, which can
either be `SOME` value or `NONE`. When the number cannot be parsed (the `NONE`
case) we raise an exception with an informative error message. The caret symbol
(`^`) is used to append two strings.

### Splitting Up the Data

To help with splitting up the data, we define a few helper functions.

```sml
fun lines str =
    let
      fun isNewline c = (c = #"\n");
    in
      Substring.tokens isNewline str
    end;

fun words str =
    let
      fun isSpace c = (c = #" ");
    in
      Substring.tokens isSpace str
    end;
```

These helper functions make use of
(`Substring.tokens`)[http://sml-family.org/Basis/substring.html#SIG:SUBSTRING.tokens:VAL],
which splits a string based on a predicate on individual characters, skipping
over any empty strings that would result from the split. Our implementations
split the string into lines, by checking for newline characters (`#"\n"`), and
into words, by checking for space characters (`#" "`). The hash-quote syntax is
how to write a character literal in Mitchell.

Applying `lines` to the data will result in a list of lines. In order to apply
`words` to each line, we use
[`List.map`](http://sml-family.org/Basis/list.html#SIG:LIST.map:VAL).

```sml
val tokens = List.map words (lines content);
```

We now have a list of strings like this:
```sml
[
  ["0", "2:1", "5:1", "6:1"],
  ["1", "2:1", "6:0.5", "12:1"],
  ["0", "3:1", "5:1", "12:1", "13:1"],
]
```

### Record-by-Record Parsing

We want to be compatible with the input type used by the Mitchell GBDT library,
so we want this input to eventually be a list of pairs, where the left-hand-side
of the pair is a real-valued array, representing the feature vector and the
right-hand side of the pair is a real-valued label, with all of the 0 values
turned into -1 values. All of the arrays have to have the same length.

Since this format is record-based, and we have `List.map` at our disposal, we
can implement a conversion function for a single record and use it with
`List.map` to produce the parser for the whole file. However, we can create a
complete parser in this way, because we need to determine the largest feature
number to know how big to make the array to store the feature vector. We'll do
most of the work in this line-by-line fashion, and then finish by converting all
of the feature vector lists to arrays.

Let's start by assuming we have a function `parseFeatureVector` which will take
a list like this `["2:1", "5:1", "6:1"]` and produce a list of pairs of integers
(the feature numbers) and reals (the feature values). We will also assume a
function `parseLabel` that parses a label. We will implement them shortly, but
it is easier to work top-down here.

```sml
fun parseLabel label = raise Fail "not yet implemented";
fun parseFeatureVector featureVector = raise Fail "not yet implemented";
```

If we have the helper functions, all we need to do is split the first element of
the list away from the rest and convert it to a real number.

```sml
fun parseRecord input =
    case input of
        label :: featureVector => (parseFeatureVector featureVector, parseLabel label)
      | nil => raise Fail "empty record";
```

Using `case` we can pattern match on the list to get the first element (`label`)
and the rest of the elements (`featureVector`). The double-colon `::` is the
constructor for putting something on the front of the list, so we can match
against it to take the list apart again.

In the case where the list is empty (`nil`), we raise an error with an
informative error message.

### Parsing the Label

To parse the label, we use our helper function from above. We parse the label as
an integer so that we can reliably compare it to 0. To comply with the interface
expected by the Mitchell GBDT, we must convert 0 labels to -1 (which is
written with a tilde as `~1` in Mitchell). To convert the integers to reals, we
use `Real.fromInt`.

```sml
fun parseLabel label =
    case intFromSubstring label of
        0 => ~1.0
      | x => Real.fromInt x
```

### Parsing the Feature Vector

Much like parsing the whole record, parsing the feature vector involves parsing
the whole list, so we will again use helper functions. We define an additional
helper like `isSpace` above to help with splitting the string on the colon.

When we pattern match on the list this time, we look for lists of exactly length
2: lists that have two values put on top of the empty list `nil` using `::`.
Using the underscore (`_`) in the next pattern match case, we can match on all
other shapes of list without needing to come up with a name for a value we don't
want to use. In the case that `_` is matched, we raise an exception with an
informative message.

Since the caret symbol (`^`) works on the `string` type, not the `substring`, we
convert the `substring` back into a `string` before appending it.

```sml
fun parseFeature feature =
    let
      fun isColon c = (c = #":");
    in
      case (Substring.tokens isColon feature) of
          featureId::featureValue::nil => (intFromSubstring featureId, realFromSubstring featureValue)
        | _ => raise Fail ("invalid feature string: "^(Substring.string feature))
    end;

fun parseFeatureVector featureVector =
    List.map parseFeature featureVector;
```

We use `parseFeature` to parse each feature in the list by mapping it over the
list with `List.map`.

### Finding the Maximum Feature ID

In order to turn the feature lists into arrays, we need to know what the maximum
possible feature ID is. To find it, we define a maximum function (that defaults
to 0 for an empty list) and use a map first over the records, and then over the
feature lists to get the maximum.

```sml
fun maxFeatureId (records : ((int * 'b) list * 'a) list) : int =
    let
      fun maximum data = List.foldl Int.max 0 data
      fun getMaxId featureList = maximum (List.map #1 featureList)
      val featureLists = List.map #1 records
      val maximumPerRecord = List.map getMaxId featureLists
    in
      maximum maximumPerRecord
    end
```

### Converting the Feature List to an Array

To convert the feature list to an array, we use the
[`Array.tabulate`](http://sml-family.org/Basis/array.html#SIG:ARRAY.tabulate:VAL)
function. `Array.tabluate` takes as arguments the size of the array and a
function that maps each index to the value that should be at that index. This
means that we have to define a lookup function that will get the value for a
feature ID for a given feature list. As we stated in the assumptions earlier, we
will treat missing features as having the value 0.0.

The [`List.find`](http://sml-family.org/Basis/list.html#SIG:LIST.find:VAL)
function is helpful for picking a value out of a list based on some criteria.
The trick for us is to define that criteria based on an ID that is given to our
`lookup` helper function.

```sml
fun featureListToArray (maxId, featureList) =
    let
      fun lookup id =
          let
            fun isFeatureId datum = (id = #1 datum)
          in
            case List.find isFeatureId featureList of
               NONE => 0.0
             | SOME (_, r) => r
          end
    in
      Array.tabulate (maxId, lookup)
    end
```

Now we can get the maximum feature ID across all of the data, and use it to
convert the feature list of each record into an array, as expected by the
Mitchell GBDT library.

```sml
fun convert (data : ((int * real) list * real) list) : (real array * real) list =
    let
      val maxId = maxFeatureId data;
      fun convertRecord record =
          (featureListToArray (maxId, (#1 record)), #2 record)
    in
      List.map convertRecord data
    end
```

### Putting It Together

Now we can put everything together to define a function that will parse the data
we need from a file. We use the IO operations from the beginning of this
tutorial, then we tokenize the contents of the file. Once we have the tokens we
parse each record, and then convert the feature lists in the records into
arrays for use with the Mitchell GBDT library (or the algorithm you implemented
in the [GBDT tutorial](/tutorials/tutorial-gbdt.md)).

```sml
fun fromFile filename =
    let
      val fileHandle = TextIO.openIn filename;
      val content = Substring.full (TextIO.inputAll fileHandle);
      val _ = TextIO.closeIn fileHandle;
      val tokens  = List.map words (lines content);
    in
      convert (List.map parseRecord tokens)
    end;
```
