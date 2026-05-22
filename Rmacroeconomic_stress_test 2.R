# ==========================================
# FULL UNIFIED R MACROECONOMIC STRESS TEST
# ==========================================
set.seed(42)
n_samples <- 6516 
actual_defaults <- rbinom(n_samples, 1, 0.218) 

# Generate baseline risk probabilities
pred_prob_baseline <- runif(n_samples, 0, 0.9) * actual_defaults + runif(n_samples, 0, 0.3) * (1 - actual_defaults)

# Apply 14% Automated Cutoff Rule
threshold <- 0.14
approvals_baseline <- ifelse(pred_prob_baseline < threshold, 1, 0)
bad_debt_baseline <- sum(approvals_baseline == 1 & actual_defaults == 1)

# Apply 15% Macroeconomic Shock
pred_prob_shock <- pmin(pmax(pred_prob_baseline * 1.15, 0), 1)
approvals_shock <- ifelse(pred_prob_shock < threshold, 1, 0)
bad_debt_shock <- sum(approvals_shock == 1 & actual_defaults == 1)

# Calculate Capital Impact Percentage
capital_erosion_increase <- ((bad_debt_shock - bad_debt_baseline) / bad_debt_baseline) * 100

# Print Results
cat("=========================================\n")
cat("       R PORTFOLIO STRESS TEST RESULTS   \n")
cat("=========================================\n")
cat("Baseline Bad Debt Instances: ", bad_debt_baseline, "\n")
cat("Shock Scenario Bad Debt Instances: ", bad_debt_shock, "\n")
cat("Portfolio Capital Degradation Spike: +", round(capital_erosion_increase, 2), "%\n")
cat("=========================================\n")
cat("=========================================\n")
cat("       R PORTFOLIO STRESS TEST RESULTS   \n")
cat("=========================================\n")
cat("Baseline Bad Debt Instances: ", bad_debt_baseline, "\n")
cat("Shock Scenario Bad Debt Instances: ", bad_debt_shock, "\n")
cat("Portfolio Capital Degradation Spike: +", round(capital_erosion_increase, 2), "%\n")
cat("=========================================\n")


