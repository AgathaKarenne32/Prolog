% =============================================================================
% RESOLUÇÃO DO QUEBRA-CABEÇA LÓGICO: CINCO ALUNOS NO LABORATÓRIO
% =============================================================================
% Este programa utiliza lógica de restrições para associar atributos a posições.
% O objetivo é encontrar uma configuração única que satisfaça todas as regras.
% =============================================================================

% -----------------------------------------------------------------------------
% 1. DEFINIÇÃO DOS FATOS (DOMÍNIOS DO PROBLEMA)
% Cada fato é declarado em uma linha própria para facilitar a leitura.
% -----------------------------------------------------------------------------

% --- CORES DAS MOCHILAS ---
mochila(amarela).
mochila(azul).
mochila(branca).
mochila(verde).
mochila(vermelha).

% --- NOMES DOS ALUNOS ---
nome(denis).
nome(joao).
nome(lenin).
nome(otavio).
nome(will).

% --- MESES DE NASCIMENTO ---
mes(agosto).
mes(dezembro).
mes(janeiro).
mes(maio).
mes(setembro).

% --- JOGOS FAVORITOS ---
jogo(tres_ou_mais).
jogo(caca_palavras).
jogo(cubo_vermelho).
jogo(forca).
jogo(logica).

% --- MATÉRIAS ESCOLARES ---
materia(biologia).
materia(geografia).
materia(historia).
materia(matematica).
materia(portugues).

% --- SUCOS PREFERIDOS ---
suco(laranja).
suco(limao).
suco(maracuja).
suco(morango).
suco(uva).

% -----------------------------------------------------------------------------
% 2. PREDICADOS AUXILIARES (LÓGICA DE SUPORTE)
% -----------------------------------------------------------------------------

% PREDICADO: alldifferent/1
% Objetivo: Garantir que todos os elementos de uma lista sejam distintos entre si.
% Base recursiva: Uma lista vazia sempre tem elementos distintos.
alldifferent([]).

% Passo recursivo: Verifica se a cabeça (H) não é membro da cauda (T).
alldifferent([H|T]) :- 
    not(member(H, T)), 
    alldifferent(T).

% PREDICADO: imprime_lista/1
% Objetivo: Exibir a solução final de forma organizada no console.
imprime_lista([]) :- 
    write('\n......................................'),
    write('\n FIM DA LISTA DE SOLUÇÕES '),
    write('\n......................................\n').

% Regra de impressão: Exibe a tupla atual e chama o próximo elemento.
imprime_lista([H|T]) :-
    write('\n......................................\n'),
    write('DADOS DO ALUNO: '),
    write(H), 
    nl,
    imprime_lista(T).

% -----------------------------------------------------------------------------
% 3. MODELO LÓGICO PRINCIPAL (CONJUNTO DE RESTRIÇÕES)
% -----------------------------------------------------------------------------

