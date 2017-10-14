
% [--------------------]
% [----Board Desgin----]
% [--------------------]

boardtopline(
	[empty_cell,boxlight_down_and_right, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_down, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_down,
	 boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_down, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_down, boxlight_horizontal, boxlight_horizontal, 
	 boxlight_horizontal_and_down, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_down, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_down, 
	 boxlight_horizontal, boxlight_horizontal, boxlight_down_and_left]
).

boardmiddleline(
	[empty_cell,boxlight_vertical_and_right, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_vertical, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_vertical,
	boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_vertical, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_vertical,
	boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_vertical, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_vertical,
	boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_vertical, boxlight_horizontal, boxlight_horizontal, boxlight_vertical_and_left]
).

boardbuttomline(
	[empty_cell,boxlight_up_and_right, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_up, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_up,
	boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_up, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_up,
	boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_up, boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_up,
	boxlight_horizontal, boxlight_horizontal, boxlight_horizontal_and_up, boxlight_horizontal, boxlight_horizontal, boxlight_up_and_left]
).


% [--------------------]
% [---Cell Variables---]
% [--------------------]

drawCell(black_soldier)                     :- write('BS').
drawCell(white_soldier)                     :- write('WS').
drawCell(black_dux)                         :- write('BD').
drawCell(white_dux)                         :- write('WD').
drawCell(empty_cell)                        :- write('  ').
drawCell(boxlight_down_and_right)		    :- put_code(9484).
drawCell(boxlight_down_and_left) 		    :- put_code(9488).
drawCell(boxlight_up_and_right) 		    :- put_code(9492).
drawCell(boxlight_up_and_left) 			    :- put_code(9496).
drawCell(boxlight_horizontal)			    :- put_code(9472).
drawCell(boxlight_horizontal_and_down)	    :- put_code(9516).
drawCell(boxlight_vertical) 			    :- put_code(9474).
drawCell(boxlight_vertical_and_right) 	    :- put_code(9500).
drawCell(boxlight_horizontal_and_vertical)  :- put_code(9532).
drawCell(boxlight_horizontal_and_up) 	    :- put_code(9524).
drawCell(boxlight_vertical_and_left) 	    :- put_code(9508).