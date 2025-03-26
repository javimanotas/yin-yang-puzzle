1 { at(X, Y, white); at(X, Y, black) } 1 :- unknown(X, Y).


% Ensure a there is not a 2x2 of cells of the same color
:- at(X, Y, C), at(X, Y + 1, C), at(X + 1, Y, C), at(X + 1, Y + 1, C).

% Ensure there is not a 2x2 cross of cells of opposite colors
% https://www.youtube.com/watch?v=LbrDK7U_-rQ&list=PLH_elo2OIwaB2dTft3TEv2l8ofR065i9b
:- at(X, Y, C), at(X, Y + 1, C'), at(X + 1, Y, C'), at(X + 1, Y + 1, C), C != C'.


adjacent(X, Y, X + 1, Y) :- at(X, Y, C), at(X + 1, Y, C).
adjacent(X, Y, X, Y + 1) :- at(X, Y, C), at(X, Y + 1, C).
adjacent(X, Y, X - 1, Y) :- at(X, Y, C), at(X - 1, Y, C).
adjacent(X, Y, X, Y - 1) :- at(X, Y, C), at(X, Y - 1, C).

% The minimum lexicographic of each color is chosen as the representative
rep(X, Y, C) :- at(X, Y, C), not at(X', Y', C) : at(X', Y', C), (X', Y') < (X, Y).

reach(X, Y, X, Y, C) :- rep(X, Y, C).
reach(X, Y, X'', Y'', C) :- reach(X, Y, X', Y', C), adjacent(X', Y', X'', Y'').
:- at(X, Y, C), rep(X', Y', C), not reach(X', Y', X, Y, C).


edge(X, 0) :- at(X, 0, _).
edge(0, Y) :- at(0, Y, _).
edge(X, Y) :- at(X, Y, _), gridsize(X + 1).
edge(X, Y) :- at(X, Y, _), gridsize(Y + 1).

% this predicates form a loop in counter-clockwise order
next_edge(X, 0, X + 1, 0) :- edge(X, 0), edge(X + 1, 0).
next_edge(X, Y, X, Y + 1) :- edge(X, Y), edge(X, Y + 1), gridsize(X + 1).
next_edge(X, Y, X - 1, Y) :- edge(X, Y), edge(X - 1, Y), gridsize(Y + 1).
next_edge(0, Y, 0, Y - 1) :- edge(0, Y), edge(0, Y - 1).

% To ensure edege connectivity (https://www.youtube.com/watch?v=LbrDK7U_-rQ&list=PLH_elo2OIwaB2dTft3TEv2l8ofR065i9b)
% we count how many times the color changes when  'walking' though the edge.
% Since no more than 1 group of each color is allowed it's impossible to find more than 2 color changes.
edge_change(X, Y) :- next_edge(X, Y, X', Y'), at(X, Y, C), at(X', Y', C'), C != C'.
:- N = #count { (X, Y) : edge_change(X, Y) }, N > 2.

% translate predicates to the drawyinyang.lp ones
_drawcircle(X, Y, C) :- at(X, Y, C).
gridsize(N + 1) :- N = #max { X : at(X, _, _) }.
