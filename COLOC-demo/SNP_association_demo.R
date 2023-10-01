setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\COLOC-demo")

library(dplyr)
library(data.table)

# Set the seed to ensure reproducibility
set.seed(123)

# Simulate data
n <- 455  # Sample size
genotype <- sample(c(0, 1, 2), n, replace = TRUE, prob = c(0.2, 0.6, 0.2))  # Genotypes
phenotype <- rbinom(n, 1, ifelse(genotype == 2, 0.8, 0.2))  # Binary phenotype, simulated based on genotypes

# Compute β, SE, and P-value for SNP-phenotype association
model <- glm(phenotype ~ genotype, family = binomial)  # Perform logistic regression to calculate the association
beta <- coef(model)["genotype"]  # β coefficient
se <- sqrt(vcov(model)["genotype", "genotype"])  # Standard error
p_value <- summary(model)$coefficients["genotype", "Pr(>|z|)"]  # P-value

# Compute MAF for SNP
maf <- sum(genotype == 1) / (2 * n)  # MAF is the frequency of heterozygous genotypes

# Output the results
cat("β coefficient for the SNP-phenotype association:", beta, "\n")
cat("Standard error for the SNP-phenotype association:", se, "\n")
cat("P-value for the SNP-phenotype association:", p_value, "\n")
cat("MAF for the SNP:", maf, "\n")
cat("Sample size:", n, "\n")

