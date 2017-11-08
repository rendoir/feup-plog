:- include('display.pl').
:- include('bot.pl').

/*******************************
            Common
*******************************/

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

printDifficultyMenu :-
  clearScreen,
  write('--------------------------------'), nl,
  write('-        Latrunculi XII        -'), nl,
  write('--------------------------------'), nl,
  write('-                              -'), nl,
  write('-   1. Dumb Bot                -'), nl,
  write('-   2. Intelligent Bot         -'), nl,
  write('-                              -'), nl,
  write('--------------------------------'), nl,
  write('Choose a bot difficulty:'), nl.

main :-
  mainMenu(Option),
  play(Option).

difficultyMenu(Difficulty) :-
  printDifficultyMenu,
  readOption(Difficulty, 1, 2).

mainMenu(Option) :-
  printMenu,
  readOption(Option, 1, 4).

play(1) :- playPlayerVsPlayer.
play(2) :- difficultyMenu(Difficulty), playPlayerVsComputer(Difficulty).
play(3) :- difficultyMenu(Difficulty), playComputerVsComputer(Difficulty).
play(4).

isPieceOfPlayer(Board, Player, X, Y) :-
  getMatrixElement(Y, X, Board, Piece),
  isPlayer(Player, Piece).

playPlayer(Board, Player, NewBoard) :-
  repeat,
  write('Player '), write(Player), nl,
  write('  Enter source coordinates:'), nl,
  readCoordinates(Xi, Yi),
  isPieceOfPlayer(Board, Player, Xi, Yi),
  write('  Enter destination coordinates:'), nl,
  readCoordinates(Xf, Yf),
  move(Board, Xi, Yi, Xf, Yf, NewBoard),
  !.

playComputer(Board, Player, NewBoard, Difficulty) :-
  write('Computer '), write(Player), nl,
  pressEnterToContinue,
  moveComputer(Board, Player, NewBoard, Difficulty).


/*******************************
       Player vs Player
*******************************/

playPlayerVsPlayer :-
  clearScreen,
  initialBoard(Board),
  drawBoard(Board),
  gameLoopPlayerVsPlayer(Board).
  
gameLoopPlayerVsPlayer(Board) :-
  playPlayer(Board, 1, Board2),
  clearScreen,
  drawBoard(Board2),
  not(gameIsOver(Board2, _)),
  playPlayer(Board2, 2, Board3),
  clearScreen,
  drawBoard(Board3),
  not(gameIsOver(Board3, _)),
  gameLoopPlayerVsPlayer(Board3).
gameLoopPlayerVsPlayer(_).


/*******************************
       Player vs Computer
*******************************/

playPlayerVsComputer(Difficulty) :-
  clearScreen,
  initialBoard(Board),
  drawBoard(Board),
  gameLoopPlayerVsComputer(Board, Difficulty).
  
gameLoopPlayerVsComputer(Board, Difficulty) :-
  playPlayer(Board, 1, Board2),
  clearScreen,
  drawBoard(Board2),
  not(gameIsOver(Board2, _)),
  playComputer(Board2, 2, Board3, Difficulty),
  clearScreen,
  drawBoard(Board3),
  not(gameIsOver(Board3, _)),
  gameLoopPlayerVsComputer(Board3, Difficulty).
gameLoopPlayerVsComputer(_, _).


/*******************************
       Computer vs Computer
*******************************/

playComputerVsComputer :-
  clearScreen,
  initialBoard(Board),
  drawBoard(Board),
  gameLoopComputerVsComputer(Board).
  
gameLoopComputerVsComputer(Board, Difficulty) :-
  playComputer(Board, 1, Board2, Difficulty),
  clearScreen,
  drawBoard(Board2),
  not(gameIsOver(Board2, _)),
  playComputer(Board2, 2, Board3, Difficulty),
  clearScreen,
  drawBoard(Board3),
  not(gameIsOver(Board3, _)),
  gameLoopComputerVsComputer(Board3, Difficulty).
gameLoopComputerVsComputer(_,_).
