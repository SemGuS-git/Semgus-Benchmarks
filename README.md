# Semantics-Guided Synthesis Benchmarks

This repository contains benchmark files for [SemGuS](http://semgus.org).

## Benchmark Contributions
Contributions of new benchmarks are welcome. Open a [pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) that adds the new benchmarks, and a maintainer will review the submission.
* Benchmarks must be categorized into appropriate folders, e.g. `non-deterministic` or `imperative`. If an appropriate folder does not exist, feel free to create it in your pull request.
* All contributed benchmarks must pass a syntax check before being approved, based on the current release of the [SemGuS Parser](https://github.com/SemGuS-git/Semgus-Parser). To test a benchmark locally, [install the parser](https://github.com/SemGuS-git/Semgus-Parser#Installation) and verify the benchmark:
`semgus-parser --format verify -- <your-benchmark.sl>`
* Feel free to create discussion posts with any questions, or issues about potential bugs in existing benchmarks.
