% Clingo corresponde a un ASP
% ASP: Answer set programmming
% Al "answer" también se le llama modelo

% Lo siguiente es una "regla" o una "sentencia" (sentence)
% respira(X) :- mamifero(X) % Si es mamífero, entonces respira
% cabeza ------- cuerpo
% aquello que está fuera del paréntesis corresponde al predicado
% lo de dentro corresponde a variables

% ejemplo:
p(a).
q(b).
s(a).

p(hola).
q(chao).
s(hola).

q(hola). 

% El símbolo "coma" (,) funciona como AND lógico
r(X,Y) :- p(X), q(Y), s(X), X!=Y. % Si se da p(X), Q(Y) y s(X) al mismo tiempo,
                            % entonces se de r(X,Y)

% Si tenemos (p or q) -> r, es equivalente a (p -> r) AND (q -> r)
% De esta forma es posible hacer un OR separando la expresión
