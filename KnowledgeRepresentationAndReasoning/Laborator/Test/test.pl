start :-
    output_problems,
    read_input.

output_problems :-
    forall(problem(P),
    writeln(P)).

read_input :-
    repeat,
    read_string(user_input, "\n", "\r\t ", _, Line),
    process_input(Line).

process_input(Line) :-
    string(Line),
    atom_number(Line, N),
    integer(N),
    do_something_with(Line),
    fail.
process_input("quit") :-
    write('Finished'), nl,
    !, true.

do_something_with(X) :-
    writeln(X).

problem('1').
problem('2').
problem('3').
problem('4').
problem('5').
problem('6').
problem('7').
problem('8').
problem('9').
problem('10').
