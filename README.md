# SDH Mitchell Evaluation

## Purpose of the Evaluation

The purpose of this evaluation is to evaluate the ease of use of Mitchell
for developing machine learning and graph analytics applications.

When you run into problems, please ask your questions in the SDH Mitchell
evaluation Slack channel so that we can keep track of the questions that were asked
to add them to the [FAQ](faq.md).

Additionally, please keep notes on the following things to help us with
producing a report on the evaluation:
- How much time you spent on reading and understanding the paper for your workload.
- How much time you spent on writing code to get the training and test data into your program.
- How much time you spent on implementing the algorithm for your workload.

To help us improve our documentation, please also make a note of anything you
find confusing about the libraries, documentation, etc. If you
find it confusing, so will other people.

### A Record of Your Development

If you are comfortable using git, please use it to track your development,
so that we can review the development process to improve Mitchell.
Commit frequently, not just when you get things
working. We are interested in seeing what the code looks like when you first run
into problems as well as what they look like after you solve them.

Feel free to track the whole `/work` directory (see [Getting
Started](getting-started.md) for details on `/work`). Don't worry about putting
large files into Git. If you are doing data manipulation, we are interested in
seeing what you are doing to the data files as well.

## Getting Started

Start with [Getting Started](getting-started.md) to make sure that you can
connect to the evaluation virtual machines and run a Mitchell program.

After Getting Started, you can follow along with the [tutorial](tutorials/tutorial-gbdt.md)
to learn more about the Mitchell language and how to write machine learning algorithms
in Mitchell.

## Mitchell Library Documentation

The Mitchell library documentation is available at
[GitHub](mitchell_lib_doc.md). If something is missing from
the documentation, you find an error, or have a suggestion on how to improve the
documentation, let us know in the SDH Mitchell evaluation [Slack
channel](slack://channel?team=sdhworld&id=evaluation).

## Other Resources

Mitchell is based on a language called Standard ML, so many Standard ML programs
will run in Mitchell. See [Learn X in Y minutes for Standard
ML](https://learnxinyminutes.com/docs/standard-ml/) for a quick overview of how
to write some programs that will work in both Mitchell and Standard ML.

Some of the libraries are from the [Standard ML Basis
Library](http://sml-family.org/Basis/overview.html) are available in Mitchell.
There is functionality in the Basis Library, such as network access, that will
work in the evaluation environment, but that will not cross-compile to the
architecture that Mitchell is intended to target.

So that you can write programs that read input from disk, we have left this
functionality in place. However, please keep all of your IO in one place in your
program, so that we can easily modify your programs to run on the custom hardware accelerator for our
analysis.
