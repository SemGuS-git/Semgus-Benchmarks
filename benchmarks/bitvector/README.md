# Bitvector Benchmarks

This directory contains bitvector benchmarks.
The benchmarks are taken from the [Synthesis of Loop-free Programs](https://susmitjha.github.io/papers/pldi11.pdf) 
paper, where the goal is to synthesize a bitvector circuit from a logical specification.
These benchmarks are written in <b>four</b> different semantics.

### `simple`

These are the standard benchmarks from the paper, i.e. synthesizing a circuit.

### `saturated`

These benchmarks consist of the same 25 in the `simple` directory, but where the semantics are written to be 
<i>saturated</i>, meaning that instead of overflowing, they remain as the bitvector max or min.

### `imperative`

These are the same 25 as in the `simple` directory, but written as straight-line imperative code over
bitvector variables.

### `impv-saturated`

These 25 benchmarks contain saturated semantics as in `saturated`, and are written as imperative code
as in `imperative`.
