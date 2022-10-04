childOf(katarzyna1, michal1, barbara2).
childOf(katarzyna1, michal1, jarek2).
childOf(katarzyna1, michal1, jurek2).
childOf(katarzyna1, michal1, lucyna2).
childOf(jarek2, maria2, lucyna3).
childOf(jarek2, maria2, barbara3).
childOf(lucyna2, jacek2, maciej3).
childOf(lucyna2, jacek2, jarek3).

marriage(barbara2, maciej2).
marriage(katarzyna1, michal1).
marriage(jarek2, maria2).
marriage(jurek2, monika2).
marriage(lucyna2, jacek2).
marriage(barbara3, maciej3_IN).
marriage(jarek3, maria3).

male(michal1).
male(maciej2).
male(jarek2).
male(jurek2).
male(jacek2).
male(maciej3_IN).
male(maciej3).
male(jarek3).

female(katarzyna1).
female(barbara2).
female(maria2).
female(monika2).
female(lucyna2).
female(lucyna3).
female(barbara3).
female(maria3).

isParentOf(X, Y) 
    :- childOf(X, _A, Y); childOf(_B, X, Y). 

ojciec(X, Y) :-
    male(X),
    isParentOf(X, Y).

matka(X, Y) :-
    female(X),
    isParentOf(X, Y).

isSiblingOf(X, Y) :-
    childOf(A, B, X),
    childOf(A, B, Y),
    dif(X, Y).

siostra(X, Y) :-
    female(X),
    isSiblingOf(X, Y).

brat(X, Y) :-
    male(X),
    isSiblingOf(X, Y).

isMarriedTo(X, Y) :-
    marriage(X, Y);
    marriage(Y, X).

isUncleaunt(X, Y) :-
    (
        isSiblingOf(X, A),
        isParentOf(A, Y)
    );(
        isMarriedTo(X, A),
        isSiblingOf(A, B),
        isParentOf(B, Y)
    ).

wujek(X, Y) :-
    male(X),
    isUncleaunt(X, Y).

ciocia(X, Y) :-
    female(X),
    isUncleaunt(X, Y).

jest_wujkiem(X) :-
    wujek(X, _).

jest_ciocia(X) :-
    ciocia(X, _).

isDefined(X) :-
    male(X);
    female(X).

fib(X, Result) :-
    (
        X >= 1,
        X1 is X - 1,
        X2 is X - 2,
        fib(X1, R1),
        fib(X2, R2),
        Result is R1 + R2
    ); (
        X == 0,
        Result is 0
    ); (
        X == -1,
        Result is 0
    ).

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

fibWrapper(X, Result) :-
    (
        X1 is X-1,
        X2 is X-2,
        fib(X1, R1),
        fib(X2, R2),
        Result is R1 + R2
    ); Result is 0.

sumCaller(LowerBound, UpperBound, Function, Result) :-
    Index is LowerBound,
    Temporary is 0,
    sum(Index, UpperBound, LowerBound, Function, Temporary, Result).