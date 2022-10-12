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

del([X], []).
del([H|X], [H|Y]) :- del(X, Y).

shift([_|T], T).


rvwrk([], Acc, Acc).
rvwrk([H|T], Acc, Out) :- \+ [_|_] = H, \+ H = [], rvwrk(T, [H|Acc], Out).
rvwrk([[H1|T1]|T2], Acc, Out) :- rvwrk([H1|T1], Acc, X), rvwrk(T2, [X|Acc], Out).
%not really working
revrs(A, X) :- rvwrk(A, [], X).

% rvr([], []).
% rvr([H|T], Z) :- 
%     write(Z), nl,
%     (nvr(Z), rvr(T, [H]));
%     rvr(T, [Z|H]).
% %not workimg

% nvr(V) :-
%     \+(\+(V=1)),
%     \+(\+(V=0)).

% unshift(L1, L2) :-
%     rvr(L1, [_|T]),
%     rvr(T, L2).
insert(El, L1, [El|L1]).

% app(El, [], [El]).
% app(El, L1, [El|L1]).
    
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