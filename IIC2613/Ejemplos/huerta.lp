planta(tomate).
planta(durazno).
planta(uva).
planta(oregano).

regador(r1).
regador(r2).
regador(r3).

% riega(R,P) el regador R riega a la planta P
riega(r1, durazno).
riega(r1, uva).
riega(r2, tomate).
riega(r2, oregano).
riega(r3, oregano). % Esto es una afirmación, un átomo por sí solo.

% Enciende cualquier combinación de regadores...
% se pueden especificar límites para acotar la cantidad de
% regadores encendidos a la vez.
% 1 {encendido(r1); encendido(r2); encendido(r3)} 2.
encendido(r1).
encendido(r2).
encendido(r3).

% defectuoso(R): el regador R está defectuoso.
% defectuoso(r2).

% encendido(R) expresa el regador R está encendido
% lo siguiente corresponde a una regla
regada(P) :- planta(P), riega(R, P), encendido(R), not defectuoso(R). 
% Dentro de la regla, planta(P) o riega(R, P) son átomos no instanciados

% ---- Sustitución de variables ----
% El programa sustituye. Ejemplo:
% regada(oregano) :- planta(oregano), riega(r1, oregano), encendido(r1).
% Aquí, todos los átomos ya se encuentan instanciados.
% ----------------------------------

:- regada(oregano).
{defectuoso(R): regador(R)}.


% Si queremos que algunas plantas se rieguen si o si, podemos usar lo siguiente:
% :- not regada(tomate).

#show regada/1.
#show encendido/1.
#show defectuoso/1.
