# Proyecto final procesos estocásticos II

Aquí se encuentran todos los archivos relacionados con la entrega de este proyecto, que tiene 3 fases:

* Estimación de parámetros y valoración de opciones para el precio de una acción mediante el movimiento browniano geométrico.
* Estimación de parámetros y valoración de opciones para el precio de una materia prima con un proceso de reversión a la media con tendencia determinista.
* Estimación de parámetros y valoración de opciones para temperatura con un proceso de reversión a la media con tendencia funcional.

Para la valoración de opciones, se utilizan los siguientes métodos numéricos:
* Simulación montecarlo.
* Árboles binomiales.
* Diferencias finitas.

Se define una cota superior para el error relativo del ajuste de los parámetros de 5\%. Cada una de las partes del proyecto se desarrolla en un notebook, que hace uso a su vez de los datos en los .csv.

La carpeta 'images' contiene las simulaciones realizadas y la carpeta 'matlab' contiene código auxiliar para estimar la tendencia funcional de un proceso de reversión a la media.
