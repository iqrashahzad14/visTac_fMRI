setwd("/Volumes/IqraMacFmri/visTac/fMRI_analysis/outputs/derivatives/decoding_pseudoRuns")

#The one sample t-test has four main assumptions:
#The dependent variable must be continuous (interval/ratio).
#The observations are independent of one another.
#The dependent variable should be approximately normally distributed.
#The dependent variable should not contain any outliers.

# shapiro
# H0: normal distribution; H1: not a normal distribution
# ???? are our data compatible with normal distribution
#to reject H0 and accept H1, we should have p<0.05
#to accept H0 and reject H1, we should have p>0.05 => it is normal

# Remove all variables
rm(list = ls())

####
#myData <- read.xlsx("visDir.xlsx")
#myData <- read.xlsx("acrossHand_anatExt.xlsx")
myData <- read.xlsx("crossMod_Ext_both.xlsx")
#myData <- read.xlsx("crossMod_Anat_both.xlsx")

####

# Initialize empty lists to store results
shapiro_p_values <- list()

# Set up the layout for multiple plots
par(mfrow = c(2, 3))  # 2 rows, 3 columns

# Loop through each column
for (col in colnames(myData)) {
  # Shapiro-Wilk test for normality
  shapiro_test_result <- shapiro.test(myData[[col]])
  shapiro_p_value <- shapiro_test_result$p.value
  
  # Store Shapiro-Wilk p-value
  shapiro_p_values[[col]] <- shapiro_p_value
  
  # Create a QQ plot for the current column
  qqnorm(myData[[col]], main = paste("QQ Plot for", col))
  qqline(myData[[col]])
}

# Combine results into a data frame
results <- data.frame(
  Column = colnames(myData),
  Shapiro_p_value = unlist(shapiro_p_values)
  )

# Print results
print(results)

# Reset the layout to default
par(mfrow = c(1, 1))

