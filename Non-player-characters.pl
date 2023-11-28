% Prolog Code for AI-controlled NPCs in Games

% Example Facts (Replace with your actual game data)
player_health(70).
enemy_health(50).
% ... (more game-related facts)

% Decision-Making Rules (Modify and expand based on your game logic)
make_decision(attack) :-
    player_health(PlayerHealth),
    enemy_health(EnemyHealth),
    PlayerHealth < EnemyHealth.
make_decision(retreat) :-
    player_health(PlayerHealth),
    enemy_health(EnemyHealth),
    PlayerHealth >= EnemyHealth.

% Main NPC Behavior Loop
npc_behavior_loop :-
    make_decision(Decision),
    perform_action(Decision).

perform_action(attack) :-
    write('NPC decides to attack the player!'), nl.
perform_action(retreat) :-
    write('NPC decides to retreat from the player!'), nl.

%Query - npc_behavior_loop.
