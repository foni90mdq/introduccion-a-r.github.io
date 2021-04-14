# Resolución numerica de la ecuacion de schrodinger independiente del tiempo en 1D

## Librerias
La ecuación de schrodinger es una ecuacion a autovalores donde no aparece la derivada primera de la funcion. 

Existen métodos numéricos para resolver este tipo de ecuaciones.
Instalaremos una librería de R que implementa el método de Numerov y el método de Chevyshev.

https://github.com/rcarcasses/schrodinger

La libreria necesita necesita de otra librería de algebra lineal de C++ llamada armadillo

http://arma.sourceforge.net/download.html

En este otro link hay otras instrucciones para instalar esta última:
https://www.uio.no/studier/emner/matnat/fys/FYS4411/v13/guides/installing-armadillo/

Una vez instalada armadillo podremos instalar la libreria schrodinger con

´´´
install.packages('devtools')
devtools::install_github('rcarcasses/schrodinger')
´´´
Aca hay que tener un poco de paciencia, con suerte se instalará con exito, sino tendremos que ver con paciencia que librerias nos faltan según los mensajes de error que aparezcan.
Es importante que la libreria armadillo este en el path por defecto donde R busca las librerias.

Por ejemplo, en linux, estas librerias son necesarias:
build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev

Una vez instalado, el uso del paquete es bastante sencillo.

## Usando la libreria Schrodinger
Primero cargamos la librería como siempre
´´´
library(schrodinger)
library(ggplot2)
´´´

Luego es necesario indicar el numero de interpolaciones del metodo numérico

´´´
chebSetN(400)
´´´
Dejaremos ese valor en 400 y nos olvidaremos de el. No hacemos incapie en la implementacion del metodo, sino que sólo queremos jugar con la forma del potencial para observar como cambia la funcion de onda y la densidad de probabilidad.

Ahora debemos describir el potencial, vamos a hacerlo por ejemplo para el oscilador armónico.

´´´
x <- seq(-20, 20, len = 2000)
y <- x^2
´´´
Luego calculamos los autovalores y las autofunciones con 

´´´
s <- computeSpectrum(x, y, 10) 
´´´
El 10 en el comando anterior indica el numero de autofunciones que se calcularan.
En s$energies estan almacenados los autovalores de la energia, y en s$wfs las autofunciones.

Vamos a convertir las autofunciones a dataframe para graficarlas más facil.

´´´
s.frame <- data.frame(s$wfs)
´´´
Y por ultimo podemos graficar lo que nosotros queramos, por ejemplo podemos graficar la autofunción correspondiente a v=9
y su densidad de probabilidad.

´´´
ggplot(s.frame, aes(x=x))+
  geom_line(aes(y=y.9, colour = "psi"), size = 1)+
  geom_line(aes(y=(y.9)^2, colour = "psi²"), size = 1)+
  xlim(-10, 10)+
  labs(title = "",
       x = "coordenada",
       y = "funcion",
       colour="")
´´´
Obtendremos lo siguiente

[oscilador armonico](figuras/ecdif/oscilador%20armonico)

Si quiesieramos hacer lo mismo para la partícula en la caja, lo unico que tenemos que hacer es cambiar la forma del potencial por
´´´
x <- seq(-20, 20, len = 2000)
y <- 0*x
´´´
Al correr nuevamente el codigo ahora obtendremos

[caja](figuras/ecdif/caja)

[Aquí](scripts/schrodinger.R) podrán descar el script de R con los comandos anteriores.

[Ir al comienzo](#resolución-numerica-de-la-ecuacion-de schrodinger-independiente-del-tiempo-en-1D)

[Volver a la página principal](README.md)
