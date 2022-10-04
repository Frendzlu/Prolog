splitIntoTwo(L, L1, L2) :-
    append(L1, L2, L),
    same_length(L1, L2).

divideListsBySum(L, L1, L2) :-
    msort(L, S),
    append(L1, L2, S),
    sum_list(L1, Sum1), 
    sum_list(L2, Sum2),
    Sum1 = Sum2.

