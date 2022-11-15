:- dynamic female/1.

a(X) :- asserta(X).

z(X) :- asserta(X).

% type afemale(kasia).


:- dynamic parents/3.
:- dynamic father/2.
:- dynamic mother/2.
:- dynamic grandfather/2.

addFactsFamily :-
    asserta(parents(basia, jurek, ala1)),
    asserta(parents(basia, jurek, jacek1)),
    asserta(parents(kasia1, jacek1, pawel2)),
    asserta(':-'(father(X, Y), parents(_, X, Y))),
    nl, write('Fakty dodane'),
    fail.

getInt(N) :- 
    get_char(Ch),
    getIntRest(Ch, L), 
    number_chars(N, L)
    

getIntRest('\n', []).
getIntRest(Ch1, [Ch1|T]) :-
    isDigit(Ch1),
    get_char(Ch2),
    getIntRest(Ch2, T).

isDigit('1') :- !.
isDigit('2') :- !.
isDigit('3') :- !.
isDigit('4') :- !.
isDigit('5') :- !.
isDigit('6') :- !.
isDigit('7') :- !.
isDigit('8') :- !.
isDigit('9') :- !.
isDigit('0') :- !.
isDigit(Ch) :- nl, write('Znak: '), write(Ch), write(' nie jest cyfrą'), !, fail.


deletePerson :-
    nl, write('Podaj imię usuwanej osoby: '),
    getString(N),
    retract(person(N, _S, _A)), !.

deletePerson :-
    nl, write('Brak takiego elementu').

averageAge :-
    findall(Age, person(_N, _S, Age), List),
    sum(Sum, List), 
    size(Size, List),
    (
        Size > 0,
        Avg is Sum/Size,
        nl, 
        write('Średni wiek wynosi: '), writenl(Avg), !    
    );
    (
        nl, nl, writenl('Nie można obliczyć średniej - baza danych jest pusta!')
    ).

display :-
    nl, writenl('Dane:'),
    person(N, S, A),
    write(N), write(' '),
    write(N), write(' '),
    writenl(N), fail.

sum(0, []).
sum(S, [H|T]) :-
    sum(TSum, T),
    S is TSum + H.