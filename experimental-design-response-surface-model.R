#### -------------------- Prepare ---------------------- ####
setwd('/Users/na/Desktop/MyDoc/MyNIU/2021 Spring/STAT 695/A5')
df <- read.csv('TiN.csv')
head(df)
str(df)
# install.packages('rsm')
# install.packages('viridis')
library(viridis)
library(rsm)
# c_df <- coded.data(df, x1~(pressure-42)/38, x2~(ratio-6)/4)
# as.data.frame(c_df)
# dsg <- cube(2,n0=5, randomize = F)
# dsg$pressure <- mean(df$pressure)+dsg$x1*sd(df$pressure)
# dsg$ratio <- mean(df$ratio)+dsg$x2*sd(df$ratio)
# dsg <- djoin(dsg, star(alpha = 'spherical', randomize = F))
# dsg$pressure <- mean(df$pressure)+dsg$x1*sd(df$pressure)
# dsg$ratio <- mean(df$ratio)+dsg$x2*sd(df$ratio)
plot(df[,c('pressure', 'ratio')])
(80-42)/(68.87-42)
# list(summary(df$pressure), summary(df$ratio))
# list(unique(df$pressure), unique(df$ratio))
#### --------------- coded-data ----------------- ####
# cd <- coded.data(df, x1~(pressure-42)/38, x2~(ratio-6)/4)
# cd <- as.data.frame(cd)
# cd <- djoin(cd, cube(2,n0=5, randomize = F), star(alpha = 'spherical', randomize = F))
# tail(cd)
# s_rsm1 <- rsm(stress~FO(x1, x2), cd)
# summary(s_rsm1)
# s_rsm2 <- update(s_rsm1, .~.+TWI(x1,x2))
# summary(s_rsm2)

#### ---------------------- EDA ---------------------- ####
list(summary(df$pressure), summary(df$ratio), 
     summary(df$stress), summary(df$uniformity))
#### -------------- Response Surface Regression ------------- ####
## continuous response, stress & uniformity
##### stress
m1 <- rsm(stress~SO(pressure, ratio), df)
summary(m1)
m1 <- rsm(stress~FO(pressure, ratio)+TWI(pressure, ratio), df)
summary(m1)
m1 <- rsm(stress~FO(pressure, ratio)+PQ(pressure, ratio), df)
summary(m1)
m1 <- rsm(stress~FO(pressure, ratio)+PQ(pressure), df)
summary(m1)
par(mfrow=c(1,2))
contour(m1, ~pressure+ratio, image = T)
# persp(m1, ratio~pressure, image=T)
persp(m1, ~pressure+ratio, at=xs(m3), col=viridis(40), contours='colors')
par(mfrow=c(1,1))

par(mfrow=c(2,2))
plot(m1)
par(mfrow=c(1,1))

car::vif(m1)
###### uniformity
m2 <- rsm(uniformity~SO(pressure, ratio), df)
summary(m2)
m2.2 <- rsm(uniformity~FO(pressure, ratio), df)
summary(m2.2)
m2.3 <- rsm(uniformity~FO(pressure, ratio)+TWI(pressure,ratio), df)
summary(m2.3)
m2.4 <- rsm(uniformity~FO(pressure, ratio)+PQ(pressure,ratio), df)
summary(m2.4)
# anova(m2.2, m2.3)
# anova(m2.2, m2.4)
par(mfrow=c(1,2))
# contour(m2.2, ~pressure+ratio, image = T)
# # persp(m2, ratio~pressure, image=T)
# persp(m2.2, ~pressure+ratio, at=xs(m3), col=viridis(40), contours='colors')
contour(m2.3, ~pressure+ratio, image = T)
# persp(m2, ratio~pressure, image=T)
persp(m2.3, ~pressure+ratio, at=xs(m2.3), col=viridis(40), contours='colors')
par(mfrow=c(1,1))
car::vif(m2.3)
par(mfrow=c(2,2))
plot(m2.3)
par(mfrow=c(1,1))

#### overlay
contour(m1, ~pressure+ratio,at=xs(m1), image = F, col=magma(20), lty=1)
contour(m2.3, ~pressure+ratio, add=T, image = F, col=viridis(10), lty=2)
legend('topright', legend = c('stress', 'uniformity'), 
       col = c(magma(20), viridis(10)), lty = c(1,2),
       cex=0.5)

#### adding data points for classification
df2 <- df[,c('pressure', 'ratio', 'peeling')]
df2_add <-matrix(c(80,3,1, 80,4,1, 80,5,0), 
                                nrow=3, byrow = T)
colnames(df2_add) <- c('pressure', 'ratio', 'peeling')
df2 <- rbind(df2, df2_add)
## linear discriminant analysis
df2$peeling <- as.factor(df2$peeling)
m3 <- MASS::lda(peeling~pressure+ratio, df2)
plot(m3)
m3
klaR::partimat(df2[,c('ratio', 'pressure')], df2$peeling, method='lda')
lda.data <- cbind(df2, predict(m3)$x)
library(ggplot2)
ggplot(lda.data, aes(pressure, ratio))+geom_point(aes(color=peeling))
# ggplot(lda.data, aes(LD1, pressure))+geom_point(aes(color=peeling))
# ggplot(lda.data, aes(LD1, ratio))+geom_point(aes(color=peeling))

heplots::boxM(df2[,1:2], df2$peeling)
m3.2 <- MASS::qda(peeling~pressure+ratio, df2)
summary(m3.2)
m3.2
# install.packages('klaR')
klaR::partimat(df2[,c('ratio', 'pressure')], df2$peeling, data=df2, method='qda')
     