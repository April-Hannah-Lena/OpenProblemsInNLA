# TR-07 verification record

The statement was frozen before proof implementation at `1b27d9f8`.
Its bytes remain unchanged; [STATEMENT_SHA256.json](STATEMENT_SHA256.json)
records the reviewed boundary. [PROOF_SHA256.json](PROOF_SHA256.json)
records the 36 proof inputs, including source, comparison configuration,
toolchain and dependency pins.

## Recorded local checks — 28 September 2026

- [Local build](local-build.log): `lake build Solution Challenge` passed
  (3233 jobs). The only warning is the deliberate independent Challenge placeholder.
- [Transitive axiom audit](axioms.log): the complete theorem and ten bridge
  results use only `propext`, `Classical.choice`, and `Quot.sound`.
  [Check.lean](Check.lean) is the audit input.
- [Repository checks](repository-checks.log): published-base permanent-ID
  validation and 17 ID tests, 30 Lean selection tests and 12 harness tests pass.
- [Independent reviews](../reviews/): two nonauthor AI agents reviewed
  the frozen statement before proofs and separately audited the completed source.

These are local macOS development checks. Fresh unprivileged Linux
Comparator, default-kernel replay, permitted-axiom checks and rejection
controls are pending. The canonical status remains `Solved` until the
required verification and final evidence review succeed.

## Reproduction

From the project directory, with the pinned toolchain:

```sh
lake exe cache get
lake build Solution Challenge
lake env lean verification/Check.lean
```

From the repository root on supported unprivileged Linux:

```sh
python3 -m pip install -r tools/lean/requirements.txt
python3 tools/lean/validate_manifest.py randomized-and-low-rank-approximation/TR-07/lean
tools/lean/bootstrap.sh /tmp/nla-tr07-checker
tools/lean/verify.sh randomized-and-low-rank-approximation/TR-07/lean /tmp/nla-tr07-checker
```

The unchanged repository harness performs fresh isolated compilation,
statement comparison, transitive axiom checks and kernel replay with
rejection controls. No custom axiom, trusted native evaluation or numerical
certificate is used.
