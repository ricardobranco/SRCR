%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SEMANA 11: 06.MAI.2013 - 10.MAI.2013

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Estruturas Hierarquicas com Heranca

% Distribuicao da Computacao - LINDA

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 800,xfx,'::' ).
:- dynamic e_um/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

:- use_module( library( 'linda/client' ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Teoria representada na forma Agente :: Conhecimento

%carro:: (  ).
carro::rodas(4).
carro::lugares(5).
carro::meio(terra).
carro::material(aco).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: Agente,Classe -> {V,F}



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Sou um carro' ),nl,
    in( demo( carro,Questao ) ),
    write( 'demo( carro,Questao )' ),nl,
    demo( carro,Questao ),
    demo.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Agente,Questao -> {V,F}

demo( Agente,Questao ) :-
    Agente::Questao,
    write( ( 1,Agente::Questao ) ),nl,
    out( prova( Agente,Questao ) ).
demo( Agente,Questao ) :-
    retract(e_um( Agente,Classe )),
	assert(e_um( Agente,Classe )),
    write( ( 2,e_um( Agente,Classe ) ) ),nl,
    out( demo( Classe,Questao ) ).
demo( Agente,Questao ) :-
    write( ( 3,nao ) ),nl,
    out( prova( Agente,nao ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

ligar( QN ) :-
    linda_client( QN ).

qn( L ) :-
    bagof_rd_noblock( X,X,L ).

	
