---
parent: FAQ
---
# Reading Compiler Errors in Mitchell

The following is a list of common errors that occur when compiling programs and
descriptions of how to understand them.

## Function is not of arrow type.

```
Function not of arrow type.
  function: [string]
  in: "hello world" print
```

This message means that somewhere in the code there is something that is not a
function being used as one. The error message gives the inferred type of the
thing that was used as a function (`string` in the compiler above), as well as
the snippet of code where the problem is.

In the example above, the snippet of code has the arguments backwards, but this
isn't as silly of an example as it might seem. A common error is to write
something like the following

```sml
val x = "hello world"
print x
```

That code will result in the error above, because it is interpreted by the
compiler the same as writing the following, which looks like applying a string
to the `print` function.

```sml
val x = ("hello world" print) x
```

The fix is to make sure to include the `val` assignment for every statement.

```sml
val x = "hello world"
val _ = print x
```

The underscore `_` is a way of discarding the non-useful result of the call to
print.

## Undefined variable: x.

```
Undefined variable: x.
```

This message means that there is a variable, here named "x", that is used but
not defined anywhere. In Mitchell, variables have to be defined before they can
be used. This means that, for example, you have to define functions before you
use them in the file.

If you get this message about a function from the Standard Basis Library, make
sure that

- the function name is spelled correctly, including being the correct case, and
- the function is part of the module that you are referring to, not some other
  module.

For example, if you refer to `String.splitl`, you will get the message

```
Undefined variable: String.splitl.
```

that is because `splitl` is part of the `substring` module, not the `string`
module. if instead there was a typo and `substring` was written as `substirng`, the
error message would be

```
undefined structure: Substirng.
```

## undefined structure: X

```
undefined structure: X.
```

This means that you are referring to something that is part of a module, but the
module name was not recognized. Module names are case sensitive, and some
modules are very similar to each other in name and content (like `String` and
`Substring`), so make sure you are using the right one.
