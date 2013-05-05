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
:- dynamic excepcao/1.

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
principio(ziagenavir,sulfato_de_abacavirHK).
principio(proflam,acido_alendronico).
principio(diamox,acetazolamida).
principio(fluimucil,acetilcisteina).
principio(valdoxan,acetaz).


% apresentacao(Medicamento, Apresentacao) ->{V,F,D}
apresentacao(ziagenavir,unidades_24).
apresentacao(proflam,unidades_12).
apresentacao(diamox,unidades_25).
apresentacao(fluimucil,efervescente_600mg).
apresentacao(valdoxan,unidades_35).



%----ind_terapeutica(Medicamento, Indicaçao) ->{V,F,D}
ind_terapeutica(ziagenavir,tratamento_HIV).
ind_terapeutica(proflam,dor_pos_cirugica).
ind_terapeutica(diamox,insuficiencia_cardiaca_congestiva).
ind_terapeutica(fluimucil,dores_mosculares).
ind_terapeutica(valdoxan,dores_de_cabeca).



%----aplicacao(Medicamento, Aplicação) ->{V,F,D}
aplicacao(ziagenavir,oral).
aplicacao(proflam,oral).
aplicacao(diamox,nasal).
aplicacao(fluimucil,oral).
aplicacao(valdoxan,oral).



%----armazenamento(Medicamento, Armario,Prateleira) ->{V,F,D} 
armazenamento(ziagenavir,1,1).
armazenamento(proflam,1,2).
armazenamento(diamox,2,1).
armazenamento(fluimucil,2,2).
armazenamento(valdoxan,3,1).



%---- preco_venda(Medicamento, Preço) ->{V,F,D}
preco_venda(ziagenavir,20).
preco_venda(proflam,15).
preco_venda(diamox,8).
preco_venda(fluimucil,10).
preco_venda(valdoxan,13).



%---- preco_publico(Medicamento, Preço) ->{V,F,D}
preco_publico(ziagenavir,28).
preco_publico(proflam,20).
preco_publico(diamox,10).
preco_publico(fluimucil,15).
preco_public(valdoxan,14).


%---- preco_especial(Medicamento, Preço) ->{V,F,D}
preco_especial(ziagenavir,25).
preco_especial(proflam,20).
preco_especial(diamox,9).
preco_especial(fluimucil,19).
preco_especial(valdoxan,15).


%---- validade(Medicamento, Dia,Mes,Ano) ->{V,F,D}
validade(ziagenavir,1,2,2016).
validade(proflam,1,2,2013).
validade(diamox,1,3,2014).
validade(fluimucil,1,5,2015).
validade(valdoxan,1,5,2016).




%---- introducao(Medicamento, Dia,Mes,Ano) ->{V,F,D}
introducao(ziagenavir,1,1,2000).
introducao(proflam,1,2,2001).
introducao(diamox,1,4,2003).
introducao(fluimucil,1,7,2002).
introducao(valdoxan,1,2,1999).


%---------------Valores Nulos----
%--------------------------------

-validade(Md,D,M,A):-nao(validade(Md,D,M,A)),nao(excepcao(validade(Md,D,M,A))).
excepcao(validade(diamoxsan,1,3,2015)).

-preco_venda(M,P):-nao(preco_venda(M,P)),nao(excepcao(preco_venda(M,P))).
excepcao(preco_venda(valdoxanas,14)).

-aplicacao(M,A):-nao(aplicacao(M,A)),nao(excepcao(aplicacao(M,A))).
excepcao(aplicacao(diamoxsan,bebendo)).

-apresentacao(M,A):-nao(apresentacao(M,A)),nao(excepcao(apresentacao(M,A))).
excepcao(apresentacao(diamoxsan,sem_unidades)).

-principio(M,P):-nao(principio(M,P)),nao(excepcao(principio(M,P))).
excepcao(principio(diamoxsan,nao_especificado)).

%--
-ind_terapeutica(M,I):-nao(ind_terapeutica(M,I)),nao(excepcao(ind_terapeutica(M,I))).

excepcao(ind_terapeutica(M,X)):-
	ind_terapeutica(M, sem_indicacoes).

ind_terapeutica(diamoxsan, sem_indicacoes).
%--	

excepção(apresentacao(M,A)) :- apresentacao(diamoxsan,A).
%---------------------------------------------------------------------------------------

%-------------------Invariante Estrutural:  nao permitir a insercao de conhecimento repetido

+principio( M,P ) :: (solucoes( (M,P),(principio( M,P )),S ),
                  comprimento( S,N ), N == 1
                  ).
				  
+apresentacao( M,A ) :: (solucoes( (M,A),(apresentacao( M,A )),S ),
                  comprimento( S,N ), N == 1
                  ).
				  
+ind_terapeutica( M,I ) :: (solucoes( (M,I),(ind_terapeutica( M,I )),S ),
                  comprimento( S,N ), N == 1
                  ).
				  
+aplicacao( M,A ) :: (solucoes( (M,A),(aplicacao( M,A )),S ),
                  comprimento( S,N ), N == 1
                  ).

%--pode armazenar varias vezes o mesmo produto, mas se a zona em questão já tiver ocupada não insere
 
+armazenamento( M,A,P) :: (solucoes( (M,A,P),(armazenamento( M,A,P )),S ),
                  comprimento( S,N ), N == 1
                  ).

+preco_venda( M,P) :: (solucoes( (M,P),(preco_venda( M,P )),S ),
                  comprimento( S,N ), N == 1
                  ).
				  
+preco_publico( M,P) :: (solucoes( (M,P),(preco_publico( M,P )),S ),
                  comprimento( S,N ), N == 1
                  ).

+preco_especial( M,P) :: (solucoes( (M,P),(preco_especial( M,P )),S ),
                  comprimento( S,N ), N == 1
                  ).

%-----------
indicacoes(Med,S):-
	solucoes(Inds,ind_terapeutica(Med,Inds),S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---Extensão do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

%---Inserção do conhecimento
insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

	
% Remoção do conhecimento
regressao( T ) :- findall( I,-T::I,L ),
    			  teste( L ),
    			  remover(T).

remover( T ) :- retract( T ).
remover( T ) :- assert( T ),!,fail.



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