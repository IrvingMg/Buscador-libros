:- encoding(utf8).
:- use_module(library(pce)).
:- use_module(library(tabular)).
:- use_module(library(autowin)).

inicio:-
	consult('busqueda_rdf.pl'),
	config,
	cargar,
	consult('Gramatica.pl').

%Hechos
mensaje(1, '¿Cómo puedo ayudarte?').
mensaje(2, '¿En qué puedo ayudarte?').
mensaje(3, '¿Puedo hacer algo por ti?').
mensaje(4, '¿Qué puedo hacer por ti?').
mensaje(5, '¿Necesitas algo?').

%Predicados
procesa(F):-
	atomic_list_concat(L, ' ', F),
	instruccion(L,_Z), !.

procesa(F):-
	atomic_list_concat(L, ' ', F),
	not(instruccion(L,_Z)),
	ventanaError.

continuar('S'):-
	main,!.
continuar('N'):-
	!.

main:-
	inicio,
	random_between(1, 5, Aux),
	mensaje(Aux, M),
	ventanaInicio(M,Frase),
	procesa(Frase),
	ventanaContinuar(R),
	continuar(R).


ventanaInicio(M, Frase):-
	new(Dialog, dialog('Buscador')),
	new(Label, label(label1, '¡Hola! Las categorías que tengo disponibles son: AI, HCI y SE.')),
	new(Item, text_item(M)),
	new(Button, button('Buscar', message(Dialog, return, Item?selection))),
	send(Dialog, append(Label)),
	send(Dialog, append(Item)),
	send(Dialog, append(Button)),
	send(Dialog, default_button, Button),
	send(Dialog, open),
	get(Dialog, confirm, Answer), 
	free(Dialog),
	Frase = Answer.

ventanaContinuar(R):-
	new(Dialog, dialog('Buscador')),
	new(Label, label(label1, '¿Desa realizar otra búsqueda?')),
	new(Button1, button('Sí', message(Dialog, return, 'S'))),
	new(Button2, button('No', message(Dialog, return, 'N'))),
	send(Dialog, append(Label)),
	send(Dialog, append(Button1)),
	send(Dialog, append(Button2)),
	send(Dialog, default_button, Button1),
	send(Dialog, open),
	get(Dialog, confirm, Answer), 
	free(Dialog),
	R = Answer.

ventanaError:-
	new(Dialog, dialog('Buscador')),
	new(Label, label(label1, 'Oops! Parece que algo anda mal... Intenta de nuevo')),
	new(Button1, button('Continuar', message(Dialog, return, 'S'))),
	send(Dialog, append(Label)),
	send(Dialog, append(Button1)),
	send(Dialog, default_button, Button1),
	send(Dialog, open),
	get(Dialog, confirm, _Answer), 
	free(Dialog).

ventanaResultados(TituloV, ListaRes):-
	new(Dialog, dialog(TituloV)),
	new(Button1, button('Continuar', message(Dialog, return, 'S'))),
	send(Dialog, display, new(T, tabular)),
	send(T, border, 1),
	%send(T, cell_spacing, -1),
	send(T, rules, all),
	send(T, append(new(graphical))),
	send(T, append('Libros', bold)),
	send(T, next_row),
	tabular(T, 1, ListaRes),
	send(T, append(Button1)), 
	%send(Dialog, default_button, Button1),
	send(Dialog, open),
	get(Dialog, confirm, _Answer),
	free(Dialog).

tabular(_T, _N, []).
tabular(T, N, [X|R]):-
	term_string(X,X1),
	send(T, append(N, bold)),
	send(T, append(X1)),
	send(T, next_row),
	Aux is N + 1,
	tabular(T, Aux, R).