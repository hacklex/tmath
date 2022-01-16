import Mmath.Notation

#eval 2+2
#check Sigma
#check Σ'x, x > 3
#check [1, 2, 3]
#check (_ ∘ _)
#check Function.comp

#check HasEquiv
#check Fin

infixr:90 "⍤" => λf g => g∘f

-- Карта и территория

#check propext
#check funext

-- Натуральные числа

#check Add
#check Mul

#check congr
#check Eq.subst

#check {x // x > 3}
#check Subtype.eta

#check Exists
#check Fin

-- Фактор-типы и целые числа

-- Рациональные и вещественные числа

-- Множества и зависимые пары

def Set (α: Type u) := α → Prop

namespace Set

protected def mem (a: α) (s: Set α) :=  s a
instance : Mem α (Set α)            :=  ⟨Set.mem⟩

protected def subset (s t: Set α) :=  ∀{x}, s x → t x
instance : Subset (Set α)         :=  ⟨Set.subset⟩

def univ : Set α                   :=  λx => true
instance : EmptyCollection (Set α) :=  ⟨λx => False⟩

protected def singleton (a: α)   : Set α :=  λx => x = a

protected def union (s t: Set α) : Set α :=  λx => s x ∨ t x
protected def inter (s t: Set α) : Set α :=  λx => s x ∧ t x

instance : Union (Set α) := ⟨Set.union⟩
instance : Inter (Set α) := ⟨Set.inter⟩

protected def insert (a: α)(s: Set α) : Set α := λx => x = a ∨ s x

def image (f: α → β)(s: Set α) : Set β := λy => ∃x, s x ∧ f x = y

end Set

-- Функции

namespace Function

def retraction   (f: α → ω)(g: ω → α) : Prop :=  ∀x, g (f x) = x
def coretraction (f: ω → α)(g: α → ω) : Prop :=  retraction g f

def inverse (f: α → ω)(g: ω → α) : Prop :=  retraction f g ∧ retraction g f

def injective  (f: α → ω) : Prop :=  ∀x y, f x = f y → x = y
def surjective (f: α → ω) : Prop :=  ∀y, ∃x, f x = y
def bijective  (f: α → ω) : Prop :=  injective f ∧ surjective f

theorem has_retr_injective (f: α → ω)(er: ∃g, retraction f g) : injective f :=
by
  let ⟨g, r⟩ := er;  intro x y;  intro(e: f x = f y);  show x = y
  have e2: g (f x) = g (f y) := congrArg g e
  rw[r x, r y] at e2;  exact e2

theorem has_coretr_surjective (f: ω → α)(ec: ∃g, coretraction f g) : surjective f :=
by
  let ⟨g, h⟩ := ec;  intro y;  show ∃x, f x = y
  exists g y;  rw[h y]

-- theorem inj_has_retraction (f: α → ω)(ij: injective f) : ∃g, retraction f g :=
-- by sorry

-- theorem surj_has_coretraction (f: α → ω)(sj: surjective f) : ∃g, coretraction f g :=
-- by sorry

theorem lawvere_fixpoint (f: α → (α → ω))(sj: surjective f): ∀n: ω → ω, ∃x, n x = x :=
by
  intro n
  let d := λx => n (f x x);  let ⟨c, fp⟩ := sj d;  exists d c
  apply Eq.symm;  calc
    d c = n (f c c) := rfl
      _ = n (d c)   := by rw[fp]

end Function

-- Отношения
