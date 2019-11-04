parent(ion, maria).
parent(ana, maria).
parent(ana, dan).
parent(maria, elena).
parent(maria, radu).
parent(elena, nicu).
parent(radu, george).
parent(radu, dragos).
child(X, Y):- parent(Y, X).
grandparent(X, Z) :- parent(X, Y) , parent(Y, Z).
brother(X, Y):- parent(Z, X), parent(Z, Y), X \== Y.
predecessor(X, Y):- parent(X, Y).
predecessor(X, Z):- parent(X, Y), predecessor(Y, Z).

maximum(X,Y,Y):- X =< Y,!.
maximum(X,Y,X):- X>Y.

member_of(X, [X|_]).
member_of(X, [_|T]):- member_of(X, T).

concat([], L2, L2).
concat([E|L1], L2, [E|C]):-concat(L1, L2, C).

sum_alt([X],X).
sum_alt([A,B|L], X):- sum_alt([A+B|L], S), X is S.

elim_first(X, [X|T], T).

elim_one(X,L,R) :- concat(L1,[X|L2],L), concat(L1,L2,R).

elim_all(_, [], []).
elim_all(X, [X|T], L):- elim_all(X, T, L), !.
elim_all(X, [H|T], [H|L]):- elim_all(X, T, L).

reverse_list([], R, R).
reverse_list([H|T], R, A):- reverse_list(T, R, [H|A]).

permutation([], []).
permutation([X], [X]) :-!.
permutation([T|H], X) :- permutation(H, H1), concat(L1, L2, H1), concat(L1, [T], X1), concat(X1, L2, X).

num_occurences(_, [], 0).
num_occurences(X, [X|T], R):- !, num_occurences(X, T, S), R is S + 1.
num_occurences(X, [_|T], Z):- num_occurences(X, T, Z).