# Rotor rígido

k <- 1.380649e-23 # J/K
#k_erg <- 1.380649e-16 #cgs
h <- 6.62607015e-34 # J⋅s
Na <- 6.02e23
c <- 299792458 # m/s

mu <- function(m1, m2) {
  masa_red <- m1*m2/(Na*1000*(m1+m2))
  return(masa_red)
}

boltzman <- function(g,de,t) {
  relacion <- g*exp(-de/(k*t))
  return(relacion)
}

boltzman(1,4.28e-21,200)
boltzman(1,4.28e-21,600)


inercia <- function(m1, m2, r){
  momento <- mu(m1, m2)*r*r
  return(momento)
}    

inercia(35, 19, 1.6283e-10)

b_rot <- function(m1, m2, r){
  rot <- (h/(2*pi))^2/(2*inercia(m1, m2, r))
  return(rot)
}

b_rot(35,19,1.6283e-10)

B <- h*c*20.56*100
B

bol_rot <- function(j,t) {
  relacion <- (2*j+1)*exp(-j*(j+1)*B/(k*t))
  #relacion <- exp(-j*(j+1)*B/(k*t))
  return(relacion)
}


par(mfrow=c(1,2)) # para poner los graficos en la misma figura

lis_298 <- c()
for(j in 0:20){
  a <- bol_rot(j,298)
  lis_298 <- c(lis_298,a)
}

barplot(lis_298,  # A vector of heights
        names.arg = seq(from=0, to=20), # A vector of names
        main = "", 
        xlab = "j", 
        ylab = "Nj/N0")

lis_750 <- c()
for(j in 0:20){
  a <- bol_rot(j,750)
  lis_750 <- c(lis_750,a)
 #print(a)
}

barplot(lis_750,  # A vector of heights
        names.arg = seq(from=0, to=20), # A vector of names
        main = "", 
        xlab = "j", 
        ylab = "Nj/N0")
