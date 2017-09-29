piloto('Lamb').
piloto('Besenyei').
piloto('Chambliss').
piloto('MacLean').
piloto('Mangold').
piloto('Jones').
piloto('Bonhomme').

equipa('Breitling','Lamb').
equipa('Reb Bull','Breitling').
equipa('Reb Bull','Chambliss').
equipa('Mediterranean Racing Team','MacLean').
equipa('Cobra', 'Mangold').
equipa('Matador','Jones','Bonhomme').

piloto_tem_aviao('Lamb','MX2').
piloto_tem_aviao('Besenyei','Edge540').
piloto_tem_aviao('Chambliss','Edge540').
piloto_tem_aviao('MacLean','Edge540').
piloto_tem_aviao('Mangold','Edge540').
piloto_tem_aviao('Jones','Edge540').
piloto_tem_aviao('Bonhomme','Edge540').

circuito('Istanbul').
circuito('Budapest').
circuito('Porto').

vencedor('Porto','Jones').
vencedor('Istanbul','Mangold').
vencedor('Budapest','Mangold').

gates('Istanbul',9).
gates('Budapest',6).
gates('Porto',5).

equipa_ganhou('E'):-vencedor(_,P),equipa(E,P).