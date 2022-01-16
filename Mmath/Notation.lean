import Lean

class Mem (α : outParam (Type u)) (γ : Type v) where
  mem : α → γ → Prop

class Subset (α : Type u) where
  subset : α → α → Prop

class Union (α : Type u) where
  union : α → α → α

class Inter (α : Type u) where
  inter : α → α → α

class Sdiff (α : Type u) where
  sdiff : α → α → α

infix:50  " ∈ "  => Mem.mem
infix:50  " ⊆ "  => Subset.subset
infixl:65 " ∪ "  => Union.union
infixl:70 " ∩ "  => Inter.inter
infix:70  " \\ " => Sdiff.sdiff

notation:50 x " ∉ " s => ¬ x ∈ s

open Lean

/-!
Defines an extended binder syntax supporting `∀ ε > 0, ...` etc.
-/

namespace Mmath.ExtendedBinder

/-
The syntax category of binder predicates contains predicates like `> 0`, `∈ s`, etc.
(`: t` should not be a binder predicate because it would clash with the built-in syntax for ∀/∃.)
-/
declare_syntax_cat binderPred

/--
`satisfiesBinderPred% t pred` expands to a proposition expressing that `t` satisfies `pred`.
-/
syntax "satisfiesBinderPred% " term:max binderPred : term

-- Extend ∀ and ∃ to binder predicates.

syntax "∃ " binderIdent binderPred ", " term : term
syntax "∀ " binderIdent binderPred ", " term : term

macro_rules
  | `(∃ $x:ident $pred:binderPred, $p) =>
    `(∃ $x:ident, satisfiesBinderPred% $x $pred ∧ $p)
  | `(∃ _ $pred:binderPred, $p) =>
    `(∃ x, satisfiesBinderPred% x $pred ∧ $p)

macro_rules
  | `(∀ $x:ident $pred:binderPred, $p) =>
    `(∀ $x:ident, satisfiesBinderPred% $x $pred → $p)
  | `(∀ _ $pred:binderPred, $p) =>
    `(∀ x, satisfiesBinderPred% x $pred → $p)

-- We also provide special versions of ∀/∃ that take a list of extended binders.
-- The built-in binders are not reused because that results in overloaded syntax.

syntax extBinder := binderIdent ((" : " term) <|> binderPred)?
syntax extBinderParenthesized := " (" extBinder ")" -- TODO: inlining this definition breaks
syntax extBinderCollection := extBinderParenthesized*
syntax extBinders := extBinder <|> extBinderCollection

syntax "∃ᵉ " extBinders ", " term : term
macro_rules
  | `(∃ᵉ, $b) => b
  | `(∃ᵉ ($p:extBinder) $[($ps:extBinder)]*, $b) =>
    `(∃ᵉ $p:extBinder, ∃ᵉ $[($ps:extBinder)]*, $b)
macro_rules -- TODO: merging the two macro_rules breaks expansion
  | `(∃ᵉ $x:binderIdent, $b) => `(∃ $x:binderIdent, $b)
  | `(∃ᵉ $x:binderIdent : $ty:term, $b) => `(∃ $x:binderIdent : $ty:term, $b)
  | `(∃ᵉ $x:binderIdent $p:binderPred, $b) => `(∃ $x:binderIdent $p:binderPred, $b)

syntax "∀ᵉ " extBinders ", " term : term
macro_rules
  | `(∀ᵉ, $b) => b
  | `(∀ᵉ ($p:extBinder) $[($ps:extBinder)]*, $b) =>
    `(∀ᵉ $p:extBinder, ∀ᵉ $[($ps:extBinder)]*, $b)
macro_rules -- TODO: merging the two macro_rules breaks expansion
  | `(∀ᵉ _, $b) => `(∀ _, $b)
  | `(∀ᵉ $x:ident, $b) => `(∀ $x:ident, $b)
  | `(∀ᵉ _ : $ty:term, $b) => `(∀ _ : $ty:term, $b)
  | `(∀ᵉ $x:ident : $ty:term, $b) => `(∀ $x:ident : $ty:term, $b)
  | `(∀ᵉ $x:binderIdent $p:binderPred, $b) => `(∀ $x:binderIdent $p:binderPred, $b)

open Parser.Command in
/--
Declares a binder predicate.  For example:
```
binder_predicate x " > " y:term => `($x > $y)
```
-/
syntax (docComment)? (attrKind)? "binder_predicate " optNamedName optNamedPrio ident macroArg* " => " term : command

-- adapted from the macro macro
open Elab Command in
macro_rules
  | `($[$doc?:docComment]? $attrKind:attrKind binder_predicate%$tk $[(name := $name?)]? $[(priority := $prio?)]? $x $args:macroArg* => $rhs) => do
    let prio  ← evalOptPrio prio?
    let (stxParts, patArgs) := (← args.mapM expandMacroArg).unzip
    let name ← match name? with
      | some name => pure name.getId
      | none => mkNameFromParserSyntax `binderTerm (mkNullNode stxParts)
    /- The command `syntax [<kind>] ...` adds the current namespace to the syntax node kind.
      So, we must include current namespace when we create a pattern for the following `macro_rules` commands. -/
    let pat := mkNode ((← Macro.getCurrNamespace) ++ name) patArgs
    `($[$doc?:docComment]? $attrKind:attrKind syntax%$tk (name := $(← mkIdentFromRef name)) (priority := $(quote prio)) $[$stxParts]* : binderPred
      $[$doc?:docComment]? macro_rules%$tk | `(satisfiesBinderPred% $$($x):term $pat:binderPred) => $rhs)


binder_predicate x " > " y:term => `($x > $y)
binder_predicate x " ≥ " y:term => `($x ≥ $y)
binder_predicate x " < " y:term => `($x < $y)
binder_predicate x " ≤ " y:term => `($x ≤ $y)
