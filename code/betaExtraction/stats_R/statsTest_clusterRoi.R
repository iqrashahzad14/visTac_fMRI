# to perform statistical tests on the beta values obtained from the localizers
# one sample and paired t-tests
#MT-MST Localizer

install.packages("readxl")
library(readxl)

setwd("/Volumes/IqraMacFmri/visTac/fMRI_analysis/code/betaExtraction/stats_R")

myData<-read_excel(path = "betaVal_clusterRoi_Tml.xlsx")
View(myData)

#checking assumptions
# checking for normality
qqnorm(myData$lMst_Motion)
qqline(myData$lMst_Motion)

# test of normality
# H0: normal distribution; H1: not a normal distribution
#to reject H0 and accept H1, we should have p<0.05
#to accept H0 and reject H1, we should have p>0.05 => it is normal
shapiro.test(myData$lMst_Motion) 
shapiro.test(myData$lMst_Motion)$p.value

qqnorm(myData$lMst_Static)
qqline(myData$lMst_Static)
shapiro.test(myData$lMst_Static) 
shapiro.test(myData$lMst_Static)$p.value

qqnorm(myData$lMT_Motion)
qqline(myData$lMT_Motion)
shapiro.test(myData$lMT_Motion) 
shapiro.test(myData$lMT_Motion)$p.value

qqnorm(myData$lMT_Static)
qqline(myData$lMT_Static)
shapiro.test(myData$lMT_Static) 
shapiro.test(myData$lMT_Static)$p.value

qqnorm(myData$lhMT_Motion)
qqline(myData$lhMT_Motion)
shapiro.test(myData$lhMT_Motion) 
shapiro.test(myData$lhMT_Motion)$p.value

qqnorm(myData$lhMT_Static)
qqline(myData$lhMT_Static)
shapiro.test(myData$lhMT_Static) 
shapiro.test(myData$lhMT_Static)$p.value

##
qqnorm(myData$rMst_Motion)
qqline(myData$rMst_Motion)
shapiro.test(myData$rMst_Motion) 
shapiro.test(myData$rMst_Motion)$p.value

qqnorm(myData$rMst_Static)
qqline(myData$rMst_Static)
shapiro.test(myData$rMst_Static) 
shapiro.test(myData$rMst_Static)$p.value

qqnorm(myData$rMT_Motion)
qqline(myData$rMT_Motion)
shapiro.test(myData$rMT_Motion) 
shapiro.test(myData$rMT_Motion)$p.value

qqnorm(myData$rMT_Static)
qqline(myData$rMT_Static)
shapiro.test(myData$rMT_Static) 
shapiro.test(myData$rMT_Static)$p.value

qqnorm(myData$rhMT_Motion)
qqline(myData$rhMT_Motion)
shapiro.test(myData$rhMT_Motion) 
shapiro.test(myData$rhMT_Motion)$p.value

qqnorm(myData$rhMT_Static)
qqline(myData$rhMT_Static)
shapiro.test(myData$rhMT_Static) 
shapiro.test(myData$rhMT_Static)$p.value

#one-sample t-test
t.test(myData$lMst_Motion, mu = 0)
t.test(myData$lMst_Static, mu = 0)

t.test(myData$lMT_Motion, mu = 0)
t.test(myData$lMT_Static, mu = 0)

t.test(myData$lhMT_Motion, mu = 0)
t.test(myData$lhMT_Static, mu = 0)

t.test(myData$rMst_Motion, mu = 0)
t.test(myData$rMst_Static, mu = 0)

t.test(myData$rMT_Motion, mu = 0)
t.test(myData$rMT_Static, mu = 0)

t.test(myData$rhMT_Motion, mu = 0)
t.test(myData$rhMT_Static, mu = 0)

#paired -ttest
t.test(myData$lMst_Motion, myData$lMst_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$lMT_Motion, myData$lMT_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$lhMT_Motion, myData$lhMT_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$rMst_Motion, myData$rMst_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$rMT_Motion, myData$rMT_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$rhMT_Motion, myData$rhMT_Static, paired = TRUE, alternative = "two.sided")

