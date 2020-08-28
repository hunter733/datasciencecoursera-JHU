rm(list=ls())
#Initialization and load packages
set.seed(1214)
library(ggplot2)
library(dplyr)

# Parameters
lambda <- 0.2
sampleSize <- 40
numSimulations <- 1000

sample <- rexp(n= sampleSize*numSimulations, rate= lambda)

theoreticalMean <- 1/lambda; sampleMean = mean(sample)

# Freedman–Diaconis rule for histogram binwidth
bw <- 2 * IQR(sample) / length(sample)^(1/3)

data.frame(sample = sample) %>% 
        ggplot(., aes(sample)) +
        geom_histogram(aes(y=..density..,color="Sample"), position="identity", 
                       fill="white", binwidth=bw) +
        geom_density(aes(color="Sample"),size=1) +
        stat_function(fun = dexp, aes(color = "Exponential"), size=1,
                      args = list(rate = lambda)) +
        scale_color_manual("Legend:",
                           breaks=c("Sample","Exponential"),
                           values=c("red","darkblue")) +
#        ggtitle (title) + xlab("Sample Mean") + ylab("Density") +
        geom_vline(xintercept=sampleMean,size=0.5,color="red",linetype="dashed") +
        geom_vline(xintercept=theoreticalMean,size=0.5,color="darkblue",linetype="dashed") +
#        xlim(xAxisMin,xAxisMax) +
        theme_bw() +
        theme(legend.position = c(0.85,0.8))

# sampleMatrix contains numSimulations rows each with sampleSize samples
sampleMatrix <- matrix(sample, nrow=numSimulations,ncol=sampleSize)
# Calculate the means for each sampleSize sample
sampleMeans <- apply(sampleMatrix,1,mean)
print(sampleSummary<-summary(sampleMeans))
meanSampleMeans <- sampleSummary["Mean"]
maxSampleMeans <- sampleSummary["Max."]
minSampleMeans <- sampleSummary["Min."]
print(paste("Variance = ",varSampleMeans <- var(sampleMeans),"Theoretical Variance",
                                                theoreticalVar <- 1/lambda^2/sampleSize))


meanDeltaPercent <- (meanSampleMeans-theoreticalMean)/theoreticalMean*100
varDeltaPercent <- (varSampleMeans-theoreticalVar)/theoreticalVar*100

# Calculate xlims to make the plot symmetric

xmax <- max(maxSampleMeans-meanSampleMeans,meanSampleMeans-minSampleMeans)
xAxisMin <- meanSampleMeans-1.5*xmax
xAxisMax <- meanSampleMeans+1.5*xmax

# Freedman–Diaconis rule for binwidth
bw <- 2 * IQR(sampleMeans) / length(sampleMeans)^(1/3)

title <- paste0("Histogram of the Means and associated Probability Density Function for ", 
                numSimulations," simulations of\n",sampleSize, 
                " samples drawn from an Exponential distribution, compared to the Normal Distribution")

sampleMeansDF<- data.frame(means=sampleMeans)

plot1 <- ggplot(sampleMeansDF, aes(means)) +
        geom_histogram(aes(y=..density..,color="Sample"), position="identity", 
                       fill="white", binwidth=bw) +
        geom_density(aes(color="Sample"),size=1) +
        stat_function(fun = dnorm, aes(color = "Normal"), size=1,
                      args = list(mean = theoreticalMean, sd = sqrt(theoreticalVar))) +
        scale_color_manual("Legend:",
                           breaks=c("Sample","Normal"),
                           values=c("red","darkblue")) +
        ggtitle (title) + xlab("Sample Mean") + ylab("Density") +
        geom_vline(xintercept=meanSampleMeans,size=0.5,color="red",linetype="dashed") +
        geom_vline(xintercept=theoreticalMean,size=0.5,color="darkblue",linetype="dashed") +
        xlim(xAxisMin,xAxisMax) +
        theme_bw() +
        theme(legend.position = c(0.85,0.8))

plot2 <- ggplot(sampleMeansDF, aes(sample=means))+
        stat_qq(distribution=qnorm, color="red") +
        stat_qq_line(distribution=qnorm,color="darkblue") +
        ggtitle("Normal Quantile-Quantile Plot") +
        ylab("Sample Mean") + xlab("Normal Theoretical Quantiles") +
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5))

gridExtra::grid.arrange(plot1,plot2,ncol=2, 
                        top = "TITLE")


meanConvergence <- cumsum(sampleMeans)/1:numSimulations
upperLim <- qnorm(0.975,mean=theoreticalMean,sd=sqrt(theoreticalVar/1:numSimulations))
lowerLim <- qnorm(0.025,mean=theoreticalMean,sd=sqrt(theoreticalVar/1:numSimulations))

convergenceDF <-data.frame(i=1:numSimulations,meanConvergence=meanConvergence,upperLim=upperLim,lowerLim=lowerLim)

ggplot(convergenceDF) +
        geom_line(aes(x=i,y=meanConvergence,color="Sample Mean")) +
        geom_line(aes(x=i,y=upperLim,color="95% CI")) +
        geom_line(aes(x=i,y=lowerLim,color="95% CI")) +
        geom_hline(aes(yintercept=theoreticalMean, color="Population Mean"),linetype="dashed") +
        scale_color_manual("Legend:",
                           breaks=c("Sample Mean","95% CI","Population Mean"),
                           values=c("red","darkblue","blue")) +
        theme_bw() +
        theme(legend.position = c(0.8,0.8))
        

                           