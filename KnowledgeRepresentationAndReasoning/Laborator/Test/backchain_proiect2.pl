sol(RESULT):-
	open('kb2.txt', read, Stream),
	read(Stream, KB),
    close(Stream),
    write(KB),nl,

    qone(X),
    write(X),nl,    
    append(KB,[[X]],KB1),
    write(KB1),nl,

    qtwo(X2),
    write(X2),nl,    
    append(KB1,[[X2]],KB2),
    write(KB2),nl,

    
    qthree(X3),
    write(X3),nl,    
    append(KB2,[[X3]],KB3),
    write(KB3),nl,nl,

    write(" =====  START ALGORITHM ==== "),nl,nl,
%    backchain(KB3,questions,RESULT),
    backchain(KB3,[pneumonia],RESULT),
%    forwardchain(KB3,[pneumonia],RESULT),
    write("Result"),write(RESULT),nl,
    write("Done!").


forwardchain(KB,[],RESULT):-
    write("NO GOALS TO SOLVE ANYMORE"),nl,
    RESULT = 'YES',!.

forwardchain(KB,NOTSOLVED,RESULT):-
    write("Forwardchain: with not solved"),write(NOTSOLVED),nl, 

    write("FINISH FW").

backchain(KB,[],RESULT):-
    write("Enter on empty set"),nl,
    RESULT='YES',!.

backchain(KB,Q,RESULT):-
    nl,write("Solving with goals "), write(Q),write(' on '),nl,write(KB),nl,
    [Q1|T]=Q,
    write("Q1: "), write(Q1),nl,
    write("T: "), write(T),nl,
    member(C, KB),
    write("each clause from KB:"),write(C),nl,
    member(Q1,C),
    write("C is"),write(C),nl,    
    remove_negation(C,C_TEMP),
    write("Removed negations: "),write(C_TEMP),nl,
    delete(C_TEMP, [], NEWC),
    write("Removed negations without empty list: "),write(NEWC),nl,
    append(NEWC,T,NEWGOALS),
    write("new goals: "), write(NEWGOALS),nl,
    backchain(KB,NEWGOALS,RESULT),
    write("Result of backchain"),write(RESULT),nl,
    RESULT=='YES',!,    
    %write("Finish with NO"),
    nl.

backchain(_,_,RESULT):-
    RESULT='NO'.


qone(T):-
    T=morethantemp38.

qtwo(T):-
    T=sickleast2days.

qthree(T):-
    T=cough.


test1(RESULT):- backchain([],[],RESULT).

remove_negation([], []).
remove_negation([n(A)|T], [A|Literals]) :- !, remove_negation(T, Literals).
remove_negation([A|T], [Literals]) :- !, remove_negation(T, Literals).