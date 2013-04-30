%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/3

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
:- dynamic '-'/1.
:- dynamic principio/2.
:- dynamic apresentacao/2.
:- dynamic ind_terapeutica/2.
:- dynamic aplicacao/2.
:- dynamic armazenamento/3.
:- dynamic preco_venda/2.
:- dynamic preco_publico/2.
:- dynamic preco_especial/2.
:- dynamic validade/4.
:- dynamic introducao/4.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
demo(Q, verdade):- 
	Q.
demo(Q, falso):- 
	-Q.
demo(Q, desconhecido):- 
	nao(Q), nao(-Q).

nao(Q):- Q, !, fail.
nao(_).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% principio(Medicamento, Principio) ->{V,F,D}
% apresentacao(Medicamento, Apresentacao) ->{V,F,D}
% ind_terapeutica(Medicamento, Indicaçao) ->{V,F,D}
% aplicacao(Medicamento, Aplicação) ->{V,F,D}
% armazenamento(Medicamento, Armario,Prateleira) ->{V,F,D}
% preco_venda(Medicamento, Preço) ->{V,F,D}
% preco_publico(Medicamento, Preço) ->{V,F,D}
% preco_especial(Medicamento, Preço) ->{V,F,D}
% validade(Medicamento, Dia,Mes,Ano) ->{V,F,D}
% introducao(Medicamento, Dia,Mes,Ano) ->{V,F,D}



indicacoes(Med,S):-
	solucoes(Inds,ind_terapeutica(Med,Inds),S).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

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