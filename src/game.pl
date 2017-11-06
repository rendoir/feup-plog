
% [--------------------]
% [------Includes------]
% [--------------------]

:- include('moves.pl').
:- include('board_draw.pl').
:- include('utils.pl').

% [--------------------]
% [--------GAME--------]
% [--------------------]

inputCellOfBoard(X, Y) :-
    write('X:'),
    nl,
    read(X),
    write('Y:'),
    nl,
    read(Y).


isPieceOfPlayer1(Board, X, Y) :-
    getMatrixElement(Y, X, Board, Element),
    isPlayer1(Element).

play_player1(Board, NewBoard) :-
    write('Player1: Select piece to move'), nl,
    !,
    inputCellOfBoard(Xi, Yi),
    isPieceOfPlayer1(Board, Xi, Yi),
    write('Player1: Select destination cell'), nl,
    inputCellOfBoard(Xf, Yf),
    move(Board,Xi,Yi,Xf,Yf, NewBoard).


isPieceOfPlayer2(Board, X, Y) :-
    getMatrixElement(Y, X, Board, Element),
    isPlayer2(Element).

play_player2(Board, NewBoard) :-
    write('Player2: Select piece to move'), nl,
    !,
    inputCellOfBoard(Xi, Yi),
    isPieceOfPlayer2(Board, Xi, Yi),
    write('Player2: Select destination cell'), nl,
    inputCellOfBoard(Xf, Yf),
    move(Board,Xi,Yi,Xf,Yf, NewBoard).

play(Board) :-
    drawBoard(Board),
    play_player1(Board, NewBoard),
    drawBoard(NewBoard),
    play_player2(NewBoard, FinalBoard),
    % isEndOfGame(FinalBoard),
    play(FinalBoard).
