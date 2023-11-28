% Initial state of the robot and obstacles
at(robot, position(0, 0)).
at(obstacle1, position(1, 0)).
at(obstacle2, position(2, 1)).
in_robot(Obj).

% Goal state for the robot to reach
goal_state(at(robot, position(1, 2))).

% Define the connected locations and possible directions
connected(position(X, Y), position(X, Y1)) :- Y1 is Y + 1.
connected(position(X, Y), position(X, Y1)) :- Y1 is Y - 1.
connected(position(X, Y), position(X1, Y)) :- X1 is X + 1.
connected(position(X, Y), position(X1, Y)) :- X1 is X - 1.

% Means-End Analysis to achieve the goal
solve :-
    goal_state(at(robot, Goal)),
    write('Goal reached!'), nl,
    write('Robot is at: '), write(Goal), nl.

solve :-
    \+ goal_state(at(robot, _)),
    choose_action(Action),
    execute_action(Action),
    solve.

% Choosing an action based on the current state
choose_action(move_forward) :-
    at(robot, Current),
    connected(Current, Next),
    \+ at(_, Next).

choose_action(turn_left).

choose_action(turn_right).

choose_action(pick) :-
    at(robot, Position),
    at(Obstacle, Position),
    \+ in_robot(Obstacle).

choose_action(drop) :-
    in_robot(Obj),
    at(robot, Position),
    \+ at(_, Position).

% Executing the chosen action
execute_action(move_forward) :-
    at(robot, Current),
    connected(Current, Next),
    \+ at(_, Next),
    write('Robot moves forward to '), write(Next), nl,
    retract(at(robot, _)),
    assert(at(robot, Next)).

execute_action(turn_left) :-
    write('Robot turns left'), nl.

execute_action(turn_right) :-
    write('Robot turns right'), nl.

execute_action(pick) :-
    at(robot, Position),
    at(Obstacle, Position),
    \+ in_robot(Obstacle),
    write('Robot picks up '), write(Obstacle), nl,
    retract(at(Obstacle, Position)),
    assert(in_robot(Obstacle)).

execute_action(drop) :-
    in_robot(Obj),
    at(robot, Position),
    \+ at(_, Position),
    write('Robot drops '), write(Obj), write(' at '), write(Position), nl,
    retract(in_robot(Obj)),
    assert(at(Obj, Position)).
