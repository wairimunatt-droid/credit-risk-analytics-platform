
cutoff <- 0.14


approved_mask <- scores < cutoff
total_approved <- sum(approved_mask)

# Baseline bad debt count and baseline default rate
bad_base <- sum(approved_mask & defaults == 1)
rate_base <- bad_base / total_approved

# The shock increases the systemic probability of default across our existing book
scores_shock <- pmin(scores * 1.15, 1)

# Under stress, some borrowers who looked safe now cross the default threshold
bad_shock <- sum(approved_mask & (scores_shock >= cutoff | defaults == 1))
rate_shock <- bad_shock / total_approved

# Evaluate net portfolio risk volatility 
pct_change <- ((rate_shock - rate_base) / rate_base) * 100

# --- 4. FORMAT OUTPUT METRICS ---
cat("\n=============================================\n")
cat("      MACRO STRESS-TEST PORTFOLIO ANALYSIS   \n")
cat("=============================================\n")
cat(sprintf("Baseline Portfolio Default Rate:   %.2f%%\n", rate_base * 100))
cat(sprintf("Post-Shock Portfolio Default Rate:  %.2f%%\n", rate_shock * 100))
cat(sprintf("Portfolio Default Risk Volatility:  +%.2f%%\n", pct_change))
cat("=============================================\n")
