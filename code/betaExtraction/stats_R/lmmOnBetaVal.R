# to perform lmm

setwd("/Volumes/IqraMacFmri/visTac/fMRI_analysis/code/betaExtraction/stats_R")

library(openxlsx) # import excel file
library(reshape2) # reshape data 
library(ggplot2) # plots
library(lmerTest) # linear mixed model
library(emmeans) # multiple comparisons

donnees <- read.xlsx("betaVal_sphereRoi_Tml_copy.xls-x")
donnees$subID <- factor(donnees$subID)

donnees <- melt(donnees)
donnees$roi <- sub("_.*", "", donnees$variable)
donnees$condition <- sub(".*_", "", donnees$variable)

write.xlsx(donnees, file = "data_longFormat.xlsx")

ggplot(donnees, aes(x = condition, y = value, fill = roi)) + geom_boxplot()
ggplot(donnees, aes(x = roi, y = value, fill = condition)) + geom_boxplot()

res <- lmer(value ~ condition*roi + (1|subID), data = donnees)
plot(res) # homoscedasticity fine

qqnorm(residuals(res)) 
qqline(residuals(res))
qqnorm(ranef(res)$subID[,1])
qqline(ranef(res)$subID[,1])
# residuals fine

# multiple comparisons 
multComp <- contrast(emmeans(res, ~condition:roi), method = "pairwise", simple = "each", combine = TRUE, adjust = "holm")
plot(multComp) + 
  geom_vline(xintercept = 0, linetype = "dotted")

emmip(res, condition ~ roi, CIs = TRUE)
emmip(res, roi ~ condition | condition, CIs = TRUE)
