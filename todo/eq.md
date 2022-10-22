# Равенство

Два различных представления одного и того же *вещественного* числа.

$$0.999\ldots = 1$$

Карта не есть территория.

1. Равные вещи неразличимы
2. Неразличимые вещи неотличимы от равных

$$\begin{aligned}
rfl &: ∀\{x:τ\}.\; x = x \\
ndrec &: ∀\{x:α\}\{M: α → \mathcal U\ i\}.\; M\ x → \{y: α\} → (x = y) → M\ y
\end{aligned}$$

```lean
inductive Eq : α → α → Prop where
  | refl (a : α) : Eq a a
```

```
Eq.rec: {a: α} → {M: (b: α) → a = b → Sort u} →
  M a (_: a = a) → {b: α} → (e: a = b) → M b e
```

```lean
def BoolEq (a: Bool)(b: Bool): Prop :=
  a.rec (b.rec True False) (b.rec False True)

def bool_d: ∀b:Bool, BoolEq b b := Bool.rec ⟨⟩ ⟨⟩

theorem false_ne_true (h: false = true): False :=
   Eq.ndrec (bool_d false) h
```


```lean
example (P Q: Type)(pq: P ⊕ Q): Prop := pq.rec (λ_ => False) (λ_ => True)
```

```lean
example (P Q: Prop)(pq: P ∨ Q): Prop := pq.rec (λ_ => False) (λ_ => True)
```

$$∀(P:Prop)(x: P)(y:P).\; x = y$$

```lean
#check Subtype

def fls (_:Bool): Nat := false

#check
  let I := {b:Bool // ∃n, fls n = b}
  let z:I := ⟨false, ⟨0, rfl⟩⟩
  let s:I := ⟨false, ⟨1, rfl⟩⟩
  (rfl : z = s)
```

```lean
example: (∀a, α → α) → (∀α:Prop, α → α) :=
  λx => x (∀α, α → α) x
```
