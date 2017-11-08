:- include('moves.pl').
:- include('display.pl').
:- include('board.pl').

printMenu :-
  clearScreen,
	write('--------------------------------'), nl,
	write('-        Latrunculi XII        -'), nl,
	write('--------------------------------'), nl,
	write('-                              -'), nl,
	write('-   1. Player vs Player        -'), nl,
	write('-   2. Player vs Computer      -'), nl,
	write('-   3. Computer vs Computer    -'), nl,
	write('-   4. Exit                    -'), nl,
	write('-                              -'), nl,
	write('--------------------------------'), nl,
	write('Choose a game mode:'), nl.

play(1) :- playPlayerVsPlayer.
play(2) :- playPlayerVsComputer.
play(3) :- playComputerVsComputer.
play(4).

isPieceOfPlayer(Board, Player, X, Y) :-
  getMatrixElement(Y, X, Board, Piece),
  isPlayer(Player, Piece).

playPlayerVsPlayer :-
  initialBoard(Board),
  drawBoard(Board),
  gameLoopPlayerVsPlayer(Board).

playPlayer(Board, Player, NewBoard) :-
  write('Player '), write(Player), write(':'), nl,
  write('Enter source coordinates:'), nl,
  readNumber(Xi),
  readNumber(Yi),
  isPieceOfPlayer(Board, Player, Xi, Yi),
  write('Enter destination coordinates:'), nl,
  readNumber(Xf),
  readNumber(Yf),
  move(Board, Xi, Yi, Xf, Yf, NewBoard).

gameLoopPlayerVsPlayer(Board) :-
  playPlayer(Board, 1, Board2),
  drawBoard(Board2),
  not(gameIsOver(Board2, _)),
  playPlayer(Board2, 2, Board3),
  drawBoard(Board3),
  not(gameIsOver(Board3, _)),
  gameLoopPlayerVsPlayer(Board3).

mainMenu(Option) :-
  printMenu,
  readNumber(Option).

main :-
  mainMenu(Option),
  play(Option).
