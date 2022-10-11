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

app(El, [], [El]).
app(El, L1, [El|L1]).
    
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
    diff(A, B, D),
    unique(D, X).

diff(A, [], A).
diff(A, [H|B], X) :-
    del(H, A, Out),
    diff(Out, B, X).   

isSubsetOf(A, B) :-
    diff(A, B, X),
    X = [].