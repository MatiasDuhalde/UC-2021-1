% Archivo base para la ayudantía del 29/03/2021


%          -> c
%         /
%  a -> b ->  f
%         \
%          -> d -> e
%               \
%                 -> g
nodo(a).
nodo(b).
nodo(c).
nodo(d).
nodo(e).
nodo(f).
nodo(g).
arco(a,b).
arco(b,c).
arco(b,d).
arco(b,f).
arco(d,e).
arco(d,g).

% Escribe el predicado camino_dos/2 que es tal que camino_dos(X,Y) que se satisface cuando
% hay un camino de largo 2 entre X e Y.
camino_dos(X,Y) :- nodo(X), nodo(Y), nodo(Z), arco(X,Z), arco(Z,Y).

% Escribe el predicado camino/2 que es tal que camino(X,Y) que se satisface cuando hay un camino (dirigido)
% de cero o más aristas, desde X hasta Y
camino(X,X) :- nodo(X).
camino(X,Y) :- nodo(X), nodo(Y), arco(X,Y).
camino(X,Y) :- nodo(X), arco(X,Z), camino(Z,Y).

% Escribe el predicado no_conectados(X,Y) que se satisface cuando no hay un camino de X a Y ni tampoco
% hay un camino desde Y hasta X
no_conectados(X,Y) :- nodo(X), nodo(Y), not camino(X,Y), not camino(Y,X).

% Escribe el predicado binario/1, que es tal que binario(X) que se cumple cuando X tiene dos hijos
binario(X) :- arco(X,Y), arco(X,Z), Y!=Z.

% Escribe el predicado ternario/1, que es tal que ternario(X) que se cumple cuando X tiene tres hijos
ternario(X) :- arco(X,Y), arco(X,Z), arco(X,W), Y!=Z, Y!=W, Z!=W.

% Escribe el predicado binario_exacto(X) que se cumple cuando X tiene *exactamente* dos hijos
binario_exacto(X) :- binario(X).

% Escribe el predicado gran_ancestro(X) que se satisface cuando
% hay un camino desde X

