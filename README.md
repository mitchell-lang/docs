---
permalink: /
nav_order: 1
---
# Mitchell Evaluation

Mitchell is a variant of the
[Standard ML](https://en.wikipedia.org/wiki/Standard_ML)
programming language that has been optimized to support high-performance
computing on emerging new hardware that is specialized for machine learning
and graph analytics. The Mitchell compiler is based on the 
[MLton](http://mlton.org/) Standard ML compiler.

The primary advantage of Mitchell is that the compiler and libraries perform 
parallel processing optimizations automatically. In contrast to 
conventional programming languages, developers are only responsible for 
ensuring a correct implmentation&mdash;Mitchell does the rest. Highly-parallelizable
functions, like map and fold, will automatically leverage the massively 
multi-threaded hardware architecture that Mitchell has been designed to target. 

## Getting Started

Start with [Getting Started](getting-started.md) to make sure that you can
connect to the evaluation virtual machines and run a Mitchell program.

See the list of tutorials at the end of [Getting Started](getting-started.md#next-steps)
for what to do next.

## Mitchell Library Documentation

The Mitchell library documentation is available [here](mitchell_lib_doc.md). If
something is missing from the documentation, you find an error, or have a
suggestion on how to improve the documentation, let us know in the Mitchell
evaluation Slack channel.

Mitchell includes the
[Standard Basis Library](http://sml-family.org/Basis/index.html)
of Standard ML and some of the libraries of the
[MLton compiler](http://www.mlton.org/MLtonStructure).

## Targeting Mitchell to Hardware Accelerators

There is functionality in the Standard Basis Library, such as network access,
that will work in the evaluation environment, but that will not cross-compile to
the novel hardware architecture that Mitchell is intended to target.

So that you can write programs that read input from disk, we have left this
functionality in place. However, please keep all of your IO in one place in your
program, so that we can easily modify your programs to run on the custom
hardware accelerator for our analysis.
