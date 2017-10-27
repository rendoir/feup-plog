
% [--------------------]
% [------Includes------]
% [--------------------]

:- include('moves.pl').
:- include('board_draw.pl').

% [--------------------]
% [--------GAME--------]
% [--------------------]


isPieceOfPlayer1(Board, Xi, Xf) :-
    1 = 1.

inputCellOfBoard(Board, X, Y) :-
    write('X:'),
    nl,
    read(X),
    write('Y:'),
    nl,
    read(Y).

play_player1(Board, NewBoard) :-
    write('Player1: Select piece to move'), nl,
    inputCellOfBoard(Board, Xi, Yi),
    isPieceOfPlayer1(Board, Xi, Yi),
    write('Player1: Select destination cell'), nl,
    inputCellOfBoard(Board, Xf, Yf),
    move(Board,Xi,Yi,Xf,Yf, NewBoard).


isPieceOfPlayer2(Board, Xi, Xf) :-
    1 = 1.

play_player2(Board, NewBoard) :-
    write('Player2: Select piece to move'), nl,
    inputCellOfBoard(Board, Xi, Yi),
    isPieceOfPlayer2(Board, Xi, Yi),
    write('Player2: Select destination cell'), nl,
    inputCellOfBoard(Board, Xf, Yf),
    move(Board,Xi,Yi,Xf,Yf, NewBoard).

play(Board) :-
    play_player1(Board, NewBoard),
    play_player2(NewBoard, FinalBoard),
    isEndOfGame(FinalBoard),
    play(FinalBoard).
