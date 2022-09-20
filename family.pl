female(kasia).
female(maria).
female(ala).
female(ula).
female(jola).
female(basia).
female(beata).

male(jan).
male(jurek).
male(marek).
male(jerzy).
male(krzysztof).


parents(kasia, jan, maria).
parents(jurek, jan, maria).
parents(ala, jan, maria).

parents(ula, ala, marek).
parents(jola, ala, marek).

parents(basia, jerzy, kasia).

parents(beata, jurek, joanna).
parents(krzysztof, jurek, joanna).

isChildOf(X, M, F) :-
    parents(X, M, F);
    parents(X, F, M).

hasKids(X) :-
    isChildOf(_, X, _).

isFather(X) :-
    hasKids(X),
    male(X).

isMother(X) :-
    hasKids(X),
    female(X).

isParentOf(X, Y) :-
    isChildOf(Y, X, _).

isMotherOf(X, Y) :-
    female(X),
    isParentOf(X, Y).

isFatherOf(X, Y) :-
    male(X),
    isParentOf(X, Y).

isGrandparentOf(X, Y) :-
    isChildOf(Y, Z, _),
    isParentOf(X, Z).

isGrandmotherOf(X, Y) :-
    isGrandparentOf(X, Y),
    female(X).

isGrandfatherOf(X, Y) :-
    isGrandparentOf(X, Y),
    male(X).

identity(X) :-
    male(X);
    female(X).

isSisterOf(X, Y) :-
    female(X),
    isSiblingOf(X, Y).

isBrotherOf(X, Y) :-
    male(X),
    isSiblingOf(X, Y).

isSiblingOf(X, Y) :-
    parents(X, M, F),
    parents(Y, M, F),
    dif(X, Y).

siblings(X) :-
    parents(X, M, F),
    parents(Y, M, F),
    dif(X, Y).

getAllSiblings(X) :-
    setof(X, siblings(X), L),
    write(L).

%Here a 2nd degree equation

delta(A, B, C, Delta) :- 
    Delta is B*B-4*A*C.

root(A, B, _C, Delta, X1, X2) :- 
    Delta > 0,
    X1 is (-B + sqrt(Delta))/(2*A),
    X2 is (-B - sqrt(Delta))/(2*A).

root(A, B, _C, Delta, X1, X2) :-
    Delta == 0,
    X1 is B / (2*A).

programRR :- 
    A is 1,
    B is 0,
    C is -4,
    delta(A, B, C, Delta),
    (
        Delta >= 0,
        root(A, B, C, Delta, X1, X2),
        nl, write("X1: "), write(X1),
        nl, write("X2: "), write(X2),
        nl
    );
    (
        nl, write("No real solutions"),
        nl
    ).

fib(0, 1).
fib(1, 1).
fib(N, I, N1, N2, F) :-
    write(N2), write(" "),
    (
        I < N,
        N3 is N2,
        N4 is N1 + N2,
        I1 is I + 1,
        fib(N, I1, N3, N4, F1),
        F is F1
    ); F is N2.

fibo(N, F) :-
    (
        N < 2,
        fib(N, Res)
    );
    (
        fib(N, 1, 1, 1, Res)
    ),
    F is Res. 

silnia(0, 1).
silnia(N, NSil) :-
    N > 0, N1 is N-1, silnia(N1, S1), NSil is S1 * N.


sum(Index, UpperBound, LowerBound, Function, Temporary, Result) :-
    (
        Index =< UpperBound,
        sumHelper(Function, Index, Temporary, NewTemporary),
        NewIndex is Index + 1,
        sum(NewIndex, UpperBound, LowerBound, Function, NewTemporary, NewResult),
        Result is NewResult
    ); Result is Temporary.

sumHelper(Function, Index, Temporary, NewTemporary) :-
    call(Function, Index, Result),
    NewTemporary is Temporary + Result.

msquare(X, Result) :-
    write(X mod 2),
    (
        X mod 2 == 0,
        Result is 0
    );
    Result is X*X.

sumCaller(LowerBound, UpperBound, Function, Result) :-
    Index is LowerBound,
    Temporary is 0,
    sum(Index, UpperBound, LowerBound, Function, Temporary, Result).