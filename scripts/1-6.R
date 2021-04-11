# Ejercicio 1.6 con algunos tips extras
# Por motivos de simplicidad vamos a analizar sólo los datos del metano

library(ggplot2)

pre <- c(0.1, 0.5, 1, 5, 10, 50, 65, 80, 100, 150)
den_ch4 <- c(0.0976, 0.488, 0.977, 4.9, 9.85, 50.6, 66.1, 81.4, 101, 147)
pm_ch4 <- 0.082*200*den_ch4/pre

datos <- data.frame(pre, den_ch4, pm_ch4)

head(datos)

plot_1 <- ggplot(datos, aes(x=pre, y=pm_ch4))+
  geom_point(colour = "black", size = 2) +
  theme_classic() +
  labs(title = "",
       x = "Presion (atm)",
       y = "PM aparente (g/mol)") 

plot_1

graf1<- plot_1 + geom_smooth(method="lm",se=FALSE, col="red")
graf1

fit <- lm(pm_ch4~pre, data=datos, subset=(pre<50))
resumen <- summary(fit)
resumen$coefficients

resumen
ordenada <- resumen$coefficients[1,1]
ordenada
pendiente <- resumen$coefficients[2,1]
pendiente

a <- c(5, 6, 7, 4, 3, 6)
a[1]

plot_2 <- plot_1 + geom_abline( slope= pendiente, intercept= ordenada, color= 'red')
plot_2

pendiente
ordenada

recortado <- subset(datos, pre<50)
recortado

plot_3 <- ggplot(recortado, aes(x=pre, y=pm_ch4))+
  geom_point(colour = "black", size = 2) +
  theme_classic() +
  labs(title = "",
       x = "Presion (atm)",
       y = "PM aparente (g/mol)") 

plot_3 + geom_smooth(method="lm",se=FALSE, col="red")

head(recortado)

mas_recortado <- recortado[-c(2),]
mas_recortado

den_h2 <- c(0.0122, 0.0609, 0.122, 0.606, 1.21, 5.76, 7.36, 8.91, 10.9, 15.4)
pm_h2 <- 0.082*200*den_h2/pre
tabla_2 <- data.frame(pre, pm_ch4, pm_h2)
head(tabla_2)


colores <- c("Metano" = "darkred", "Hidrogeno" = "steelblue")
            
plot_4 <- ggplot(tabla_2, aes(x=pre)) +
  geom_point(aes(y=pm_ch4, colour = "Metano"), size = 2) +
  geom_point(aes(y=pm_h2, colour = "Hidrogeno"), size = 2) +
  theme_classic() +
  labs(title = "",
       x = "Presion (atm)",
       y = "PM aparente (g/mol)",
       colour="")+
  scale_color_manual(values = colores)
  

plot_4
