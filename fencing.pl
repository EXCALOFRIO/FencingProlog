% Predicado para dividir una lista en grupos del mismo tamaño y también invertir listas en posiciones pares
divide_lista_en_grupos_con_inversion(Lista, TamGrupo, Grupos, GruposInvertidos) :-
    divide_lista_en_grupos(Lista, TamGrupo, Grupos),
    invertir_listas_en_posiciones_pares(Grupos, GruposInvertidos).

% Predicado para dividir una lista en grupos del mismo tamaño
divide_lista_en_grupos(Lista, TamGrupo, Grupos) :-
    length(Lista, Longitud),
    Longitud >= TamGrupo,
    dividir_lista_en_grupos(Lista, TamGrupo, Grupos).

% Caso base: crear un grupo con los elementos de la lista
dividir_lista_en_grupos([], _, []).
% Caso general: crear un grupo con el tamaño especificado y continuar recursivamente
dividir_lista_en_grupos(Lista, TamGrupo, [Grupo | GruposRestantes]) :-
    TamGrupo > 0,
    tomar_n_elementos(Lista, TamGrupo, Grupo, Resto),
    dividir_lista_en_grupos(Resto, TamGrupo, GruposRestantes).

% Predicado para tomar los primeros N elementos de una lista
tomar_n_elementos(Lista, N, Tomados, Restantes) :-
    length(Tomados, N),
    append(Tomados, Restantes, Lista).

% Predicado para invertir listas en posiciones pares dentro de una lista de grupos
invertir_listas_en_posiciones_pares([], []).
invertir_listas_en_posiciones_pares([Grupo1, Grupo2 | Resto], [Grupo1, Grupo2Invertido | GruposRestantes]) :-
    reverse(Grupo2, Grupo2Invertido),
    invertir_listas_en_posiciones_pares(Resto, GruposRestantes).

invertir_listas_en_posiciones_pares([Grupo | Resto], [Grupo | GruposRestantes]) :-
    invertir_listas_en_posiciones_pares(Resto, GruposRestantes).

% Predicado para obtener las poules a partir de los grupos invertidos
obtener_poules([], _, []).
obtener_poules([Grupo | GruposRestantes], N, [Poule | PoulesRestantes]) :-
    nth1(N, Grupo, Poule),
    obtener_poules(GruposRestantes, N, PoulesRestantes).

% Predicado para imprimir las poules
imprimir_poules(GruposInvertidos, NumPoules) :-
    NumPoules > 0,
    obtener_poules(GruposInvertidos, NumPoules, Poule),
    format('Poule ~w: ~w~n', [NumPoules, Poule]),
    NuevoNumPoules is NumPoules - 1,
    imprimir_poules(GruposInvertidos, NuevoNumPoules).
imprimir_poules(_, 0).

% Ejemplo de uso
ejemplo_poules(ListaTiradores, Npoules) :-
    % Divide la lista en grupos con inversión
    divide_lista_en_grupos_con_inversion(ListaTiradores, Npoules, Grupos, GruposInvertidos),
    % Imprime las Poules
    imprimir_poules(GruposInvertidos, Npoules).
    % ejemplo_poules([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49],7).
