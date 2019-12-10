%Tipo de instruccion
instruccion --> pregunta, elemento, simb.
instruccion --> fayuda, elemento.

%Estructura pregunta
pregunta --> prep, advint, respregunta.
pregunta --> advint, respregunta. 

respregunta --> sust, verbconj, prep.
respregunta --> sust, verbconj.
respregunta --> verbinf, sust, prep.
respregunta --> verbconj.

%Estructura frase de ayuda
fayuda --> pinicio, prep, verbinf, resfrase.
fayuda --> pinicio, resfrase.
fayuda --> pinicio.

resfrase --> sust, prep.
resfrase --> sust, pronr, verbconj, prep. 

pinicio --> verbinf.

%Terminales
pinicio --> [ayudame].
pinicio --> [busca]. 
pinicio --> [muestrame]. 
pinicio --> [encuentra].
pinicio --> [necesito].

sust --> [libros].
sust --> [informacion].

verbconj --> [hablan].
verbconj --> [hablen].
verbconj --> [encuentro].

verbinf --> [buscar].
verbinf --> [ver].
verbinf --> [encontrar].

prep --> [a].
prep --> [sobre].
prep --> [de]. 
prep --> [en].

pronr --> [que].

advint --> [que].
advint --> [donde].

elemento --> [P1], [P2], [P3], [P4], [P5], { atomic_list_concat([P1, P2, P3, P4, P5], ' ', P), procesaBusqueda(P) }.
elemento --> [P1], [P2], [P3], [P4], { atomic_list_concat([P1, P2, P3, P4], ' ', P), procesaBusqueda(P) }.
elemento --> [P1], [P2], [P3], { atomic_list_concat([P1, P2, P3], ' ', P), procesaBusqueda(P) }.
elemento --> [P1], [P2], {atomic_list_concat([P1, P2], ' ', P), procesaBusqueda(P)}.
elemento --> [P], {procesaBusqueda(P)}.


simb --> [?].

%Procesa busqueda
procesaBusqueda(Item):-
	atomic_list_concat(['Resultados', de, Item], ' ', TituloV),
	busqueda(Item, L),
	ventanaResultados(TituloV, L).

%Busquedas
%Buscar por tema
busqueda(Tema, L):-
	setof(	(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem),
		   	buscar(Tema, Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem), 
		   	L),!.

%Buscar por area
busqueda(Area, L):-
	setof(	(Ficha, Titulo, Autor, Clasif, Anio, Ejem),
		   	buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem), 
		 	L),!.

%Buscar por ficha
busqueda(Ficha, L):-
	setof(	(Area, Titulo, Autor, Clasif, Anio, Ejem),
		   	buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem), 
		 	L),!.

%Buscar por titulo
busqueda(Titulo, L):-
	setof(	(Area, Ficha, Autor, Clasif, Anio, Ejem),
		   	buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem), 
		 	L),!.

%Buscar por autor
busqueda(Autor, L):-
	setof(	(Area, Ficha, Titulo, Clasif, Anio, Ejem),
		   	buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem), 
		 	L),!.

%Buscar por clasificacion
busqueda(Clasif, L):-
	setof(	(Area, Ficha, Titulo, Autor, Anio, Ejem),
		   	buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem), 
		 	L),!.

%Buscar por anio
busqueda(Anio, L):-
	setof(	(Area, Ficha, Titulo, Autor, Clasif, Ejem),
		   	buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem), 
		 	L),!.

%Buscar por numero de ejemplares
busqueda(Ejem, L):-
	setof(	(Area, Ficha, Titulo, Autor, Clasif, Anio),
		   	buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem), 
		 	L),!.


