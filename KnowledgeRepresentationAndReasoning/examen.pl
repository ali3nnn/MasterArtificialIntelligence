% problema 1
% a

alpinist(tony).
alpinist(mike).
alpinist(john).

climber(X) :- alpinist(X), nskier(X).
skier(X) :- alpinist(X), not(climber(X)).

nlike(X,rain) :- climber(X).
nskier(X) :- nlike(X,snow).

like(mike,X) :- nlike(tony,X).
nlike(mike,X) :- like(tony,X).

like(tony,rain).
like(tony,snow).



%b

% lets check if mike is climber
% if mike is climber then he is alplinist && not skier
% mike is an alpinist and check if not skier return true
% if mike is not skier then it doesnt like snow
% nlike mike snow este true if tony like snow
% and tony like snow
% so the first asses is true (mike is climber)
% and if mike is climber then is not a skier

% problema 2

gcd(X, 0, X):- !.
gcd(0, X, X):- !.

gcd(X, Y, D):- X =< Y, !, Z is Y - X, gcd(X, Z, D).
gcd(X, Y, D):- gcd(Y, X, D).

% gcd()

% problema 3

