# A Note on Using Types to Help with Development

Mitchell can always figure out the types for you for a program where all of the
parts of the program agree on what the types should be. However, while you are
developing, you may need some assistance in figuring out where parts of your
program disagree. By default, the location that the compiler tells you is where
the compiler figured out that there is a mismatch--it isn't necessarily where
the source of the problem is.

In order to aid the compiler in narrowing down where the problem is, you can
annotated your functions with type information. That way, the compiler will know
what you think the type of something is, and can figure out whether the problem
is in the function that you annotated, or in something that is using the
function that you annotated.

You also don't have to give the full type for a function. For example, you can
give just the return type:

```sml
fun parseRecord input : ((int * real) list * real) list =
    case input of
        label :: featureVector => (parseFeatureVector featureVector, parseLabel label)
      | nil => raise Fail "empty record";
```

For types like `list`, you have to say what type of values go in the list. The
type of values that go in a list are written before the word `list`, unlike
other languages where it is written afterwards or in brackets. For example,
`(int * real) list` would be `List<Pair<Integer, Double>>` in a language like
Java.

You can also give just the type of the arguments:

```sml
fun parseRecord (input : substring) =
    case input of
        label :: featureVector => (parseFeatureVector featureVector, parseLabel label)
      | nil => raise Fail "empty record";
```

It is usually helpful to give the full function type, though:

```sml
fun parseRecord (input : substring) : ((int * real) list * real) list =
    case input of
        label :: featureVector => (parseFeatureVector featureVector, parseLabel label)
      | nil => raise Fail "empty record";
```
