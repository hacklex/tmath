# Лямбда исчисление как язык программирования

Если $f: α → β$, и $x: α$, то $f\ x : β$.

$$Bool := \left[\begin{array}{rcl}
false &:& Bool\\
true &:& Bool\\
\end{array}\right]$$

$$\begin{aligned}
&\{false ↦ a,\ true ↦ b\}\ false &⟶ a \\
&\{false ↦ a,\ true ↦ b\}\ true &⟶ b
\end{aligned}$$

$$Pair := \left[\begin{array}{rcl} p &:& α → β → Pair\ α\ β \end{array}\right]$$

$$fst := \{p\ x\ y ↦ x\}$$

$$Nat := \left[\begin{array}{rcl}
z &:& Nat\\
s &:& Nat → Nat\\
\end{array}\right]$$


$$λx. x\ x$$

$x : α$, то $x: α → β$

$x : α → β$, то $x: α → (α → β)$

$$n + k := \begin{cases}
n &\text{если } k=0 \\
n+p &\text{если } k=s(p)
\end{cases}$$

$$add := λk.\; k\ n\ (λp.\;add\ n\ p)$$
$$(λf.\;λk.\; k\ n\ (λp.\;f\ n\ p))\ add$$

$$y \stackrel*⟶ f\ y$$

$$(λx.\;x\ x)\ (λx.\;x\ x) ⟶ (λx.\;x\ x)\ (λx.\;x\ x)$$
$$(λx.\;f\ x\ x)\ (λx.\;f\ x\ x) ⟶ f\ (λx.\;f\ x\ x)\ (λx.\;f\ x\ x)$$
$$Y := λf.\;(λx.\;f\ x\ x)\ (λx.\;f\ x\ x)$$
