setwd("/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/decoding_pseudoRuns")

# Remove all variables
rm(list = ls())

library(openxlsx) # import excel file
library(reshape2) # reshape data 
library(ggplot2) # plots
library(lmerTest) # linear mixed model
library(emmeans) # multiple comparisons

donnees <- read.xlsx("acrossHand_anatExt_forLmm.xlsx")
donnees$subID <- factor(donnees$subID)

donnees <- melt(donnees)
donnees$FoR <- sub("_.*", "", donnees$variable)
donnees$ROI <- sub(".*_", "", donnees$variable)

#write.xlsx(donnees, file = "acrossHand_anatExt_longFormat.xlsx")
donnees <- read.xlsx("acrossHand_anatExt_longFormat.xlsx")

#donnees$ROI <- factor(donnees$ROI, levels = c("lS1", "lMTt", "rMTt","lhMT", "rhMT"))
ggplot(donnees, aes(x = ROI, y = value, fill = FoR)) + geom_boxplot()

res <- lmer(value ~ ROI*FoR + (1|subID), data = donnees)
plot(res) # homoscedasticity fine

qqnorm(residuals(res)) 
qqline(residuals(res))
qqnorm(ranef(res)$subID[,1])
qqline(ranef(res)$subID[,1])
# residuals fine

# multiple comparisons 
multComp <- contrast(emmeans(res, ~ROI:FoR), method = "pairwise", simple = "each", combine = TRUE, adjust = "holm")
plot(multComp) + 
  geom_vline(xintercept = 0, linetype = "dotted")

## Pair wise comparison
emmip(res, FoR ~ ROI, CIs = TRUE)
emmip(res, ROI ~ FoR | ROI, CIs = TRUE)

anova(res, ddf = "Kenward-Roger")

## EFFECT SIZE
#res_anova <- anova(res)
res_anova <- anova(res, ddf = "Kenward-Roger")

library(effectsize)
effect_size <- F_to_omega2(res_anova$`F value`, res_anova$NumDF, res_anova$DenDF)

data.frame("Variables and interactions" = rownames(res_anova), effect_size[-2])


## paired t-test - done in MATLAB and check for multicomp again here using R
#p.adjust.methods
# c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY",
#   "fdr", "none")
#pVal=c(0.0005,0.6520,0.1945,0.7760,0.1850)
#p.adjust(pVal, method = "holm", n = length(pVal))

