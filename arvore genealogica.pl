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
:- dynamic avo/2.
:- dynamic irmao/2.
:- dynamic tio/2.
:- dynamic naturalidade/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}


naturalidade(aerys_II,kings_landing).
naturalidade(rhaela,kings_landing).
naturalidade(viserys,kings_landing).
naturalidade(rhaegar,kings_landing).
naturalidade(aegon,kings_landing).
naturalidade(elia,sunspear).
naturalidade(rhaenys,kings_landing).
naturalidade(daenerys,dragonstone).
naturalidade(drogo,vaes_dothrak).
naturalidade(rhaego,red_waste).
naturalidade(rickard,winterfell).
naturalidade(brandon,winterfell).
naturalidade(eddard,winterfell).
naturalidade(lyanna,winterfell).
naturalidade(benjen,winterfell).
naturalidade(john_snow,winterfell).
naturalidade(sansa,winterfell).
naturalidade(bran,winterfell).
naturalidade(rickon,winterfell).
naturalidade(arya,winterfell).
naturalidade(robb,winterfell).
naturalidade(catelyn,riverrun).
naturalidade(hoster,riverrun).
naturalidade(minisa,harrenhal).
naturalidade(edmure,riverrun).
naturalidade(lysa,riverrun).
naturalidade(robin,the_eyrie).
naturalidade(jon,the_eyrie).
naturalidade(robert,storms_end).
naturalidade(stannis,storms_end).
naturalidade(renly,storms_end).
naturalidade(cersei,casterly_rock).
naturalidade(joffrey,kings_landing).
naturalidade(myrcella,kings_landing).
naturalidade(tommen,kings_landing).
naturalidade(jaime,casterly_rock).
naturalidade(tyrion,casterly_rock).
naturalidade(lancel,casterly_rock).
naturalidade(kevan,casterly_rock).
naturalidade(tywin,casterly_rock).
naturalidade(selyse,brightwater_keep).
naturalidade(shireen,dragonstone).
naturalidade(brynden,riverrun).

filho(rhaenys,elia).
filho(rhaenys,rhaegar).
filho(aegon,elia).
filho(aegon,rhaegar).
filho(rhaego,daenerys).
filho(rhaego,drogo).
filho(daenerys,aerys_II).
filho(daenerys,rhaela).
filho(viserys,aerys_II).
filho(viserys,rhaela).
filho(rhaegar,aerys_II).
filho(rhaegar,rhaela).
filho(robb,eddard).
filho(robb,catelyn).
filho(sansa,eddard).
filho(sansa,catelyn).
filho(arya,eddard).
filho(arya,catelyn).
filho(bran,eddard).
filho(bran,catelyn).
filho(rickon,eddard).
filho(rickon,catelyn).
filho(john_snow,eddard).
filho(eddard,rickard).
filho(lyanna,rickard).
filho(benjen,rickard).
filho(brandon,rickard).
filho(robin,jon).
filho(robin,lysa).
filho(catelyn,hoster).
filho(catelyn,minisa).
filho(lysa,hoster).
filho(lysa,minisa).
filho(edmure,hoster).
filho(edmure,minisa).
filho(joffrey,robert).
filho(joffrey,cersei).
filho(myrcella,robert).
filho(myrcella,cersei).
filho(tommen,robert).
filho(tommen,cersei).
filho(cersei,tywin).
filho(jaime,tywin).
filho(tyrion,tywin).
filho(lancel,kevan).


irmao(kevan,tywin).
irmao(stannis,robert).
irmao(renly,robert).
irmao(hoster,brynden).


pai(P,F):-
	filho(F,P).

irmao(I1,I2):-
	pai(P,I1),pai(P,I2),I1\==I2.
	
tio(T,S):-
	pai(P,S),irmao(P,T).
tio(T,S):-
	pai(P,S),irmao(T,P).

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


bisavo(X,Y):-
	graudesc(Y,X,3).

bisneto(X,Y):-
	bisavo(Y,X).
	
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
	G>2, N is G-1, filho(X,Z), graudesc(Z,Y,N).

descendentes(I,0,[]).
descendentes(I,N,L):-
	solucoes(As,graudesc(As,I,N),S),
	G is N-1, descendentes(I,G,L2), 
	concat(S,L2,L).

grauasc(X,Y,N):-
	graudesc(Y,X,N).

ascendentes(D,0,[]).
ascendentes(D,G,As):-
	solucoes(A,graudesc(D,A,G),L1),
	N is G-1, ascendentes(D,N,L2),
	concat(L1,L2,As).
	
	
familiar(X,Y,filho):-
	filho(X,Y).

familiar(X,Y,pai):-
	pai(X,Y).
	
familiar(X,Y,neto):-
	neto(X,Y).
	
familiar(X,Y,avo):-
	avo(X,Y).

familiar(X,Y,bisavo):-
	bisavo(X,Y).

familiar(X,Y,bisneto):-
	bisneto(X,Y).
	
familiar(X,Y,trisavo):-
	trisavo(X,Y).
	
familiar(X,Y,primo):-
	primo(X,Y).

familiar(X,Y,tio):-
	tio(X,Y).
	
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
			
+neto(N,A)::(solucoes((N,A), (pai(N,A)),S),
			comprimento(S,Q),Q==1).		

+neto(N,A)::(solucoes(As,neto(N,As),L),comprimento(L,Q),Q=<4)

+avo(A,N)::(solucoes((A,N),avo(A,N),L),comprimento(L,Q),Q=<1)

+avo(A,N)::(solucoes(As,avo(As,N),L),comprimento(L,Q),Q=<4)
			
+grauasc(D,A,N)::(natural(N)).

+naturalidade(P,L)::(solucoes(Ls,naturalidade(P,Ls),S),comprimento(S,N),N=<1).



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
	
pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \== Y,
    pertence( X,L ).