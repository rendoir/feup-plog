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

filho(F, P):- homen(F),pai(P,F).
filho(F, M):- homen(F),mae(M,F).

filha(F, P):- mulher(P),pai(P,F).
filha(F, M):- mulher(F),mae(M,F).

irmao(X,Y):- homen(X), pais(P,M,X), pais(P,M,Y), X\=Y.
irma(X,Y):- mulher(X), pais(P,M,X), pais(P,M,Y), X\=Y.

irmaos(X,Y):- irmao(X,Y), X\=Y.
irmaos(Y,X):- irmao(X,Y), X\=Y.
irmaos(X,Y):- homen(Y), irma(X,Y), X\=Y.
irmaos(Y,X):- homen(Y), irma(X,Y), X\=Y.

avo(A,N):- pai(A,P), pai(P,N).

