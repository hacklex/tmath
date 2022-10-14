# TODO

Мы будем описывать формальные системы, а любая формальная система начинается с синтаксиса.
Синтаксис описывается с помощью грамматики.

Рассмотрим на примере. Пусть мы описываем синтаксис арифметических выражений:

- Числа (например, $1$, $-3$, $42$) это выражения
- Если ${\color{red} a}$ и ${\color{red} b}$ это выражения, то и ${\color{red} a} + {\color{red} b}$
это выражение
- Если ${\color{red} a}$ и ${\color{red} b}$ это выражения, то и ${\color{red} a} - {\color{red} b}$ это выражение
- Если ${\color{red} a}$ и ${\color{red} b}$ это выражения, то и ${\color{red} a} × {\color{red} b}$ это выражение
- Если ${\color{red} a}$ и ${\color{red} b}$ это выражения, то и ${\color{red} a} ÷ {\color{red} b}$
это выражение
- Если ${\color{red} e}$ это выражение, то и $({\color{red}e})$ это выражение

Такие последовательности символов соответствуют описанию:

- $-5 + 2×4$
- $(12 + 3)×(13 - 4)$
- $(((1)+((2))) ÷ 3)$

А такие — нет:

- $+9$
- $)4-7($
- $2 + (÷)$

Компактно, эта грамматика описывается следующим образом:

$$\begin{aligned}
{\color{red}expr} ::=\ &\textcolor{red}{num} & &\text{(число)} \\
\mid\quad &{\color{red}expr}\ {+}\ {\color{red}expr} & &\text{(сложение)} \\
\mid\quad &{\color{red}expr}\ {-}\ {\color{red}expr} & &\text{(вычитание)} \\
\mid\quad &{\color{red}expr}\ {×}\ {\color{red}expr} & &\text{(умножение)} \\
\mid\quad &{\color{red}expr}\ {÷}\ {\color{red}expr} & &\text{(деление)} \\
\mid\quad &{(}\, {\color{red}expr}\, ) & &\text{(скобки)} \\
\end{aligned}$$

Эту запись можно понимать двояко — как правила того, как строить синтаксически корректные выражения, или же как правила разбора выражения на состовляющие.

Если мы рассматриваем грамматику как правила порождения выражения, то мы подставляем на место ${\color{red}expr}$ одно из выражений в правой части грамматики, а на место ${\color{red}num}$ подставляем число. Повторяем до тех пор, когда в выражении больше не останется синтаксических переменных.

Например:

- ${\color{red}expr}$
- ${\color{red}expr} - {\color{red}expr}$
- ${\color{red}expr}÷{\color{red}expr} - {\color{red}num}$
- ${\color{red}num}÷{\color{red}num} - 1$
- $3÷2 - 1$

Если мы наоборот, рассматриваем грамматику как правила разбора выражения, то тогда мы сопоставляем
выражения с грамматикой, вводя новые синтаксические переменные:

- $3÷2 - 1$ это ${\color{red}a} - {\color{red}b}$, где ${\color{red}a}$ это $3÷2$, а ${\color{red}b}$ это $1$
    - $3÷2$ это ${\color{red}l} - {\color{red}r}$, где ${\color{red}l}$ это $3$, а ${\color{red}r}$ это $2$
        - $3$ — число
        - $2$ — число
    - $1$ — число

Разобранное выражение можно представить в виде диаграммы:

https://q.uiver.app/?q=WzAsNSxbMiwwLCJcXHRleHRjb2xvcntyZWR9XFxidWxsZXQgLSBcXHRleHRjb2xvcntyZWR9XFxidWxsZXQiXSxbMSwxLCJ7XFxjb2xvcntyZWR9XFxidWxsZXR9IMO3IHtcXGNvbG9ye3JlZH1cXGJ1bGxldH0iXSxbMywxLCIxIl0sWzAsMiwiMyJdLFsyLDIsIjIiXSxbMCwxXSxbMCwyXSxbMSwzXSxbMSw0XV0=

Это *синтаксическое дерево*.

Но грамматика не исключает возможности разобрать выражение иначе:

https://q.uiver.app/?q=WzAsNSxbMiwxLCJcXHRleHRjb2xvcntyZWR9XFxidWxsZXQgLSBcXHRleHRjb2xvcntyZWR9XFxidWxsZXQiXSxbMSwwLCJ7XFxjb2xvcntyZWR9XFxidWxsZXR9IMO3IHtcXGNvbG9ye3JlZH1cXGJ1bGxldH0iXSxbMywyLCIxIl0sWzAsMSwiMyJdLFsxLDIsIjIiXSxbMCwyXSxbMSwzXSxbMSwwXSxbMCw0XV0=

Говорят, что такая грамматика *неоднозначна.*

ТУДУ: приоритет

$$\textcolor{grey}{\big(}\textcolor{grey}(3÷2\textcolor{grey}) - 1\textcolor{grey}{\big)}$$

$$\begin{aligned}
{\color{red}expr} ::=\ &\textcolor{red}{num} & &\text{(число)} \\
\mid\quad &{\color{red}var} & &\text{(переменная)} \\
\mid\quad &{\color{red}expr}\ {+}\ {\color{red}expr} & &\text{(сложение)} \\
\mid\quad &{\color{red}expr}\ {-}\ {\color{red}expr} & &\text{(вычитание)} \\
\mid\quad &{\color{red}expr}\ {×}\ {\color{red}expr} & &\text{(умножение)} \\
\mid\quad &{\color{red}expr}\ {÷}\ {\color{red}expr} & &\text{(деление)} \\
\end{aligned}$$

$2×(x-1) + y$

${\color{red}x} + {\color{red}y}$, где ${\color{red}x}$ это $2×(x-1)$, а ${\color{red}y}$ это $y$.
