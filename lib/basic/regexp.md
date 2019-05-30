---
grand_parent: Mitchell Libraries
parent: Data Structures and Utilities
---
# Regular Expressions

Mitchell uses the regular expression library from SML/NJ. The documentation for
that library is
[here](https://www.smlnj.org/doc/smlnj-lib/Manual/regexp-lib-part.html).

## Upstream Documentation Errata

There is an error in the documentation for the library. For the `find`,
`prefix`, and `match` functions, the type of the match is listed as

```sml
{pos : 'a, len : int} option MatchTree.match_tree
```

when it should be

```sml
{pos : 'a, len : int} MatchTree.match_tree
```

The `option` constructors that appear when pattern-matching on the results of
`find` and `prefix` below are part of the
[StringCvt.reader](http://sml-family.org/Basis/string-cvt.html#SIG:STRING_CVT.reader:TY)
type. Thus, a `MatchTree.match_tree` always contains at least one match, which
can be accessed using `MatchTree.root`.

## Basic Usage
The regular expression library has a number of configurable parts. The examples
below show some reliable defaults and basic usage patterns. All of the examples
begin by creating the module using `awk`-like
[regular expression
syntax](https://www.smlnj.org/doc/smlnj-lib/Manual/parser-sig.html)
and the backtracking based matching engine.

```sml
structure R = RegExpFn(structure P = AwkSyntax; structure E = BackTrackEngine)
```

### Has Match

To check if any part of a string matches a regular expression, the following can
be used.

```sml
(* Just check for a match *)
fun hasMatch reg str =
    let
      val r = R.compileString reg
      val s = Substring.full str
    in
      Option.isSome (R.find r Substring.getc s)
    end

val res = hasMatch "(A|B)B*" "CABBBCB"
val _ = print (Bool.toString res ^ "\n")
```

This results in the output

```
true
```

### Prefix Has Match

To check if a prefix of a string matches a regular expression, the following can
be used.

```sml
fun hasPrefixMatch reg str =
    let
      val r = R.compileString reg
      val s = Substring.full str
    in
      Option.isSome (R.prefix r Substring.getc s)
    end

val res = hasPrefixMatch "(A|B)B*" "CABBBCB"
val _ = print (Bool.toString res ^ "\n")
val res = hasPrefixMatch "(A|B)B*" "ABBBCB"
val _ = print (Bool.toString res ^ "\n")
```

This results in the output
```
false
true
```

### Offset and Length of Match

To find the offset and length of a match, the following can be used:

```sml
fun matchPosition reg str =
    let
      val r = R.compileString reg
      val s = Substring.full str
    in
      case R.find r Substring.getc s of
          NONE => NONE          (* No match *)
        | SOME (m, _) =>
          let
            val {pos=pos, len=len} = MatchTree.root m
            val (_, matchOffset, _) = Substring.base pos
          in
            (* If the string were from something other than Substring.full, we
               would have to subtract the offset of the outer substring.
             *)
            SOME (matchOffset, len)
          end
    end

val res = matchPosition "(A|B)B*" "CDABBBCB" (* true *)
val _ = case res of
            NONE => print "NONE\n"
          | SOME (off, len) =>
            print ("{off=" ^ Int.toString off ^ ", len=" ^ Int.toString len ^ "}\n")
```

This results in the output

```
{off=2, len=4}
```

### Matching String

To get the first matching string, the following can be used:

```sml
fun matchedString reg str =
    let
      val r = R.compileString reg
      val s = Substring.full str
    in
      case R.find r Substring.getc s of
          NONE => NONE
        | SOME (MatchTree.Match ({pos=pos, len=len}, _), _) =>
          SOME (Substring.slice (pos, 0, SOME len))
    end
val _ = case matchedString "(A|B)B*" "CDABBBCB" of
            NONE => print "NONE\n"
          | SOME str => print (Substring.string str ^ "\n")
```

This results in the output

```
ABBB
```
