#!/usr/bin/swipl

:-style_check(-singleton).

delete(E,[E|T],T).
delete(E,[H|T],[H|T1]) :-
  delete(E,T,T1).

p([H|T], H, T).

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream,L).


memberlist(X,[[X|_]|_]).
memberlist(X,[[H|T1]|T2]) :-
    memberlist(X,[T1|T2]).
memberlist(X,[[]|T2]) :-
    memberlist(X,T2).

test(Text) :-
  ( Text == 'stop' ->
    halt;
    nl).

% process(Var) :-
%
%
% dosomething([]).
% dosomething([H|T]) :- process(H), dosomething(T).

% list_to_conj([writeln(hello), writeln(world)], Variable).
list_to_conj([H], H) :- !.
list_to_conj([H | T], ','(H, Conj)) :-
    list_to_conj(T, Conj).
% call(Variable).

fever(X) :- temp(X).
infection(X) :- fever(X), sick(X).
pneumonia(X) :- cough(X), infection(X).

cough(Alex).
temp(Alex).
sick(Alex).


kb2 :-
    open('kb2.txt', read, Str),
    read_file(Str,Lines),
    close(Str),
    p(Lines,List,EndOfFile),
    write(List), nl,
    list_to_conj(List,V), call(V).

kb :-
    open('kb.txt', read, Str),
    read_file(Str,Lines),
    close(Str),
    p(Lines,List,EndOfFile),
    % delete(end_of_file, Lines, List),
    write(List), nl,
    ask_temp(List).

ask_temp(List0) :-
  repeat,
  writeln('What is the temperature?'),
  read(LineAnswer),
  test(LineAnswer),
  ( LineAnswer > 38 ->
    append(List0,[[temp]],List1),
    writeln(List1),
    ask_infection(List1,List2);
    append(List0,[[n(temp)]],List1),
    writeln(List1),
    ask_infection(List1,List2) ).

ask_infection(List1,List2) :-
  repeat,
  writeln('How many days he was sick?'),
  read(LineAnswer2),
  test(LineAnswer),
  ( LineAnswer2 > 1 ->
    append(List1,[[sick]],List2),
    writeln(List2),
    ask_cough(List2,List3) ;
    append(List1,[[n(sick)]],List2),
    writeln(List2),
    ask_cough(List2,List3) ).

ask_cough(List2, List3) :-
  repeat,
  writeln('The patient has cough?'),
  read(LineAnswer3),
  test(LineAnswer),
  ( LineAnswer3 == 'yes' ->
    append(List2,[[cough]],List3),
    writeln(List3);
    append(List2,[[n(cough)]],List3),
    writeln(List3) ).

backchain(KB,Goals,RESULT):-
  length(Goals,X),
  (X == 0 ->
    writeln("There is no goal");
    dosomething(KB)).


% alex