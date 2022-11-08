reverseWorker([], Acc, Acc).
reverseWorker([H|T], Acc, Out) :- \+ [_|_] = H, \+ H = [], reverseWorker(T, [H|Acc], Out).
reverseWorker([H|T], Acc, Out) :- reverseWorker(T, [H|Acc], Out).
reverseNormal(A, X) :- reverseWorker(A, [], X).

dodajNaKoniec(El, [], [El]).
dodajNaKoniec(Element, L_input, L_Output) :- 
    reverseNormal(L_input, Y), 
    reverseNormal([Element|Y], L_Output),
    !.

sumaWorker([], 0, _).
sumaWorker([_|L], Suma, I) :-
    1 is I mod 2,
    NI is I + 1,
    sumaWorker(L, Suma, NI).

sumaWorker([H1|L], Suma, I) :- 
    0 is I mod 2,
    NI is I + 1,
    sumaWorker(L, NSuma, NI),
    Suma is H1 + NSuma.

sumaListy(L, Suma) :-
    sumaWorker(L, Suma, 0).

usun([], []).
usun([H1|L1], L2) :-
    H1 < 0,
    usun(L1, L2).
usun([H1|L1], [H1|L2]) :-
    H1 >= 0,
    usun(L1, L2).

sumWorker(201, 1).
sumWorker(X, I) :-
    \+ I is 1,
    NI is I - 1,
    sumWorker(NX, NI),
    X is NX + I*I + 200.

sumuj(X) :-
    sumWorker(X, 100).