homen(joao).
homen(rui).
homen(daniel).
homen(gay).
homen(renato).
homen(seixas).

mulher(ana).
mulher(maria).
mulher(andreia).
mulher(sofia).
mulher(teresa).
mulher(carolina).

pais(joao,ana,rui).
pais(joao,ana,andreia).
pais(joao,ana,maria).
pais(daniel,carolina,joao).
pais(daniel,carolina,gay).
pais(seixas,sofia,daniel).
pais(seixas,sofia,renato).



pai(P,F):-pais(P,_,F).
pai(P):-pai(P,F).

mae(M,F):-pais(_,M,F).
mae(M):-mae(M,F).
