1 { at(X, Y, white); at(X, Y, black) } 1 :- unknown(X, Y).


:- at(X, Y, C), at(X, Y + 1, C), at(X + 1, Y, C), at(X + 1, Y + 1, C).
:- at(X, Y, C), at(X, Y + 1, C'), at(X + 1, Y, C'), at(X + 1, Y + 1, C), C != C'.


adjacent(X, Y, X + 1, Y) :- at(X, Y, C), at(X + 1, Y, C).
adjacent(X, Y, X, Y + 1) :- at(X, Y, C), at(X, Y + 1, C).
adjacent(X, Y, X - 1, Y) :- at(X, Y, C), at(X - 1, Y, C).
adjacent(X, Y, X, Y - 1) :- at(X, Y, C), at(X, Y - 1, C).

rep(X, Y, C) :- at(X, Y, C), not at(X', Y', C) : at(X', Y', C), (X', Y') < (X, Y).

reach(X, Y, X, Y, C) :- rep(X, Y, C).
reach(X, Y, X'', Y'', C) :- reach(X, Y, X', Y', C), adjacent(X', Y', X'', Y'').
:- at(X, Y, C), rep(X', Y', C), not reach(X', Y', X, Y, C).


edge(X, 0) :- at(X, 0, _).
edge(0, Y) :- at(0, Y, _).
edge(X, Y) :- at(X, Y, _), gridsize(X + 1).
edge(X, Y) :- at(X, Y, _), gridsize(Y + 1).

next_edge(X, 0, X + 1, 0) :- edge(X, 0), edge(X + 1, 0).
next_edge(X, Y, X, Y + 1) :- edge(X, Y), edge(X, Y + 1), gridsize(X + 1).
next_edge(X, Y, X - 1, Y) :- edge(X, Y), edge(X - 1, Y), gridsize(Y + 1).
next_edge(0, Y, 0, Y - 1) :- edge(0, Y), edge(0, Y - 1).

edge_change(X, Y) :- next_edge(X, Y, X', Y'), at(X, Y, C), at(X', Y', C'), C != C'.
:- N = #count { (X, Y) : edge_change(X, Y) }, N > 2.

% translate predicates to the drawyinyang.lp ones
_drawcircle(X, Y, C) :- at(X, Y, C).
gridsize(N + 1) :- N = #max { X : at(X, _, _) }.
