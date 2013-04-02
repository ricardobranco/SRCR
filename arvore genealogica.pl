%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SEMANA 05: 21.MAR.2011 - 25.MAR.2011

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.
:- dynamic neto/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

irmao(I1,I2):-
	pai(P,I1),pai(P,I2).

tio(T,S):-
	pai(P,S),irmao(P,T).

primo(P1,P2):-
	pai(P,P1),tio(P,P2).

primo(P2,P1):-
	pai(P,P1),tio(P,P2).

avo(A,N):-
	filho(N,X),pai(A,X).

neto(N,A):-
	avo(A,N).

descendente(D,A):-
	filho(D,A);(filho(D,X),descendente(X,A)).

avo(A,N):-
	graudesc(A,N,2).

bisavo(X,Y):-
	graudesc(Y,X,3).

trisavo(X,Y):-
	graudesc(Y,X,4).

tetraneto(X,Y):-
	graudesc(X,Y,5).
	
primos(I,L):-
	solucoes(Ps,primo(Ps,I),L).

tios(I,L):-
	solucoes(Ts,tio(Ts,I),L).

irmaos(I,L):-
	solucoes(Is,irmao(Is,I),L).

graudesc(X,Y,1):-
	pai(Y,X).

graudesc(X,Y,2):-
	neto(X,Y).

graudesc(X,Y,G):-
	filho(X,Z),graudesc(Z,Y,N), G is N+1.

descendentes(I,0,[]).
descendentes(I,N,L):-
	solucoes(As,graudesc(I,As,N),S),
	descendentes(I,G,L2), G is N-1,
	concat(S,L2,L).

grauasc(X,Y,N):-
	graudesc(Y,X,N).

ascendentes(D,0,[]).
ascendentes(D,G,As):-
	solucoes(A,grauasc(D,A,G),L1),
	ascendentes(D,N,L2),N is G-1,
	concat(L1,L2,As).
	
% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), N == 1
                  ).

% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo

+filho( F,P ) :: (solucoes( (Ps),(filho( F,Ps )),S ),
                  comprimento( S,N ), N =< 2
                  ).




+pai(P,F)::(solucoes((P,F), (pai(P,F)),S),
			comprimento(S,N),N==1).

+pai(P,F)::(solucoes((Ps),(pai(Ps,F)),S),
			comprimento(S,N),N=<2).

pai(P,F):-
	filho(F,P).
			
+neto(N,A)::(solucoes((N,A), (pai(N,A)),S),
			comprimento(S,Q),Q==1).		

+neto(N,A)::(solucoes(As,neto(N,As),L),comprimento(L,Q),Q=<4)

+avo(A,N)::(solucoes((A,N),avo(A,N),L),comprimento(L,Q),Q=<1)

+avo(A,N)::(solucoes(As,avo(As,N),L),comprimento(L,Q),Q=<4)
			
+descendente(D,A,N)::(natural(N)).

+naturalidade(L,P) :: (solucoes(Ls,naturalidade(Ls,P),S),comprimento(S,N),N=<1).

familiar(A,B,Rs):-
	solucoes(X,X(A,B),Rs).

natural(1).
natural(N):-
	N is 1+G, natural(G).
			
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

retrocesso(Termo):-
	solucoes(Condicao,-Termo::Condicao,Lista),
	teste(Lista),
	retract(Termo).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

solucoes(R,T,L):-
	findall(R,T,L).
	
	
	
comprimento([],0).
comprimento([A|B],N):-
	comprimento(B,X), N is X+1.
	
concat([],L2,L2).
concat([X|L1],L2,[X|L]):-
	concat(L1,L2,L).