# Trabalho de Inteligência Artificial - 2026
## Resolução do Quebra-Cabeça Lógico via Prolog

[cite_start]Este documento contém a implementação do desafio dos cinco alunos no laboratório de computação, utilizando Programação Lógica para a satisfação de restrições[cite: 93, 94].

### 1. Definição dos Fatos (Domínios)
[cite_start]Definimos os valores possíveis para cada um dos seis atributos de cada aluno[cite: 116, 146]:

```prolog
% Mochilas
mochila(amarela). mochila(azul). mochila(branca). mochila(verde). mochila(vermelha).

% Nomes
nome(denis). nome(joao). nome(lenin). nome(otavio). nome(will).

% Meses
mes(agosto). mes(dezembro). mes(janeiro). mes(maio). mes(setembro).

% Jogos
jogo(tres_ou_mais). jogo(caca_palavras). jogo(cubo_vermelho). jogo(forca). jogo(logica).

% Matérias
materia(biologia). materia(geografia). materia(historia). materia(matematica). materia(portugues).

% Sucos
suco(laranja). suco(limao). suco(maracuja). suco(morango). suco(uva).