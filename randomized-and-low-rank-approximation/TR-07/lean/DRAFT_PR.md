# Proposed title

TR-07: formalize the complete fixed-sparsity column-subset theorem

# Proposed draft PR body

This formalizes the entire original TR-07 asymptotic statement. For every fixed sparsity and admissible aspect ratio, every deterministic signed sparse matrix sequence, and every positive threshold, the probability that a uniform column subset has smallest singular value above that threshold tends to zero. Arbitrary support intersections and repeated column values are included.

`NLA.TR07.random_column_subsets` proves the unchanged, independently reviewed target. The proof includes regularized covariance filtering, finite signed trajectories, reconstruction from actual sampled reservoir columns, rank-nullity and Bessel witnesses, IID concentration, collision repair, exact uniform-subset counting, and the final limit. Its polynomial tail bound suffices for the entire original problem; the source's stronger exponential estimate is not claimed.

Lean 4.33.1, Mathlib and transitive dependencies are pinned. The complete local build and transitive axiom audit pass, using only `propext`, `Classical.choice`, and `Quot.sound`. Independent nonauthor AI agents reviewed the frozen statement before proofs and the complete final mathematical source. Reports, source hashes and local logs are included. Fresh sandboxed Linux Comparator and default-kernel verification are still pending, so the canonical status remains `Solved`.

Sidney Holden receives mathematical-resolution credit; Huang, Rudelson and Tikhomirov retain conjecture and prior-result credit. OpenAI Codex agents generated the Lean implementation and documentation. Independent reviews are AI-agent reviews; no external human peer review or source-author endorsement is claimed. The original target, permanent ID and canonical path are preserved. This is a draft for contributor review.

# Submission status

The full proof is committed locally on `codex/tr07-complete-lean`. Publishing the proof commit is pending GitHub authentication/window access. The remote branch currently contains only the earlier statement freeze. Push the complete branch before using the comparison below; then wait for its required Linux verification and retain the evidence before any `Lean verified` status promotion.

- Base: `ajt60gaibb/OpenProblemsInNLA`, branch `main`.
- Head: `marcusdavidwebb/OpenProblemsInNLA`, branch `codex/tr07-complete-lean`.
- Open as **Draft**, using the title and body above after updating verification status.

[Open the comparison](https://github.com/ajt60gaibb/OpenProblemsInNLA/compare/main...marcusdavidwebb:OpenProblemsInNLA:codex/tr07-complete-lean?expand=1)
