# Regular Expression Benchmarks

This directory contains the set of benchmarks that involve regular expressions.

### `manually-constructed`

Contains set of benchmarks that were manually constructed for synthesizing
basic regular expressions.
Semantics represented in a matrix format as described in [the original SemGuS paper](https://arxiv.org/abs/2008.09836).

### `alpharegex`

A set of 25 benchmarks from the [AlphaRegex](https://cs.stanford.edu/~minalee/pdf/gpce2016-alpharegex.pdf) paper.
Semantics encoded in the matrix format like in `manually-constructed`.

### `shallow-embedding`

Contains set of benchmarks where semantics were written using a shallow embedding into the SMT Theory of Regex
, rather than the matrix encoding. 
Currently mostly contains the 25 AlphaRegex benchmarks from `alpharegex` but in shallow embedding semantics.

### `grammar-flow`

Involves regexes for synthesizing, e.g. CSV templates.
Can benefit from running a <i>grammar flow analysis</i>.
