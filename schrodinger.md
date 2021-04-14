# Resolución numérica de la ecuación de schrodinger independiente del tiempo en 1D

## Librerías
La ecuación de schrodinger es una ecuacion a autovalores donde no aparece la derivada primera de la función. 

Existen métodos numéricos para resolver este tipo de ecuaciones.
Instalaremos una librería de R llamada [Schrodinger](https://github.com/rcarcasses/schrodinger) que implementa los métodos de Numerov y de Chevyshev
para resolver la ecuación.
[Aquí](https://aapt.scitation.org/doi/10.1119/1.4748813) pueden encontrar algo de info hacerca del método de Numerov.

La libreria depende de otra librería de álgebra lineal de C++ llamada [armadillo](http://arma.sourceforge.net/download.html)

En este otro [link](https://www.uio.no/studier/emner/matnat/fys/FYS4411/v13/guides/installing-armadillo/) hay más instrucciones para instalar esta última por si hubo problemas con lo anterior.

Una vez instalada armadillo podremos instalar la libreria schrodinger con:

```
install.packages('devtools')
devtools::install_github('rcarcasses/schrodinger')
```

Aca hay que tener un poco de paciencia, con suerte se instalará con exito, sino tendremos que ver librerias nos faltan según los mensajes de error que aparezcan.
Es importante que la libreria armadillo este en el path por defecto donde R busca las librerias.

Por ejemplo, en linux, estas librerias son necesarias:
build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev

Una vez instalado, el uso del paquete es bastante sencillo.

## Usando la libreria Schrodinger
Primero cargamos la librería como siempre:
```
library(schrodinger)
library(ggplot2)
```

Luego es necesario indicar el numero de interpolaciones del método numérico

```
chebSetN(400)
```

Dejaremos ese valor en 400 y nos olvidaremos de el. No haremos incapie en la implementacion del metodo, sino que sólo queremos jugar con la forma del potencial para observar como cambia la funcion de onda y la densidad de probabilidad.

Ahora debemos describir el potencial, vamos a hacerlo por ejemplo para el oscilador armónico.

```
x <- seq(-20, 20, len = 2000)
y <- x^2
```

Luego calculamos los autovalores y las autofunciones con 

```
s <- computeSpectrum(x, y, 10) 
```

El 10 en el comando anterior indica el numero de autofunciones que se calcularan.
En s$energies estan almacenados los autovalores de la energia, y en s$wfs las autofunciones.

Vamos a convertir las autofunciones a dataframe para graficarlas más fácilmente.

```
s.frame <- data.frame(s$wfs)
```

Y por último podemos graficar lo que nosotros queramos, por ejemplo podemos graficar la autofunción correspondiente a v=9
y su densidad de probabilidad.

```
ggplot(s.frame, aes(x=x))+
  geom_line(aes(y=y.9, colour = "psi"), size = 1)+
  geom_line(aes(y=(y.9)^2, colour = "psi²"), size = 1)+
  xlim(-10, 10)+
  labs(title = "",
       x = "coordenada",
       y = "funcion",
       colour="")
```

Obtendremos lo siguiente

![oscilador armonico](figuras/ecdif/oscilador%20armonico)

Si quiesiéramos hacer lo mismo para la partícula en la caja, lo unico que tenemos que hacer es cambiar la forma del potencial por

```
x <- seq(-20, 20, len = 2000)
y <- 0*x
```

Al correr nuevamente el código ahora obtendremos

![caja](figuras/ecdif/caja)

[Aquí](scripts/schrodinger.R) podrán descargar el script de R con los comandos anteriores.

[Ir al comienzo](#resolución-numérica-de-la-ecuación-de-schrodinger-independiente-del-tiempo-en-1D)

[Volver a la página principal](README.md)
