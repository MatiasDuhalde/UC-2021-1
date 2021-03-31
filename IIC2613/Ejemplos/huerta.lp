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

encendido(r1).

% encendido(R) expresa el regador R está encendido
regada(P) :- planta(P), riega(R, P), encendido(R). % Esto es una regla
% Dentro de la regla, planta(P) o riega(R, P) son átomos no instanciados

% El programa sustituye. Ejemplo:
% regada(oregano) :- planta(oregano), riega(r1, oregano), encendido(r1).
% Aquí, todos los átomos ya se encuentan instanciados.

% 


#show regada/1.
#show encendido/1.