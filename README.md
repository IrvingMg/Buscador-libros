# Asistente inteligente para la búsqueda de libros

El “Asistente inteligente para la búsqueda de libros” se basa en el principio de unificación para encontrar la información de los libros. Esta información está distribuida en un repositorio con 54 documentos bajo el formato rdf. Para poder trabajar con este formato en Prolog, se utilizó el paquete "SWI-Prolog Semantic Web Library 3.0" el cual permite analizar la estructura y el contenido de los archivos con extensión .rdf. Para el manejo de interfaces gráficas, SWI-Prolog también provee una biblioteca llamada “XPCE” la cual fue utilizada en este proyecto.

El código del asistente se encuentra distribuido en 3 archivos con extensión .pl. En el archivo principal "Buscador.pl" se encuentran los predicados necesarios para la interacción con el usuario, como las interfaces gráficas y mensajes de bienvenida. Desde el archivo principal se procesa la entrada del usuario y se envía al siguiente archivo, “Gramatica.pl”. Como su nombre lo indica, ahí se encuentra la gramática encargada de validar la frase de ayuda introducida y hacer la consulta del término buscado en el repositorio utilizando los predicados definidos en "búsqueda_rdf.pl".

## Reconocimiento de frases

Para lograr el reconocimiento de frases en lenguaje natural se definió una gramática basándose en 15 frases de ayuda y hasta 5 palabras de búsqueda que el programa será capaz de reconocer.

### Frases

Las frases que se muestran a continuación, son las que el buscador es capaz de reconocer. Aunque aquí se presentan las frases que sirvieron como base para la elaboración de la gramática, es posible que el buscador reconozca algunas variantes de ellas.

1. Buscar _____
2. Busca libros de _____
3. Busca libros que hablen de _____
4. Muéstrame libros de _____
5. Encuentra libros de _____
6. Encuentra libros que hablen de _____
7. Muéstrame libros que hablen de _____
8. ¿Dónde encuentro _____?
9. ¿Dónde ver información de ___?
10. ¿En qué libros encuentro ____?
11. ¿Qué libros hablan de _____?
12. Ver libros que hablen de _____
13. Necesito libros sobre _____
14. Ayúdame a encontrar libros de _____

### Gramática

Para la elaboración de la gramática sólo se consideraron los caracteres del alfabeto inglés y las letras minúsculas, esto con el fin de evitar conflictos con el intérprete de SWI-Prolog.

```prolog
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
```

## Repositorio

El asistente cuenta con la información bibliográfica de 3 áreas diferentes, Ingeniería de Software, Inteligencia Artificial e Interacción Humano Computadora. En la siguiente tabla se muestra la cantidad de títulos disponibles en el programa por cada categoría.

| Categoría | Cantidad |
| ---- | ---- |
| Ingeniería de Software | 21 |
| Inteligencia Artificial | 17 |
| Interacción Humano Computadora | 12 |
| Total | 50 |

### Estructura

El repositorio está conformado por un archivo principal llamado Biblioteca.rdf en el que se concentra la cantidad de títulos, y ejemplares con los que cuenta cada categoría. Además este archivo hace referencia a otros 3, Descripción_AI.rdf, Descripción_HCI.rdf y Descipción_SE.rdf en los que se especifica la información bibliográfica de cada libro. Finalmente, se cuenta con 50 archivos que describen el contenido de cada título disponible en el repositorio, estos archivos son nombrados de acuerdo al número de ficha con el que estén registrados, por lo que sí un titulo tiene la ficha 503, su contenido estará especificado en el archivo 503.rdf.

## Tipos de búsqueda

Para devolver los resultados de una búsqueda, el programa analiza 8 campos de la información bibliográfica. Por lo tanto, es posible hacer búsquedas de libros por

1. Área
2. Ficha
3. Título
4. Autor
5. Clasificación
6. Año
7. Ejemplares
8. Tema/Subtema/Lección

La búsqueda por temas, subtemas y lecciones se toma como un solo tipo de búsqueda debido a que el asistente considera todo el contenido de los libros como temas, sin hacer la distinción entre subtemas y lecciones. Aunque las frases de ayuda no dependen del tipo de búsqueda, a continuación se muestra una tabla con las frases que se deberían usar para cada búsqueda.

| Frase de ayuda | Tipo de búsqueda |
| ---- | ---- |
| Buscar | Área/Ficha/Título/Autor/Clasificación/Año/Ejemplares/Tema |
| Busca libros de | Área/Autor/Año/Tema |
| Busca libros que hablen de | Área/Tema |
| Muéstrame libros de | Área/Autor/Año/Tema |
| Encuentra libros de | Área/Autor/Año/Tema |
| Encuentra libros que hablen de | Área/Tema |
| Muéstrame libros que hablen de | Área/Tema |
| Dónde encuentro | Ficha/Titulo/Autor/Clasificación/Tema |
| Dónde ver información de | Área/Tema |
| En qué libros encuentro | Autor/Tema |
| Qué libros hablan de | Área/Tema |
| Ver libros que hablan de | Área/Tema |
| Necesito libros sobre | Área/Tema |
| Ayúdame a encontrar libros de | Área/Autor/Año/Tema |

## Ejecutar

Para iniciar el asistente se deben seguir los siguientes pasos:

1. Abrir consola de SWI-Prolog.
2. Ubicar el archivo “Buscador.pl” y obtener la ruta en el que se encuentra.
3. Desde la consola de SWI-Prolog con el comando cd, cambiar el directorio actual a la ruta obtenida en el paso anterior.
4. Abrir el archivo "Buscador.pl" con el comando consult.
5. Ejecutar el comando main.
