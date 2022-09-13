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