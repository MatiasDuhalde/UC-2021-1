estudiante(1).

curso(1).
curso(2).
curso(3).
curso(4).
curso(5).
curso(6).
curso(7).

:- inscrito(X,Y1), inscrito(X,Y2), inscrito(X,Y3), Y1!=Y2, Y1!=Y3, Y2!=Y3, estudiante(X), curso(Y1), curso(Y2), curso(Y3).

inscrito(1,1).
inscrito(1,2).
inscrito(1,3).
inscrito(1,4).