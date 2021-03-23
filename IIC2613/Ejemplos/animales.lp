% todos los gatos son animales
animal(X) :- gato(X).   % Si X es un gato entonces X es un animal
gato(felix).            % felix es un gato
gato(tom).
animal(jorge).

% Sintaxis
% X se declara como variable
% felix se declara como un objeto cualquiera
% notar que la implicancia es de un solo sentido, por lo tanto, jorge no sería necesariamente un gato
% :- corresponde a una implicancia con sentido opuesto, es decir, similar al operador <-
% el primer statement se leería como "gato implica animal"
