# Warm Up

parent(ion,maria).
parent(ana,maria).
parent(ana,dan).
parent(maria,elena).
parent(maria,radu).
parent(elena,nicu).
parent(radu,george).
parent(radu,dragos).
child(X,Y):-parent(Y,X).
pred(X,Y):-parent(X,Y).
pred(X,Z):-parent(X,Y), pred(Y,Z).

f(X,0):-X=<3.
f(X,2):-3<X, X=<6.
f(X,4):-6<X.

%problema1
gt(X,Y,Z):- Z is max(X,Y).

maximum(X,Y,Y):- X =< Y,!.
maximum(X,Y,X):- X>Y.

maximCalc(X,Y,R):-(X>=Y-> R=X; R=Y).

%problema2
member_of(X, [X|_]).
member_of(X, [_|Z]):- member_of(X, Z).

member(X,[X]).
member(X,[X|T]).
member(X,[H|T]):-X\==H,member(X, T).

concat([], L2, L2).
concat([E|L1], L2, [E|C]):-concat(L1, L2, C).

concat2(X,[],X).
concat2(Y,[H|T],X):-concat2([H|Y],T,X).

%problema3


%problema4


%problema5
%problema6
%problema7
