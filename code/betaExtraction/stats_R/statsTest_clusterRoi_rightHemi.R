myData<-read_excel(path = "betaVal_clusterRoi_Tml_rightHemi.xlsx")
View(myData)

#checking assumptions
# checking for normality
# test of normality
# H0: normal distribution; H1: not a normal distribution
#to reject H0 and accept H1, we should have p<0.05
#to accept H0 and reject H1, we should have p>0.05 => it is normal
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

t.test(myData$rMst_Motion, mu = 0)
t.test(myData$rMst_Static, mu = 0)

t.test(myData$rMT_Motion, mu = 0)
t.test(myData$rMT_Static, mu = 0)

t.test(myData$rhMT_Motion, mu = 0)
t.test(myData$rhMT_Static, mu = 0)

#paired -ttest
t.test(myData$rMst_Motion, myData$rMst_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$rMT_Motion, myData$rMT_Static, paired = TRUE, alternative = "two.sided")

t.test(myData$rhMT_Motion, myData$rhMT_Static, paired = TRUE, alternative = "two.sided")

