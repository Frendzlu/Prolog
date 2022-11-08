:- encoding(utf8).
:- op(600, xfy, [⊂]).
:- op(600, xfy, [⊄]).

⊂(A, B) :-
    diff(A, B, X),
    X = [].

del(_, [], []).
del(El, [El|T], Out) :- del(El, T, Out).
del(El, [NotEl|T], [NotEl|Out]) :- \+ El = NotEl, del(El, T, Out).


diff(A, [], A).
diff(A, [H|B], X) :-
    del(H, A, Out),
    diff(Out, B, X).

readChar('\n', []) :- !.
readChar(Ch, [Ch|L]):- get_char(Ch2), readChar(Ch2, L).

mEcho :-
    get_char(Ch),
    readChar(Ch, L),
    atom_chars(W, L),
    writeln(W).
    
isNumber(N):-
    [N] ⊂ [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].

readNum('\n', [], 0):- !.
readNum(Ch, [Ch|L], I):-
    write(Ch), write(' '), writeln(L),
    isNumber(Ch),
    get_char(Ch2),
    readNum(Ch2, L, J),
    I is J+1.
readNum(L1, L2, J):-
    \+ isNumber(L1),
    get_char(Ch),
    readNum(Ch, L2, J).

mNum:- 
    get_char(Ch),
    readNum(Ch, L, I),
    writeln(L),
    atom_chars(W, L),
    writeln(W), 
    writeln('Liczba cyfr: '), writeln(I).

findUpperCase([H1|L1], [H2|L2], Goal, H2) :-
    H1 == Goal.
findUpperCase([H1|L1], [H2|L2], Goal, Result) :-
    \+ H1 == Goal,
    findUpperCase(L1, L2, Goal, Result).

uppercase(A, B) :-
    atom_chars(qabcdefghijklmnoprstuwxyzęóąśłżźćń, LowerList),
    atom_chars(qABCDEFGHIJKLMNOPRSTUWXYZĘÓĄŚŁŻŹĆŃ, UpperList),
    [A] ⊂ LowerList,
    \+ [A] ⊂ [q],
    findUpperCase(LowerList, UpperList, A, B).
uppercase(A, A) :-
    atom_chars(qabcdefghijklmnoprstuwxyzęóąśłżźćń, LowerList),
    atom_chars(qABCDEFGHIJKLMNOPRSTUWXYZĘÓĄŚŁŻŹĆŃ, UpperList),
    \+ [A] ⊂ LowerList.
    \+ [A] ⊂ [q].
uppercase(q, 'Q').

readLet('\n', [], 0):- !.
readLet(Ch, [ResCh|L], I):-
    uppercase(Ch, ResCh),
    %write(ResCh),
    get_char(Ch2),
    readLet(Ch2, L, J),
    I is J+1.

mLet:- 
    get_char(Ch),
    readLet(Ch, L, I),
    atom_chars(W, L),
    writeln(W), 
    write('Długość słowa: '), writeln(I).