rm(list=ls())
#Initialization and load packages
library(ggplot2)
library(dplyr)
library(datasets)

data("ToothGrowth")

ToothGrowth <- as_tibble(ToothGrowth)
str(ToothGrowth)

ToothGrowth$dose <- as.factor(ToothGrowth$dose)
summary(ToothGrowth)

# Data points
ggplot(ToothGrowth, aes(x = dose, y = len)) + 
        geom_point(aes(color = supp)) + facet_grid(.~supp) +
        scale_color_manual(values = c("darkblue", "red"))+
        xlab("Dose") + ylab("Tooth Length")+
        theme(legend.position="None")

# Box plot
ggplot(ToothGrowth, aes(x = dose, y = len)) + 
        geom_boxplot(aes(fill = supp), position = position_dodge(0.9)) +
        scale_fill_manual(values = c("darkblue", "red"))

# Facet Histogram plot
bw <- 2 * IQR(ToothGrowth$len) / length(ToothGrowth$len)^(1/3) # Freedman–Diaconis rule for binwidth
ggplot(ToothGrowth, aes(x=len))+
        geom_histogram(aes(y=..density..),color="black", fill="white", binwidth=bw)+
        facet_grid(supp ~ dose)
# Facet Q-Q plot
ggplot(ToothGrowth, aes(sample=len))+
        stat_qq(distribution=qnorm, color="red") +
        stat_qq_line(distribution=qnorm, color="darkblue") +
        facet_grid(supp ~ dose)

ggplot(ToothGrowth, aes(sample=len))+
        stat_qq(distribution=qt, dparams = list(df = 19), color="red") +
        stat_qq_line(distribution=qt, dparams = list(df = 19), color="darkblue") +
        facet_grid(supp ~ dose)


#----------------

var1 <- c("OJ","VC")
var2 <- c("0.5","1","2")
condition <- matrix(as.character(NA),nrow=length(var1)*length(var2),ncol=2)
k<-0
for(i in 1:length(var1)) {
        for(j in 1:length(var2)) {
                k<-k+1
                condition[k,1]<-var1[i]
                condition[k,2]<-var2[j]
        }
}
pair <- matrix(as.numeric(NA),nrow=choose(k,2),ncol=2)
l<-0
for(i in 1:(k-1)) {
        for(j in (i+1):k) {
                l<-l+1
                pair[l,1]<-i
                pair[l,2]<-j
        }
}

pSignif <-0.05
comparisons <- data.frame(
        condADel = as.character(NULL), 
        condADose = as.character(NULL),
        meanA = as.numeric(NULL),
        condBDel=as.character(NULL), 
        condBDose=as.character(NULL),
        meanB = as.numeric(NULL),
        meanDiffBA = as.numeric(NULL),
        pValue=as.numeric(NULL), 
        significant=as.logical(NULL))
for(i in 1:l) {
        set1 <- ToothGrowth %>% filter(supp==condition[pair[i,1],1],dose==condition[pair[i,1],2]) %>% select(len)
        set2 <- ToothGrowth %>% filter(supp==condition[pair[i,2],1],dose==condition[pair[i,2],2]) %>% select(len)
        tt <- t.test(set1,set2,alternative="two.sided")
        comparisons <- add_row(comparisons,
                               condADel=condition[pair[i,1],1],
                               condADose=condition[pair[i,1],2],
                               meanA=tt$estimate[1],
                               condBDel=condition[pair[i,2],1],
                               condBDose=condition[pair[i,2],2],
                               meanB=tt$estimate[2],
                               meanDiffBA=meanB-meanA,
                               pValue=tt$p.value,
                               significant=pValue<pSignif)
}

ojComparison <- filter(comparisons,condADel=="OJ",condBDel=="OJ")
vcComparison <- filter(comparisons,condADel=="VC",condBDel=="VC")
ojVcEqualComparison <- filter(comparisons,condADel=="OJ",condBDel=="VC", condADose == condBDose)
ojVcComparison <- filter(comparisons,condADel=="OJ",condBDel=="VC")

