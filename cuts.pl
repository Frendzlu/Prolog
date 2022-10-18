s(X, Y, Z) :- a(X), b(Y), !, c(Z).

a(100).
a(200).

b(10).
b(20).
b(30).

c(1).
c(2).

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

isParentOf(X, Y) :-
    isChildOf(Y, X, _).

isMotherOf(X, Y) :-
    female(X),
    isParentOf(X, Y).

isFatherOf(X, Y) :-
    male(X),
    isParentOf(X, Y).

allChildren(Children) :- findall(T, isFatherOf(_, T), Children).


rzut(1).
rzut(2).
rzut(3).
rzut(4).
rzut(5).
rzut(6).

dieDistribution(X, Y, Z) :- rzut(X), rzut(Y), rzut(Z).

searchSum(Sum, [X, Y, Z]) :- dieDistribution(X, Y, Z), TSum is X + Y + Z, TSum = Sum.

resultList(S, L) :-
    findall(TL, searchSum(S, TL), L).

sumOf([], 0).
sumOf([H|T], Sum):- sumOf(T, Res), Sum is H + Res.

subset([], []).
subset([E|Tail], [E|NTail]):-
    subset(Tail, NTail).
subset([_|Tail], NTail):-
    subset(Tail, NTail).


srList(L, S, Res):-
    findall(Acc, (subset(L, Acc), sumOf(Acc, S)), Res).
