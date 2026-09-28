import NLA.Statements.KernelSmoke
import NLA.Statements.MD03
import Reviewed.MD03
import NLA.Statements.MD04
import Reviewed.MD04
import NLA.Statements.PF04
import Reviewed.PF04
import NLA.Statements.SP11
import Reviewed.SP11
import NLA.Statements.SP12
import Reviewed.SP12
import NLA.Statements.TR14
import Reviewed.TR14

/- Generated identity certificates only; no catalog proposition is asserted. -/
namespace NLA.Statements.ComparatorControl
theorem log_two_upper : Real.log 2 < (7 / 10 : ℝ) :=
  NLA.Statements.KernelSmoke.log_two_upper
theorem identity_MD03 : NLA.Statements.MD03.Target = NLA.ReviewedStatements.MD03.Target := by rfl
theorem identity_MD04 : NLA.Statements.MD04.Target = NLA.ReviewedStatements.MD04.Target := by rfl
theorem identity_PF04 : NLA.Statements.PF04.Target = NLA.ReviewedStatements.PF04.Target := by rfl
theorem identity_SP11 : NLA.Statements.SP11.Target = NLA.ReviewedStatements.SP11.Target := by rfl
theorem identity_SP12 : NLA.Statements.SP12.Target = NLA.ReviewedStatements.SP12.Target := by rfl
theorem identity_TR14 : NLA.Statements.TR14.Target = NLA.ReviewedStatements.TR14.Target := by rfl
#assert_trust kernel NLA.Statements.ComparatorControl.log_two_upper
#assert_trust kernel NLA.Statements.ComparatorControl.identity_MD03
#assert_trust kernel NLA.Statements.ComparatorControl.identity_MD04
#assert_trust kernel NLA.Statements.ComparatorControl.identity_PF04
#assert_trust kernel NLA.Statements.ComparatorControl.identity_SP11
#assert_trust kernel NLA.Statements.ComparatorControl.identity_SP12
#assert_trust kernel NLA.Statements.ComparatorControl.identity_TR14
#print axioms NLA.Statements.ComparatorControl.log_two_upper
#print axioms NLA.Statements.ComparatorControl.identity_MD03
#print axioms NLA.Statements.ComparatorControl.identity_MD04
#print axioms NLA.Statements.ComparatorControl.identity_PF04
#print axioms NLA.Statements.ComparatorControl.identity_SP11
#print axioms NLA.Statements.ComparatorControl.identity_SP12
#print axioms NLA.Statements.ComparatorControl.identity_TR14
end NLA.Statements.ComparatorControl
