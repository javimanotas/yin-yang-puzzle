1 { at(X, Y, white); at(X, Y, black) } 1 :- unknown(X, Y).


:- at(X, Y, C), at(X, Y + 1, C), at(X + 1, Y, C), at(X + 1, Y + 1, C).


reach(X, Y, X, Y) :- at(X, Y, _).
reach(X, Y, X + 1, Y) :- at(X, Y, C), at(X + 1, Y, C).
reach(X, Y, X - 1, Y) :- at(X, Y, C), at(X - 1, Y, C).
reach(X, Y, X, Y + 1) :- at(X, Y, C), at(X, Y + 1, C).
reach(X, Y, X, Y - 1) :- at(X, Y, C), at(X, Y - 1, C).
reach(X, Y, X'', Y'') :- reach(X, Y, X', Y'), reach(X', Y', X'', Y'').
:- at(X, Y, C), at(X', Y', C), not reach(X, Y, X', Y').


% translate predicates to the drawyinyang.lp ones
_drawcircle(X, Y, C) :- at(X, Y, C).
gridsize(N + 1) :- N = #max { X : at(X, _, _) }.
