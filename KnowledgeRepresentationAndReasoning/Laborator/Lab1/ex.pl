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

# Write the max predicate that calculates the maximum between two values
gt(X,Y,Z):- Z is max(X,Y).