modelo(Solucao) :-
    % Definição da estrutura da solução: uma lista contendo 5 tuplas.
    % Cada tupla possui: (Mochila, Nome, Mes, Jogo, Materia, Suco).
    Solucao = [
        (M1, N1, Me1, J1, Mat1, S1), % Menino na posição 1
        (M2, N2, Me2, J2, Mat2, S2), % Menino na posição 2
        (M3, N3, Me3, J3, Mat3, S3), % Menino na posição 3
        (M4, N4, Me4, J4, Mat4, S4), % Menino na posição 4
        (M5, N5, Me5, J5, Mat5, S5)  % Menino na posição 5
    ],

    % --- ATRIBUIÇÃO E VALIDAÇÃO DOS DOMÍNIOS ---
    % Para cada variável, o Prolog tentará atribuir um valor dos fatos definidos.

    % Validação das Mochilas
    mochila(M1), mochila(M2), mochila(M3), mochila(M4), mochila(M5),
    alldifferent([M1, M2, M3, M4, M5]),

    % Validação dos Nomes
    nome(N1), nome(N2), nome(N3), nome(N4), nome(N5),
    alldifferent([N1, N2, N3, N4, N5]),

    % Validação dos Meses
    mes(Me1), mes(Me2), mes(Me3), mes(Me4), mes(Me5),
    alldifferent([Me1, Me2, Me3, Me4, Me5]),

    % Validação dos Jogos
    jogo(J1), jogo(J2), jogo(J3), jogo(J4), jogo(J5),
    alldifferent([J1, J2, J3, J4, J5]),

    % Validação das Matérias
    materia(Mat1), materia(Mat2), materia(Mat3), materia(Mat4), materia(Mat5),
    alldifferent([Mat1, Mat2, Mat3, Mat4, Mat5]),

    % Validação dos Sucos
    suco(S1), suco(S2), suco(S3), suco(S4), suco(S5),
    alldifferent([S1, S2, S3, S4, S5]),

    % -------------------------------------------------------------------------
    % --- REGRAS DE POSIÇÃO FIXA (CONSTRAINTS DIRETAS) ---
    % -------------------------------------------------------------------------

    % Regra: Lenin está na quinta posição.
    N5 == lenin,
    
    % Regra: Na primeira posição está quem gosta de suco de Limão.
    S1 == limao,

    % Regra: Na terceira posição está quem gosta de suco de Morango.
    S3 == morango,

    % Regra: Na terceira posição está o menino que gosta do Jogo da Forca.
    J3 == forca,

    % Regra: Otávio está em uma das pontas.
    (   
        N1 == otavio 
        ;   
        N5 == otavio 
    ),

    % Regra: Em uma das pontas está o menino que joga Cubo Vermelho.
    (   
        J1 == cubo_vermelho 
        ;   
        J5 == cubo_vermelho 
    ),

    % -------------------------------------------------------------------------
    % --- REGRAS DE ASSOCIAÇÃO DIRETA (RELACIONAMENTOS) ---
    % -------------------------------------------------------------------------

    % Regra: João gosta de história.
    member((_, joao, _, _, historia, _), Solucao),

    % Regra: O menino que nasceu em dezembro gosta de Matemática.
    member((_, _, dezembro, _, matematica, _), Solucao),

    % Regra: O garoto que gosta de Biologia gosta de suco de Morango.
    member((_, _, _, _, biologia, morango), Solucao),

    % Regra: Quem gosta de suco de Uva gosta de Problemas de Lógica.
    member((_, _, _, logica, _, uva), Solucao),

    % Regra: Quem gosta de Matemática gosta também de suco de Maracujá.
    member((_, _, _, _, matematica, maracuja), Solucao),

    % Regra: O dono da mochila Azul nasceu em janeiro.
    member((azul, _, janeiro, _, _, _), Solucao),

    % -------------------------------------------------------------------------
    % --- REGRAS DE POSICIONAMENTO RELATIVO (ORDEM) ---
    % -------------------------------------------------------------------------

    % Regra: O garoto da mochila Azul está em algum lugar à esquerda de maio.
    (   
        (M1 == azul, (Me2==maio; Me3==maio; Me4==maio; Me5==maio))
        ;   
        (M2 == azul, (Me3==maio; Me4==maio; Me5==maio))
        ;   
        (M3 == azul, (Me4==maio; Me5==maio))
        ;   
        (M4 == azul, (Me5==maio))
    ),

    % Regra: O menino que gosta de suco de Uva está à direita da mochila Azul.
    (   
        (M1 == azul, (S2==uva; S3==uva; S4==uva; S5==uva))
        ;   
        (M2 == azul, (S3==uva; S4==uva; S5==uva))
        ;   
        (M3 == azul, (S4==uva; S5==uva))
        ;   
        (M4 == azul, (S5==uva))
    ),

    % Regra: O garoto da mochila Branca está exatamente à esquerda de Will.
    (   
        (M1 == branca, N2 == will)
        ;   
        (M2 == branca, N3 == will)
        ;   
        (M3 == branca, N4 == will)
        ;   
        (M4 == branca, N5 == will)
    ),

    % Regra: Quem gosta de suco de Uva está exatamente à esquerda de Português.
    (   
        (S1 == uva, Mat2 == portugues)
        ;   
        (S2 == uva, Mat3 == portugues)
        ;   
        (S3 == uva, Mat4 == portugues)
        ;   
        (S4 == uva, Mat5 == portugues)
    ),

    % -------------------------------------------------------------------------
    % --- REGRAS DE VIZINHANÇA (ADJACÊNCIA: AO LADO DE) ---
    % -------------------------------------------------------------------------

    % Regra: O menino de setembro está ao lado de quem gosta de suco de Laranja.
    (   
        (Me1 == setembro, S2 == laranja)
        ;   
        (Me2 == setembro, (S1 == laranja ; S3 == laranja))
        ;   
        (Me3 == setembro, (S2 == laranja ; S4 == laranja))
        ;   
        (Me4 == setembro, (S3 == laranja ; S5 == laranja))
        ;   
        (Me5 == setembro, S4 == laranja)
    ),

    % Regra: Will está ao lado do menino que gosta de Problemas de Lógica.
    (   
        (N1 == will, J2 == logica)
        ;   
        (N2 == will, (J1 == logica ; J3 == logica))
        ;   
        (N3 == will, (J2 == logica ; J4 == logica))
        ;   
        (N4 == will, (J3 == logica ; J5 == logica))
        ;   
        (N5 == will, J4 == logica)
    ),

    % Regra: O menino de janeiro está ao lado de quem nasceu em setembro.
    (   
        (Me1 == janeiro, Me2 == setembro)
        ;   
        (Me2 == janeiro, (Me1 == setembro ; Me3 == setembro))
        ;   
        (Me3 == janeiro, (Me2 == setembro ; Me4 == setembro))
        ;   
        (Me4 == janeiro, (Me3 == setembro ; Me5 == setembro))
        ;   
        (Me5 == janeiro, Me4 == setembro)
    ),

    % Regra: Problemas de Lógica está ao lado do menino da mochila Amarela.
    (   
        (J1 == logica, M2 == amarela)
        ;   
        (J2 == logica, (M1 == amarela ; M3 == amarela))
        ;   
        (J3 == logica, (M2 == amarela ; M4 == amarela))
        ;   
        (J4 == logica, (M3 == amarela ; M5 == amarela))
        ;   
        (J5 == logica, M4 == amarela)
    ),

    % Regra: O garoto de setembro está ao lado de quem joga Cubo Vermelho.
    (   
        (Me1 == setembro, J2 == cubo_vermelho)
        ;   
        (Me2 == setembro, (J1 == cubo_vermelho ; J3 == cubo_vermelho))
        ;   
        (Me3 == setembro, (J2 == cubo_vermelho ; J4 == cubo_vermelho))
        ;   
        (Me4 == setembro, (J3 == cubo_vermelho ; J5 == cubo_vermelho))
        ;   
        (Me5 == setembro, J4 == cubo_vermelho)
    ),

    % Regra: O garoto do Jogo da Forca está ao lado do que gosta do 3 ou Mais.
    (   
        (J1 == forca, J2 == tres_ou_mais)
        ;   
        (J2 == forca, (J1 == tres_ou_mais ; J3 == tres_ou_mais))
        ;   
        (J3 == forca, (J2 == tres_ou_mais ; J4 == tres_ou_mais))
        ;   
        (J4 == forca, (J3 == tres_ou_mais ; J5 == tres_ou_mais))
        ;   
        (J5 == forca, J4 == tres_ou_mais)
    ),

    % Regra: O Jogo da Forca está ao lado do dono da mochila Vermelha.
    (   
        (J1 == forca, M2 == vermelha)
        ;   
        (J2 == forca, (M1 == vermelha ; M3 == vermelha))
        ;   
        (J3 == forca, (M2 == vermelha ; M4 == vermelha))
        ;   
        (J4 == forca, (M3 == vermelha ; M5 == vermelha))
        ;   
        (J5 == forca, M4 == vermelha)
    ).

% -----------------------------------------------------------------------------
% 4. PREDICADO DE EXECUÇÃO (MAIN)
% -----------------------------------------------------------------------------

% Entrada principal do programa.
% Utiliza fail para garantir que o backtracking explore todo o espaço de busca.
main :-
    % Inicia a contagem de tempo de CPU.
    statistics(cputime, TempoInicial),
    
    % Executa o modelo para encontrar uma solução válida.
    modelo(SolucaoFinal),
    
    % Imprime a solução de forma formatada.
    imprime_lista(SolucaoFinal),
    
    % Força a falha para buscar outras soluções (se existirem).
    fail.

% Predicado main alternativo: executado quando a busca termina.
main :-
    % Captura o tempo após o término da busca.
    statistics(cputime, TempoFinal),
    
    % Calcula e exibe o tempo total gasto na execução.
    nl, 
    write('--------------------------------------'),
    write('\n BUSCA TERMINADA COM SUCESSO. \n'),
    TempoTotal is TempoFinal,
    write(' Tempo de CPU utilizado: '), 
    write(TempoTotal), 
    write(' segundos.'),
    nl.
