
% [--------------------]
% [------Includes------]
% [--------------------]

:- include('board_state.pl').
:- include('game.pl').

% [--------------------]
% [--------MAIN--------]
% [--------------------]

%:- initialization(main).

main :-
    initialBoard(Board),
    play(Board).

