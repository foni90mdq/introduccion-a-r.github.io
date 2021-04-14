library(schrodinger)
library(ggplot2)
# Metodo de Chebyshev con 400 interpolaciones.
chebSetN(400)
# Crear el potencial
x <- seq(-20, 20, len = 2000)
y <- x^2 #oscilador armonico
# y <- 0*x #particula en la caja
#y <- (1-exp(-x))^2

# Calcula las autofunciones y los autovalores con el metodo de arriba.
# s$energies: autovalores
# s$wfs: autofunciones
s <- computeSpectrum(x, y, 10) # Se puede calcular con Numerov agregado como cuarto argumento.


# Convierte las autofunciones en dataframe para graficarlas mas facil más facil.
s.frame <- data.frame(s$wfs)

head(s.frame)

# Grafico de autofuncion y densidad de probabilidad correspondiente


ggplot(s.frame, aes(x=x))+
  geom_line(aes(y=y.9, colour = "psi"), size = 1)+
  geom_line(aes(y=(y.9)^2, colour = "psi²"), size = 1)+
  xlim(-20, 20)+
  labs(title = "",
       x = "coordenada",
       y = "funcion",
       colour="")
  