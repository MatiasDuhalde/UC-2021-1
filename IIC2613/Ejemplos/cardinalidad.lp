% N1 CONJUNTO N2. % todo modelo debe tener entre N1 y N2 átomos del conjunto
% esta restricción anterior aplica independiente de las otras reglas.
% Se pueden omitir los límites para admitir todo hacia la izq o hacia la der.
% ejemplo: {p; q; r; t}. da como output 16 modelos. 

1 {p; q; r; t} 2.

p :- t,r.
