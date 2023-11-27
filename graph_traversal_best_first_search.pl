% Define the edges and their associated costs.
edge(a, b, 5).
edge(a, c, 7).
edge(b, d, 3).
edge(b, e, 8).
edge(c, f, 6).
edge(c, g, 4).
edge(d, h, 2).
edge(d, i, 5).
edge(e, j, 7).
edge(e, k, 6).
edge(f, l, 3).
edge(f, m, 4).
edge(g, n, 5).
edge(g, o, 2).
edge(h, p, 6).


% Define the Best-First Search algorithm.
best_first_search(Start, End, Path) :-
    best_first_search(Start, End, [Start], 0, Path).

best_first_search(Current, End, Visited, Cost, Path) :-
    Current == End,
    reverse(Visited, Path).

best_first_search(Current, End, Visited, Cost, Path) :-
    findall([Next, NewCost],
            (edge(Current, Next, EdgeCost),
             not(member(Next, Visited)),
             NewCost is Cost + EdgeCost),
            NextCostList),
    sort(2, @=<, NextCostList, SortedNextCostList),  % Sort based on cost.
    member([Next, EdgeCost], SortedNextCostList),
    best_first_search(Next, End, [Next | Visited], EdgeCost, Path).

%query = best_first_search(a, p, Path).
