% Ejemplo clásico de lógoca
padre(luis, jorge). % luis es padre de jorge
padre(luis, ximena).
madre(maria, luis).
madre(maria, ximena).
padre(jorge, benjamin).
padre(jorge, valentina).                
madre(ximena, matias).
madre(ximena, camila).

progenitor(X,Y) :- madre(X,Y).
progenitor(X,Y) :- padre(X,Y).

abuelo(X,Y) :- padre(X,Z), progenitor(Z,Y).
abuela(X,Y) :- madre(X,Z), progenitor(Z,Y).

grandparent(X,Y) :- abuelo(X,Y).
grandparent(X,Y) :- abuela(X,Y).


% escribir predicado sibling
% predicado cousin

sibling(X,Y) :- progenitor(Z,X), progenitor(Z,Y), X!=Y.

cousin(X,Y) :- progenitor(A,X), sibling(A,B), progenitor(B,Y), X!=Y.
cousin(X,Y) :- grandparent(Z,X), grandparent(X,Y), not sibling(X,Y). % Forma alternativa
