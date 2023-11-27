% Define the edges of the graph.
edge(a, b).
edge(b, c).
edge(b, d).
edge(c, e).
edge(e, f).
edge(f, g).

% Define the DFS algorithm.
dfs(Start, End, Path) :-
    dfs(Start, End, [Start], Path).

dfs(Current, End, Visited, Path) :-
    Current == End,
    reverse(Visited, Path).

dfs(Current, End, Visited, Path) :-
    edge(Current, Next),
    not(member(Next, Visited)),
    dfs(Next, End, [Next | Visited], Path).  