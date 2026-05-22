-- ==========================================
-- STEP 1: RELATIONAL DATABASE MODELING
-- ==========================================
CREATE TABLE staging_credit_risk (
    person_age INT,
    person_income NUMERIC(12,2),
    person_home_ownership VARCHAR(20),
    person_emp_length NUMERIC(4,1),
    loan_intent VARCHAR(50),
    loan_grade VARCHAR(5),
    loan_amnt NUMERIC(12,2),
    loan_int_rate NUMERIC(5,2),
    loan_status INT, 
    loan_percent_income NUMERIC(4,2),
    cb_person_default_on_file VARCHAR(5),
    cb_person_cred_hist_length INT
);

-- Verification and Staging Quality Check
SELECT 
    loan_status, 
    COUNT(*) as total_records,
    ROUND(AVG(loan_percent_income), 2) as avg_dti,
    ROUND(AVG(loan_amnt), 2) as avg_loan_size
FROM staging_credit_risk
GROUP BY loan_status;
