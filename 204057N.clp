;; Rule 1 - Check the credit score

(defrule credit-score
   (or (start))
   =>
   (printout t crlf crlf "What is the applicant's credit score?" 
               crlf "  1. Excellent (750 and above)" 
               crlf "  2. Good (700-749)"
               crlf "  3. Fair (650-699)"
               crlf "  4. Poor (below 650)"
               crlf crlf "Answer (1 | 2 | 3 | 4 ): ")
   (assert (credit-score (read)))
)

;; Rule 2 - Annual Income

(defrule annual-income
   (credit-score 1)
   =>
   (printout t crlf crlf "What is the applicant's annual income?" 
                  crlf "  1. High income (above $100,000)" 
                  crlf "  2. Moderate income ($50,000 - $100,000)"
                  crlf "  3. Low income (below $50,000)"
                  crlf crlf "Answer (1 | 2 | 3 ): ")
   (assert (annual-income (read)))
)

;; Rule 3 - Employment status

(defrule employment-status
   (credit-score 2)
   =>
   (printout t crlf crlf "What is the applicant's employment status?" 
                  crlf "  1. Employed" 
                  crlf "  2. Unemployed"
                  crlf crlf "Answer (1 | 2 ): ")
   (assert (employment-status (read)))
)

;; Rule 4 - Co-signer or Collateral

(defrule co-signer
   (or (credit-score 3)
       (employment-status 2))
   =>
   (printout t crlf crlf "Does the applicant have a co-signer or collateral?" 
                  crlf "  1. Yes" 
                  crlf "  2. No"
                  crlf crlf "Answer (1 | 2 ): ")
   (assert (co-signer (read)))
)

;; Rule 5 - Stable Employment History

(defrule stable-employment-history
   (or (co-signer 2)
       (employment-status 1))
   =>
   (printout t crlf crlf "Does the applicant have a stable employment history?" 
                  crlf "  1. Yes" 
                  crlf "  2. No"
                  crlf crlf "Answer (1 | 2 ): ")
   (assert (stable-employment-history (read)))
)

;; Rule 6 - Time with Current Employer

(defrule time-with-current-employer
   (or (employment-status 1)
       (stable-employment-history 2)
       (credit-score 4))
   =>
   (printout t crlf crlf "How long has the applicant been employed with the current employer?" 
                  crlf "  1. More than 2 years" 
                  crlf "  2. 1-2 years"
                  crlf "  3. Less than 1 year"
                  crlf crlf "Answer (1 | 2 | 3 ): ")
   (assert (time-with-current-employer (read)))
)

;; Rule 7 - Late Payments or Defaults

(defrule late-payments
   (or (time-with-current-employer 3)
       (stable-employment-history 1))
   =>
   (printout t crlf crlf "Has the applicant had any recent late payments or defaults?" 
                  crlf "  1. No late payments or defaults" 
                  crlf "  2. Recent late payments or defaults"
                  crlf crlf "Answer (1 | 2 ): ")
   (assert (late-payments (read)))
)

;; Rule 8 - Debt-to-Income Ratio

(defrule debt-to-income
   (or (annual-income 3)
       (late-payments 2))
   =>
   (printout t crlf crlf "What is the debt-to-income ratio of the applicant?" 
                  crlf "  1. Low (below 30%)" 
                  crlf "  2. Moderate (30% - 40%)"
                  crlf "  3. High (above 40%)"
                  crlf crlf "Answer (1 | 2 | 3 ): ")
   (assert (debt-to-income (read)))
)

;; Rule 9 - Repayment Capacity

(defrule repayment-capacity
   (or (debt-to-income 2)
       (late-payments 1))
   =>
   (printout t crlf crlf "Is the loan amount within the applicant's repayment capacity?" 
                  crlf "  1. Yes" 
                  crlf "  2. No"
                  crlf crlf "Answer (1 | 2 ): ")
   (assert (repayment-capacity (read)))
)

;; Rule 10 - Bankruptcy History

(defrule bankruptcy-history
   (repayment-capacity 2)
   =>
   (printout t crlf crlf "Does the applicant have a history of bankruptcy?" 
                  crlf "  1. Yes" 
                  crlf "  2. No"
                  crlf crlf "Answer (1 | 2 ): ")
   (assert (bankruptcy-history (read)))
)

;; Rule 11 - Approval

(defrule approve
   (or (annual-income 1)
       (time-with-current-employer 1)
       (debt-to-income 1)
       (repayment-capacity 1))
   (not (or (annual-income 2)
            (co-signer 1)
            (stable-employment-history 1)
            (time-with-current-employer 2)
            (late-payments 1)
            (bankruptcy-history 2)))
   =>
   (printout t crlf crlf crlf "  - Approve the Loan!" crlf crlf)
)

;; Rule 12 - Approval with Conditions

(defrule approve-with-conditions
   (or (annual-income 2)
       (co-signer 1)
       (stable-employment-history 1)
       (time-with-current-employer 2)
       (late-payments 1)
       (bankruptcy-history 2))
   =>
   (printout t crlf crlf crlf "  - Approve the Loan with Conditions!" crlf crlf)
)

;; Rule 13 - Deny the Loan

(defrule deny
   (or (debt-to-income 3)
       (bankruptcy-history 1))
   =>
   (printout t crlf crlf crlf "  - Deny the Loan!" crlf crlf)
)