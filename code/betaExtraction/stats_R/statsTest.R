# to perform statistical tests on the beta values obtained from the localizers
# one sample and paired t-tests

install.packages("readxl")
library(readxl)

setwd("/Volumes/IqraMacFmri/visTac/fMRI_analysis/code/betaExtraction/stats_R")

myData<-read_excel(path = "betaVal_sphereRoi_Tml.xlsx")
View(myData)

#checking assumptions
# checking for normality
qqnorm(myData$lS1_Motion)
qqline(myData$lS1_Motion)

# test of normality
# H0: normal distribution; H1: not a normal distribution
#to reject H0 and accept H1, we should have p<0.05
#to accept H0 and reject H1, we should have p>0.05 => it is normal
shapiro.test(myData$lS1_Motion) 
shapiro.test(myData$lS1_Motion)$p.value

qqnorm(myData$lS1_Static)
qqline(myData$lS1_Static)
shapiro.test(myData$lS1_Static) 
shapiro.test(myData$lS1_Static)$p.value

qqnorm(myData$lMTt_Motion)
qqline(myData$lMTt_Motion)
shapiro.test(myData$lMTt_Motion) 
shapiro.test(myData$lMTt_Motion)$p.value

qqnorm(myData$lMTt_Static)
qqline(myData$lMTt_Static)
shapiro.test(myData$lMTt_Static) 
shapiro.test(myData$lMTt_Static)$p.value

qqnorm(myData$rMTt_Motion)
qqline(myData$rMTt_Motion)
shapiro.test(myData$rMTt_Motion) 
shapiro.test(myData$rMTt_Motion)$p.value

qqnorm(myData$rMTt_Static)
qqline(myData$rMTt_Static)
shapiro.test(myData$rMTt_Static) 

shapiro.test(myData$rMTt_Static)$p.value

qqnorm(myData$lhMT_Motion)
qqline(myData$lhMT_Motion)
shapiro.test(myData$lhMT_Motion) 
shapiro.test(myData$lhMT_Motion)$p.value

qqnorm(myData$lhMT_Static)
qqline(myData$lhMT_Static)
shapiro.test(myData$lhMT_Static) 
shapiro.test(myData$lhMT_Static)$p.value

qqnorm(myData$rhMT_Motion)
qqline(myData$rhMT_Motion)
shapiro.test(myData$rhMT_Motion) 
shapiro.test(myData$rhMT_Motion)$p.value

qqnorm(myData$rhMT_Static)
qqline(myData$rhMT_Static)
shapiro.test(myData$rhMT_Static) 
shapiro.test(myData$rhMT_Static)$p.value

#one-sample t-test
t.test(myData$lS1_Motion, mu = 0)
t.test(myData$lS1_Static, mu = 0)

t.test(myData$lMTt_Motion, mu = 0)
t.test(myData$lMTt_Static, mu = 0)

t.test(myData$rMTt_Motion, mu = 0)
t.test(myData$rMTt_Static, mu = 0)

t.test(myData$lhMT_Motion, mu = 0)
t.test(myData$lhMT_Static, mu = 0)

t.test(myData$rhMT_Motion, mu = 0)
t.test(myData$rhMT_Static, mu = 0)

#paired -ttest
t.test(myData$lS1_Motion, myData$lS1_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$lMTt_Motion, myData$lMTt_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$rMTt_Motion, myData$rMTt_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$lhMT_Motion, myData$lhMT_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$rhMT_Motion, myData$rhMT_Static, paired = TRUE, alternative = "two.sided")

