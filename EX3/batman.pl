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

%batman :: (  ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado e_um: Agente,Classe -> {V,F}

e_um(batman,ave).
e_um(batman,mamifero).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Iniciaizacao da vida do agente

demo :-
    write( 'Sou um Batman' ),nl,
    in( demo( batman,Questao ) ),
    write( 'demo( batman,Questao )' ),nl,
    demo( batman,Questao ),
    demo.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Agente,Questao -> {V,F}

demo( Agente,Questao ) :-
    Agente::Questao,
    write( ( 1,Agente::Questao ) ),nl,
    out( prova( Agente,Questao ) ).
demo( Agente,Questao ) :-
    e_um( Agente,Classe ),
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
