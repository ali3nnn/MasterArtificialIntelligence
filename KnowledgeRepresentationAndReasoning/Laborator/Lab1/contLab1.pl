%max between 2 values
%maximCalc(X,Y,R).
maximCalc(X,Y,R):-(X>=Y-> R=X; R=Y).

%member and concat predicates
member(X,[X]).
member(X,[X|T]).
member(X,[H|T]):-X\==H,member(X, T).

concat(X,[],X).
concat(Y,[H|T],X):-concat([H|Y],T,X).

%alternative sum of the elements of a list
flowers(green,3).
flowers(roses,5).
flowers(tulips,6).

numberflowers(L):-findall(Number,flowers(Name,Number),L).
sumfl(S):-numberflowers(L),sumflowers(L,S).
sumflowers([],0).
sumflowers([H|T],S):-sumflowers(T,Rez), S is Rez+H.

%sumflowers([H|T],S+H):-sumflowers(T,S).
%dar S este 0+3+5+6

elim(X,[X|T],T).
elim(X,[H|T],[H|Y]):-elim(X,T,Y).

%reverse a list

reverse_list([],Rez,Rez).
reverse_list([H|T],Tail,Rez):-reverse_list(T,[H|Tail],Rez).

%number of occurences of an elem in a list

nr_occ(X,[],0).
nr_occ(X,[X],1).
nr_occ(X,[H|T],Nr):-X\==H,nr_occ(X,T,Nr).
nr_occ(X,[H|T],Nr):-nr_occ(X,T,Nr1), Nr is Nr1+1.


%insert an element in a certain position in a list

mysplit(L, [], L, 0).
mysplit([H|T], FP, R, L) :- Ln is L - 1, append([H], SubFP, FP), mysplit(T, SubFP, R, Ln).
insert_at(L, R, E, N) :- Nn is N - 1, mysplit(L, F, S, Nn), append(F, [E], SubR), append(SubR, S, R).

%merge two ascending ordered lists
mergelist([],[],[]).
mergelist([X],[],[X]).
mergelist([],[Y],[Y]).
mergelist([X|List1],[Y|List2],[X|List]) :-X=<Y,!,mergelist(List1,[Y|List2],List).
mergelist([X|List1],[Y|List2],[Y|List]) :-mergelist([X|List1],List2,List).