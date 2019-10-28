# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises: promedio _rgb_ y [luma](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages).
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

## Integrantes

Completar la tabla:

| Integrante           | github nick |
|----------------------|-------------|
|   Yonatan Cuervo     |  yocuervoc  |
|   Brayan Angarita    | baangaritar |
|     Juan Gaitan      |  jdgaitanf  |

## Discusión

# Procesamiento de imagenes


* ## Escala de Grises:

Para transformar una imgen a escala de grises, usamos el metodo de promedio, el cual consiste en sumar el valor de los tres datos que conforma un pixel y dividirlo en 3.

* ## Filtros y convoluciones:

En el procesamiento de imagenes en ocasiones es necesario transformar una imagen para obtener informacion relevante, o cambiarle el estilo. Para esto usamos convoluciones, en este caso multipicamos cada pixel por una matriz, la matrixvaria dependiaendo el resultado esperado (deteccion de bordes, desenfoque, etc).

* ## Histogramas:

El histograma fue calculado en un imagen a escala de grises, este histograma muestra el brillo la columna de prixeles de la imagen en escala de grises.

* ## Videos y FPS:

Para el procesamiento de video la idea base es la misma que para el procesamiento de imagenes, se realizan convoluciones y conversion a escala de grises de cada fotograma, y al final demide la eficiencia computacional.
