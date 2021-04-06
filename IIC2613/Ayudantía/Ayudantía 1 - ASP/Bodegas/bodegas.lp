% 1) Definir predicado para los instantes de tiempo con una cota superior dada por una constante:
#const t_max = 8.
time(0..t_max).

% 2) Definir predicado con las acciones posibles que puede hacer un robot en un instante T:
action(up).
action(down).
action(left).
action(right).
action(wait).

% 3) Para cada instante T, cada robot R debe ejecutar una única acción de todas las posibles:
1 {exec(R, A, T) : action(A)} 1 :- robot(R), time(T+1).

% 4) Definir predicado que determine el cómo se establecen las posiciones según las acciones hechas:
on(R,X,Y+1,T+1) :- exec(R,up,T), on(R,X,Y,T).
on(R,X,Y-1,T+1) :- exec(R,down,T), on(R,X,Y,T).
on(R,X+1,Y,T+1) :- exec(R,right,T), on(R,X,Y,T).
on(R,X-1,Y,T+1) :- exec(R,left,T), on(R,X,Y,T).
on(R,X,Y,T+1) :- exec(R,wait,T), on(R,X,Y,T).

% 5) Definir un predicado que indique si un robot llegó o no a su objetivo:
at_goal(R,T) :- on(R,X,Y,T), goal(R,X,Y).

% 6) Descartar modelos que no cumplan con restricciones lógicas:
:- not at_goal(R,t_max), robot(R), time(t_max).
:- on(R,X,Y,T), not rangeX(X).
:- on(R,X,Y,T), not rangeY(Y).
:- on(R,X,Y,T), obstacle(X,Y).
:- on(R1,X,Y,T), on(R2,X,Y,T), R1 != R2.

goal(R,X,Y,T) :- goal(R,X,Y), time(T).
goal(R,X,Y,0) :- goal(R,X,Y).

#show rangeX/1.
#show rangeY/1.
#show obstacle/2.
#show on/4.
#show exec/3.
#show goal/4.