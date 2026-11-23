# Setup
library(lmtest)
library(sandwich)

# complete case analysis as agreed in the protocol: drop residents with any missing value => i do it here but maube cleaner in the data split sript?
train <- readRDS("train.rds")



# Complete cases
# outcome + the 5 covariates from our protocol
vars <- c("Demqol_staff", "visit", "agecat", "marital3cat",
          "npi_symptoms_0", "chc_04")
train_cc <- train[complete.cases(train[, vars]), ]



# Crude model
# first look at the data: QOL per visit group
boxplot(Demqol_staff ~ visit, data = train_cc,
        xlab = "Family carer visits per month",
        ylab = "Staff DEMQOL at 8 months")

#simple regression with only visits (protocol: simple model, 1 covariate)
#summary + confint give the beta, 95% CI and p-value we need in the report
m_crude <- lm(Demqol_staff ~ visit, data = train_cc)
summary(m_crude)
confint(m_crude)



# Main-effects model
# multivariable model with all 5 covariates
# drop1 does an F-test per covariate
m_main <- lm(Demqol_staff ~ visit + agecat + marital3cat + npi_symptoms_0 + chc_04,
             data = train_cc)
summary(m_main)
confint(m_main)
drop1(m_main, test = "F")

# crude vs adjusted: each column is the effect of a visit group vs "no visits",
# once raw and once holding the other covariates constant.
# if the numbers differ, the groups were not comparable to begin with => confounding
round(cbind(crude = coef(m_crude)[2:5], adjusted = coef(m_main)[2:5]), 2)




# Interaction model
# widowed = largest group -> reference level (only 4 married residents have no visits)
# refit main model with the new reference
# interaction: visit * marital3cat (= mains + 8 interaction terms)
train_cc$marital3cat <- relevel(train_cc$marital3cat, ref = "widowed")
m_main <- update(m_main, data = train_cc)

m_int <- lm(Demqol_staff ~ visit * marital3cat + agecat + npi_symptoms_0 + chc_04,
            data = train_cc)
anova(m_main, m_int)



# Final model
m_final <- m_int
summary(m_final)
confint(m_final)

# Assumption checks
#NOT DONE YET

# Outliers and influential points
#NOT DONE YET

# Test data

# Results
s <- summary(m_final)
results <- list(
  model = m_final,
  coefs = cbind(s$coefficients, confint(m_final)),   # beta, SE, t, p, 95% CI
  fit   = c(n = nobs(m_final), R2 = s$r.squared, adjR2 = s$adj.r.squared,
            sigma = s$sigma, s$fstatistic)
)

saveRDS(results, "results.rds")
