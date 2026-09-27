# Towards a reusable mathematical library

This is a step towards [mathlib's style](https://leanprover-community.github.io/contribute/style.html),
not a claim that the complete development is ready for an upstream mathlib PR.
The original definitions, probability law, final statements, dependency pins,
and repository entry points are unchanged.

## Reusable layer

[Measure/Comparison](NLA/FR05/Measure/Comparison.lean) imports only mathlib.
Its general results live in `MeasureTheory` and `MeasureTheory.Measure`:

- `map_prod_eq_withDensity`: the density of a parametrised mixture, with
  arbitrary parameter, source, and target spaces and extended-nonnegative
  densities. No group, probability normalisation, or integrability is assumed.
- `map_prod_eq_withDensity_ofReal`: the real-valued corollary.
- `map_prod_eq_withDensity_of_inv`: the inverse-action corollary, requiring
  only inversion invariance. Both FR-05 mixture proofs use this theorem.
- `abs_setIntegral_le_sqrt_setIntegral_sq`: Cauchy–Schwarz on a finite-measure
  event, without assuming the ambient measure is finite.
- `abs_setIntegral_le_sqrt_integral_sq`: the global-second-moment corollary
  used in the final FR-05 comparison.

These are project-local additions, not declarations already accepted into mathlib.
The previous FR-05 helper names remain available as compatibility aliases.

[Geometry/Obstruction](NLA/FR05/Geometry/Obstruction.lean) now contains the
deterministic transport API as well as the rank-two obstruction:

- global phase is preserved by complex-linear maps and reflected by equivalences;
- right matrix multiplication transports measurements, including rectangular matrices;
- a general coordinate-equivalence theorem transports injectivity;
- nonzero diagonal column scaling preserves injectivity, without unitarity.

The unitary and reference-frame proofs are corollaries of that API. The joint
measurability of the unitary frame action is also proved once and reused.
All these results keep the original all-signals predicate, including degenerate
dimensions; they introduce no extra FR-05 hypotheses.

## Gaussian, small-ball, and overlap machinery

These refactors reuse existing modules and declarations instead of expanding the
library surface. The latest consolidation reduces **157 modules to 112**. It adds
no supporting files: this guide and the existing verification files are updated
in place.

- [GaussianFrameRows](NLA/FR05/Gaussian/GaussianFrameRows.lean) now gathers the
  scalar/product laws, conjugation symmetry, and arbitrary coordinate-block
  splitting. Sphere projections and the four-coordinate overlap coupling share
  the same splitting theorem, including empty blocks.
- [GaussianGram](NLA/FR05/Gaussian/GaussianGram.lean) contains the orthonormal and
  unitary invariance corollaries of Gram-law equality. These no longer live in
  application-specific density and likelihood modules. Singular Gram matrices
  remain allowed.
- [GaussianSmallBall](NLA/FR05/SmallBall/GaussianSmallBall.lean) imports only
  mathlib, with targeted tactic imports. It contains both peak-density bounds
  and the variance-uniform estimate, including zero variance. The planted phase
  assembly is separate. The two projection small-ball proofs use the same
  `MeasurePreserving` law rather than repeat pushforward/set calculations.
- [HaarCorner](NLA/FR05/Overlap/HaarCorner.lean) identifies the overlap law using
  mathlib's measure-preserving group shear, replacing the separate integration
  argument.
- [Spectrum](NLA/FR05/Overlap/Spectrum.lean) has named sections for singular
  values, the operator ball, and positive square roots. The Hermitian determinant
  formulas share `Matrix.IsHermitian.det_one_add_smul_eq_prod`. Paper-specific
  scalar bounds with constants `1/4` and `1/2000` now live in
  [ReferenceKernelExact](NLA/FR05/Likelihood/ReferenceKernelExact.lean).

The Gaussian/overlap cleanup added only two substantive API lemmas: the
measure-preserving projection wrapper and the shared determinant identity.
Each replaces duplication in two existing proofs. The phase simplification adds
two shared identities; the mathematical compression below adds two replacement
helpers. The audit follows the final theorem's
proof dependencies: all 17 substantive API additions across these cleanup passes
are used. The two old compatibility aliases are intentionally excluded.

The dependency graph remains acyclic, but it is not a fully independent library
layer: Gaussian definitions still pass through existing planted-law modules.
The preceding API cleanup reduced the project-module dependency closure of
`NormalizedProjectionLaw` from 77 to 61 modules and the uniform projection
small-ball bound from 22 to 14, before the latest file consolidation. Those are
historical counts, not counts for the current merged layout.

## Further consolidation and proof simplification

Closely related laws, bounds, and their immediate corollaries now share files:
Gaussian density transformations, projection small-ball estimates, row-span
normals, planted derivative bounds, cone estimates, local kernel remainders,
and sequential Haar/overlap laws. The 45 absorbed files become named sections in
32 existing modules. Imports are redirected, duplicate imports removed, and
local notation, options, and instances retain their section scopes. The
[module map](verification/reorganisation/module-map.json) records the moves.
Files are not combined where doing so would introduce an import cycle.

The mathematical simplifications use the pinned mathlib without new assumptions:

- [PhaseAffine](NLA/FR05/SmallBall/PhaseAffine.lean) applies
  `AddCircle.measurePreserving_mk` once for arbitrary measurable phase events.
  Two shared identities replace the repeated interval/circle calculations in
  six affine-cosine and absolute-cosine proofs.
- [LeastSingular](NLA/FR05/Geometry/LeastSingular.lean) uses
  `linearIndependent_iff_notMem_span` to find a dependent row, and
  `exists_norm_eq` to choose a unit vector in the orthogonal complement.
- [ConeImageEstimates](NLA/FR05/Cone/ConeImageEstimates.lean) derives the integral
  square bound from `ProbabilityTheory.variance_eq_sub` and `variance_nonneg`,
  replacing the hand-expanded centred-square integral.

The longer Gaussian radial-law identification and exact density changes of variables
remain custom proofs: no suitable drop-in replacement was found in the pinned
mathlib. The arccosine modulus still needs a proof, shortened below using existing
concavity and cosine bounds. The contraction argument already uses mathlib's
fixed-point theorem. Consolidation is not a claim that these arguments disappeared.

## Mathematical compression

The next pass changes the arguments, not the file organisation (still 112 modules):

- **Exact midpoint cancellation.** For the quadratic planted map,
  $F(x)-F(y)=DF((x+y)/2)(x-y)$. Subtracting the two symmetric expansions cancels
  their quadratic terms. [SourceLocalControl](NLA/FR05/Planted/SourceLocalControl.lean)
  now bounds just the bilinear derivative variation; the separate estimate of
  the quadratic remainder is unnecessary. This improves the nonlinear-error
  constant from 2048 to 1024. The later frozen-Jacobian bound retains its existing
  constant, so the Newton radius, thresholds, and final estimates are unchanged.
- **Separate the even exponential factors.** In
  [ScalarTaylor](NLA/FR05/Likelihood/ScalarTaylor.lean),
  $\frac12(e^{-A+B}+e^{-A-B})=e^{-A}\cosh B$. Expand the first factor to order one
  and the second to order two. The error is bounded by
  $(B^4+A^2+|A|B^2/2)e^{|A|+|B|}$, avoiding the old mixed cubic expansion.
  Since $A$ is of quadratic size and $B$ of linear size, this gives the same
  fourth-order estimate with constant 304 instead of 5000. The subsequent
  paper-facing constant 11000 is deliberately retained.
- **Use scale invariance of square roots.**
  [ImbalancePerturbation](NLA/FR05/Planted/ImbalancePerturbation.lean) factors out
  $\sqrt{S/2}$ and proves the dimensionless inequality
  $|\sqrt{1+\xi}-1|\le|\xi|$ on $[-1,1]$. This replaces the longer calculation
  with a radial-dependent denominator.
- **Use a direct quadratic cosine bound.**
  [PhaseSmallBall](NLA/FR05/SmallBall/PhaseSmallBall.lean) applies mathlib's
  $\cos u\le1-2u^2/\pi^2$ on $[-\pi,\pi]$, eliminating the separate half-angle
  identity and sine estimate. This does not eliminate the inverse-cosine argument
  for arbitrary-level bands in `PhaseAbsolute`.

The two new helper lemmas, `sourceEquation_midpoint_difference_identity` and
`kernelEvenExp_factor_bound`, both occur in the final proof's dependency closure.
Four superseded auxiliary declarations are removed: `sourceEquation_difference_identity`,
`abs_plantedEquationQuadratic_le`, `kernelEvenExp_cubic_bound`, and
`one_add_cos_eq_two_sin_sq_half_sub`. Thus this pass does not retain unused versions
of the replaced arguments. The main theorem names and original statement boundary
remain unchanged; the two intermediate bounds are strengthened as described above.

No shortcut eliminating the exact Haar-overlap density or global cone estimate
was established. Those are still substantive parts of the current proof.

## Final simplification pass

This pass removes a net **309 lines** from four existing source modules, with
no new library declarations or files (still 112 modules):

- [PhaseAbsolute](NLA/FR05/SmallBall/PhaseAbsolute.lean) proves the inverse-cosine
  modulus using the minimum principle for concave sine and mathlib's quadratic
  cosine bound. The square-root corollary now holds on the whole real line:
  projecting onto `[-1, 1]` leaves arccosine unchanged and cannot increase width.
  The band intervals therefore use `arccos (q ± h)` directly. Three private
  clamping definitions and their four supporting lemmas are removed.
- The same module derives the affine trigonometric normal form directly from
  the cosine addition formula and `Complex.norm_mul_cos_arg` /
  `Complex.norm_mul_sin_arg`. This removes three private lemmas for the former
  complex-exponential derivation, including its separate norm calculation.
  Zero amplitude still needs no exceptional case.
- [DerivativeNorm](NLA/FR05/Planted/DerivativeNorm.lean) uses mathlib's
  `PiLp.lipschitzWith_ofLp` for the sup-to-Euclidean norm comparison and a direct
  bounded-sum estimate for the dot product.
  [SourceMatrixPerturbation](NLA/FR05/Planted/SourceMatrixPerturbation.lean)
  uses the standard `PiLp.norm_eq_of_L2` formula for coordinate aggregation.
- [ImbalancePerturbation](NLA/FR05/Planted/ImbalancePerturbation.lean) instantiates
  the existing energy bound at the zero-imbalance row, and combines the existing
  nonnegative factors directly instead of repeating long multiplication estimates.

The only changed auxiliary interfaces are the strengthened, unrestricted
`arccos_gap_le_pi_sqrt` (its two range hypotheses are removed), and the
equivalent unclamped interval expression in
`cosineBandPhaseSublevel_subset_twoIntervals`. The phase probability bounds,
perturbation constants, and original FR-05 statements are unchanged. No larger
mathematical shortcut was established in this final pass.

The curated modules have module/theorem documentation and targeted regression
and linter checks. Run these with the complete proof build and axiom inspection:

```sh
bash verification/library-cleanup/check.sh
```

## Remaining library-quality work

1. Continue separating foundational definitions from planted-law application
   modules where doing so simplifies actual proof dependencies. Do not add
   unused general API merely for anticipated upstream use.
2. Continue replacing paper-stage names and incidental coordinate encodings
   with mathematical namespaces and standard structures where useful, while
   retaining the exact FR-05 statement boundary and source correspondence.
3. Finish import minimisation, documentation, and linter cleanup across the
   older modules. Their broad tactic imports, repeated section wrappers, and
   existing warnings have not all been removed by this pass.
4. Review potential upstream contributions individually. Mathlib acceptance,
   independent statement review, and the repository's isolated Linux verification
   are separate from the local Lean checks.
