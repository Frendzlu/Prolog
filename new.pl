splitIntoTwo(L, L1, L2) :-
    append(L1, L2, L),
    same_length(L1, L2).

divideListsBySum(L, L1, L2) :-
    msort(L, S),
    append(L1, L2, S),
    sum_list(L1, Sum1), 
    sum_list(L2, Sum2),
    Sum1 = Sum2.

last(X, [X]).
last(X, [_|T]) :- last(X, T).

del([_], []).
del([H|X], [H|Y]) :- del(X, Y).

shift([_|T], T).

reverseWorker([], Acc, _, Acc).
reverseWorker([H|T], Acc, Mode, Out) :- \+ [_|_] = H, \+ H = [], reverseWorker(T, [H|Acc], Mode, Out).
reverseWorker([[H1|T1]|T2], Acc, true, Out) :- reverseWorker([H1|T1], [], true, X), reverseWorker(T2, [X|Acc], true, Out). 
reverseWorker([H|T], Acc, false, Out) :- reverseWorker(T, [H|Acc], false, Out).
reverseNormal(A, X) :- reverseWorker(A, [], false, X).
reverseRecursively(A, X) :- reverseWorker(A, [], true, X).

insert(El, L1, [El|L1]).

app(El, [], [El]).
app(El, L1, X):- reverseNormal(L1, Y), reverseNormal([El|Y], X).
    
del(_, [], []).
del(El, [El|T], Out) :- del(El, T, Out).
del(El, [NotEl|T], [NotEl|Out]) :- \+ El = NotEl, del(El, T, Out).

join([], [], []).
join([], L1, L1).
join(L1, [], L1).
join([H1|T1], [H2|T2], [H1|[H2|Out]]) :- join(T1, T2, Out).

unique([], []).
unique([B|T], [B|Out]) :- 
    del(B, T, X),
    unique(X, Out).

sum(A, B, X) :-
    join(A, B, D),
    unique(D, X).

common([], _, []).
common(_, [], []).
common([H1|T1], B, [X|Out]) :- isSubsetOf([H1], B), X = H1, common(T1, B, Out).
common([H1|T1], B, Out) :- \+ isSubsetOf([H1], B), common(T1, B, Out). 

diff(A, [], A).
diff(A, [H|B], X) :-
    del(H, A, Out),
    diff(Out, B, X).   

isSubsetOf(A, B) :-
    diff(A, B, X),
    X = [].
