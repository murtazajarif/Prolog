/* Define types */
town(symbol).
distance(unsigned).
rib(r(town, town, distance)).
tlist(list).
rlist(list).

/* Predicates */
way(town, town, rlist, distance).
route(town, town, rlist, tlist, distance).
route1(town, tlist, rlist, tlist, distance).
ribsmember(rib, rlist).
townsmember(town, tlist).
tsp(town, town, tlist, rlist, tlist, distance).
ham(town, town, tlist, rlist, tlist, distance).
shorterRouteExists(town, town, tlist, rlist, distance).
alltown(tlist, tlist).
write_list(tlist).

/* Clauses */
write_list([]).
write_list([H | T]) :-
    write(H), write(' '), write_list(T).

townsmember(X, [X | _]).
townsmember(X, [_ | L]) :-
    townsmember(X, L).

ribsmember(r(X, Y, D), [r(X, Y, D) | _]).
ribsmember(X, [_ | L]) :-
    ribsmember(X, L).

alltown(_, []).

alltown(Route, [H | T]) :-
    townsmember(H, Route),
    alltown(Route, T).

way(Town1, Town2, Ways, OutWayDistance) :-
    ribsmember(r(Town1, Town2, D), Ways),
    OutWayDistance is D.

way(Town1, Town2, Ways, OutWayDistance) :-
    ribsmember(r(Town2, Town1, D), Ways),
    OutWayDistance is D.

route(Town1, Town2, Ways, OutRoute, OutDistance) :-
    route1(Town1, [Town2], Ways, OutRoute, T1T2Distance),
    way(Town2, Town1, Ways, LasDist),
    OutDistance is T1T2Distance + LasDist.

route1(Town1, [Town1 | Route1], _, [Town1 | Route1], OutDistance) :-
    OutDistance is 0.

route1(Town1, [Town2 | PassedRoute], Ways, OutRoute, OutDistance) :-
    way(TownX, Town2, Ways, WayDistance),
    \+ townsmember(TownX, PassedRoute),
    route1(Town1, [TownX, Town2 | PassedRoute], Ways, OutRoute, CompletingRoadDistance),
    OutDistance is CompletingRoadDistance + WayDistance.

shorterRouteExists(Town1, Town2, Towns, Ways, Distance) :-
    ham(Town1, Town2, Towns, Ways, _, Other),
    Other < Distance.

tsp(Town1, Town1, Towns, Ways, BestRoute, MinDistance) :-
    way(OtherTown, Town1, Ways, _),
    tsp(Town1, OtherTown, Towns, Ways, BestRoute, MinDistance).

tsp(Town1, Town2, Towns, Ways, BestRoute, MinDistance) :-
    ham(Town1, Town2, Towns, Ways, Route, Distance),
    \+ shorterRouteExists(Town1, Town2, Towns, Ways, Distance),
    BestRoute = Route,
    MinDistance = Distance.

ham(Town1, Town2, Towns, Ways, Route, Distance) :-
    route(Town1, Town2, Ways, Route, Distance),
    alltown(Route, Towns),
    write_list(Route),
    write(' tD = '), write(Distance), nl.

/* Goal */
:- initialization(main).
main :-
    /* EXAMPLE 1 */
    AllTowns1 = [a, b, c, d],
    AllWays1 = [r(a, b, 1), r(a, c, 10), r(c, b, 2), r(b, c, 2), r(b, d, 5), r(c, d, 3), r(d, a, 4)],
    tsp(a, a, AllTowns1, AllWays1, Route1, Distance1),
    write('Example 1: '), write_list(Route1), write(' Minimum Distance: '), write(Distance1), nl,

    /* EXAMPLE 2 */
    AllTowns2 = [a, b, c, d, e],
    AllWays2 = [r(a, c, 1), r(a, b, 6), r(a, e, 5), r(a, d, 8), r(c, b, 2), r(c, d, 7), r(c, e, 10), r(b, d, 3), r(b, e, 9), r(d, e, 4)],
    tsp(a, a, AllTowns2, AllWays2, Route2, Distance2),
    write('Example 2: '), write_list(Route2), write(' Minimum Distance: '), write(Distance2), nl.
%query=goal.
