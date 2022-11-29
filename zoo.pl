:- encoding(utf8).
:- dynamic cechaPozytywna/2, cechaNegatywna/2.

zwierze_jest(kot) :-
    jest(ssakiem),
    jest(mięsożerny),
    negatywne(ma, długie_nogi), 
    negatywne(ma, długą_szyję),
    pozytywne(czy, przeżuwa_pokarm).
zwierze_jest(gepard) :-
    jest(ssakiem),
    jest(mięsożerny),
    pozytywne(ma, brunatny_kolor),
    pozytywne(ma, ciemne_plamy).
zwierze_jest(tygrys) :-
    jest(ssakiem),
    jest(mięsożerny),
    pozytywne(ma, brunatny_kolor),
    pozytywne(ma, czarne_plamy).
zwierze_jest(zyrafa) :-
    jest(ssakiem),
    jest(kopytonogi),
    pozytywne(ma, długą_szyję),
    pozytywne(ma, długie_nogi),
    pozytywne(ma, ciemne_plamy).
zwierze_jest(zebra) :-
    jest(ssakiem),
    jest(kopytonogi),
    pozytywne(ma, czarne_pasy).
zwierze_jest(strus) :-
    jest(ptakiem),
    pozytywne(czy, przeżuwa_pokarm).

jest(ssakiem) :- pozytywne(ma, sierść).
jest(ssakiem) :- pozytywne(czy, daje_mleko).
jest(ptakiem) :- pozytywne(ma, pióra).
jest(ptakiem) :-
    pozytywne(czy, lata),
    pozytywne(czy, znosi_jaja).
jest(mięsożerny) :-
    pozytywne(czy, je_mięso).
jest(mięsożerny) :-
    pozytywne(ma, ostre_zęby),
    pozytywne(ma, pazury),
    pozytywne(ma, wysunięte_do_przodu_oczy).
jest(kopytonogi) :-
    jest(ssakiem),
    pozytywne(ma, kopyta).
jest(kopytonogi) :-
    jest(ssakiem),
    pozytywne(czy, przeżuwa_pokarm).

pozytywne(X, Y) :- cechaPozytywna(X, Y), !.
pozytywne(X, Y) :- \+ cechaNegatywna(X, Y),
    pytaj(X, Y, tak), !.

negatywne(X, Y) :- cechaNegatywna(X, Y), !.
negatywne(X, Y) :- \+ cechaPozytywna(X, Y),
    pytaj(X, Y, nie).

prompt(ma, X) :-
    atom_string(X, XString),
    atomic_list_concat(L, '_', XString),
    atomic_list_concat(L, ' ', Cecha),
    write('Czy to zwierze ma '),
    write(Cecha), write('? (t\\n)').

prompt(czy, X) :-
    atom_string(X, XString),
    atomic_list_concat(L, '_', XString),
    atomic_list_concat(L, ' ', Cecha),
    write('Czy to zwierze '),
    write(Cecha), write('? (t\\n)').

pytaj(X, Y, tak) :-
    !,
    prompt(X, Y),
    get_char(Ch), get_char(_),
    nl, Ch='n', 
    pamiętaj(X, Y, nie).
    
pamiętaj(X, Y, tak) :- assertz(cechaPozytywna(X, Y)).
pamiętaj(X, Y, nie) :- assertz(cechaNegatywna(X, Y)).

spec :-
    zwierze_jest(X),
    !, nl, 
    write('Twoim zwierzęciem może być: '),
    write(X), retractall(cechaPozytywna(_, _)), 
    retractall(cechaNegatywna(_, _)).

spec :-
    write('Nie jestem w stanie odgadnąć twojego zwierzęcia :('),
    retractall(cechaPozytywna(_, _)), 
    retractall(cechaNegatywna(_, _)).
    
