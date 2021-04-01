arbol_frutal(a1).
arbol_frutal(a2).
arbol_frutal(a3).

fruta(manzana).
fruta(pera).
fruta(uva).

1 { da(A,manzana) ; da(A,pera); da(A,uva)} 1 :- arbol_frutal(A).

#show da/2.