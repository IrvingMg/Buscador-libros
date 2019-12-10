%buscar(Tema, Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem).
%buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem).

config:-
	[library(rdf)],
	use_module(library(semweb/rdf_db)).

cargar:-
	rdf_load('Biblioteca.rdf',[format(xml)]),
	rdf_load('Descripcion_AI.rdf',[format(xml)]),
	rdf_load('Descripcion_SE.rdf',[format(xml)]),
	rdf_load('Descripcion_HCI.rdf',[format(xml)]),
	rdf_load('./AI/2528.rdf',[format(xml)]),
	rdf_load('./AI/5460.rdf',[format(xml)]),
	rdf_load('./AI/5462.rdf',[format(xml)]),
	rdf_load('./AI/5498.rdf',[format(xml)]),
	rdf_load('./AI/5503.rdf',[format(xml)]),
	rdf_load('./AI/5523.rdf',[format(xml)]),
	rdf_load('./AI/5526.rdf',[format(xml)]),
	rdf_load('./AI/5527.rdf',[format(xml)]),
	rdf_load('./AI/5531.rdf',[format(xml)]),
	rdf_load('./AI/5584.rdf',[format(xml)]),
	rdf_load('./AI/5585.rdf',[format(xml)]),
	rdf_load('./AI/5586.rdf',[format(xml)]),
	rdf_load('./AI/5623.rdf',[format(xml)]),
	rdf_load('./AI/5645.rdf',[format(xml)]),
	rdf_load('./AI/6086.rdf',[format(xml)]),
	rdf_load('./HCI/1567.rdf',[format(xml)]),
	rdf_load('./HCI/4257.rdf',[format(xml)]),
	rdf_load('./HCI/6090.rdf',[format(xml)]),
	rdf_load('./HCI/6498.rdf',[format(xml)]),
	rdf_load('./HCI/6499.rdf',[format(xml)]),
	rdf_load('./HCI/6501.rdf',[format(xml)]),
	rdf_load('./HCI/6606.rdf',[format(xml)]),
	rdf_load('./HCI/6607.rdf',[format(xml)]),
	rdf_load('./HCI/6608.rdf',[format(xml)]),
	rdf_load('./HCI/6867.rdf',[format(xml)]),
	rdf_load('./HCI/6871.rdf',[format(xml)]),
	rdf_load('./HCI/7235.rdf',[format(xml)]),
	rdf_load('./SE/5870.rdf',[format(xml)]),
	rdf_load('./SE/5888.rdf',[format(xml)]),
	rdf_load('./SE/5913.rdf',[format(xml)]),
	rdf_load('./SE/5952.rdf',[format(xml)]),
	rdf_load('./SE/6087.rdf',[format(xml)]),
	rdf_load('./SE/6099.rdf',[format(xml)]),
	rdf_load('./SE/6143.rdf',[format(xml)]),
	rdf_load('./SE/6145.rdf',[format(xml)]),
	rdf_load('./SE/6181.rdf',[format(xml)]),
	rdf_load('./SE/6376.rdf',[format(xml)]),
	rdf_load('./SE/6382.rdf',[format(xml)]),
	rdf_load('./SE/6444.rdf',[format(xml)]),
	rdf_load('./SE/10080.rdf',[format(xml)]).

info(Area, Archivo, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(Archivo, 'Biblioteca/area', Area),
	rdf(Archivo, 'Biblioteca/ficha', Ficha),
	rdf(Archivo, 'Biblioteca/titulo', Titulo),
	rdf(Archivo, 'Biblioteca/autor', Autor),
	rdf(Archivo, 'Biblioteca/clasificacion', Clasif),
	rdf(Archivo, 'Biblioteca/anio', Anio),
	rdf(Archivo, 'Biblioteca/ejemplares', Ejem).

%Buscar por tema
buscar(Tema, Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(_X, _Y, literal(Tema), W),
	obtenPath(W, Path),
	info(literal(Area), Path, literal(Ficha), literal(Titulo), literal(Autor), literal(Clasif), literal(Anio), literal(Ejem)).

%Buscar por area
buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(X, 'Biblioteca/area', literal(Area)),
	info(literal(Area), X, literal(Ficha), literal(Titulo), literal(Autor), literal(Clasif), literal(Anio), literal(Ejem)).
	
%Buscar por ficha
buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(X, 'Biblioteca/ficha', literal(Ficha)),
	info(literal(Area), X, literal(Ficha), literal(Titulo), literal(Autor), literal(Clasif), literal(Anio), literal(Ejem)).

%Buscar por titulo
buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(X, 'Biblioteca/titulo', literal(Titulo)),
	info(literal(Area), X, literal(Ficha), literal(Titulo), literal(Autor), literal(Clasif), literal(Anio), literal(Ejem)).

%Buscar por autor
buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(X, 'Biblioteca/autor', literal(Autor)),
	info(literal(Area), X, literal(Ficha), literal(Titulo), literal(Autor), literal(Clasif), literal(Anio), literal(Ejem)).

%Buscar por clasificacion
buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(X, 'Biblioteca/clasificacion', literal(Clasif)),
	info(literal(Area), X, literal(Ficha), literal(Titulo), literal(Autor), literal(Clasif), literal(Anio), literal(Ejem)).

%Buscar por anio
buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(X, 'Biblioteca/anio', literal(Anio)),
	info(literal(Area), X, literal(Ficha), literal(Titulo), literal(Autor), literal(Clasif), literal(Anio), literal(Ejem)).

%Buscar por numero de ejemplares
buscar(Area, Ficha, Titulo, Autor, Clasif, Anio, Ejem):-
	rdf(X, 'Biblioteca/ejemplares', literal(Ejem)),
	info(literal(Area), X, literal(Ficha), literal(Titulo), literal(Autor), literal(Clasif), literal(Anio), literal(Ejem)).


%Procesa cadena para obtener la ruta del archivo
obtenPath(Cadena, Path):-
	term_string(Cadena, Aux1),
	split_string(Aux1, "'", "", Aux2),
	obtenElemento(Aux2, Aux3),
	atom_string(Path, Aux3).

%Devuelve el segundo elemento de una lista
obtenElemento([_X1, X2| _R], X2).

