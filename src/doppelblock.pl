:- include('board.pl').
:- include('display.pl').


doppelblock(Size) :-
  initBoard(Board, Size),
  labelBoard(Board), 
  drawBoard(Board, Size).
