set.seed(20180204)

# Flip a coin once
## If heads: Answer the question truthfully (yes or no)
## If tails: Flip again
### If heads: yes
### If tails: no

# Results: 6230 yes, 3770 no
# P(heads first) = P(tail first) = 0.5
# P(heads second) = P(tails first) * P(heads second) = 0.25
# P(tails second)
# Find P(EQ = yes) = P(yes | heads first)
# P(yes) = P(yes and heads first) + P(heads second) 
#        = 0.5*p + 0.25 = 6230/10000
# p = 0.746

simulate_EQ = function(p = 0.746, N = 10000) {
    pop = sample(c("yes", "no"), size = N, prob = c(p, 1-p), replace = TRUE)
    results = rep("no", N)
    for (i in 1:N) {
        flip1 = rbinom(1, size = 1, p = 0.5) # 1 = heads, 0 = tails
        if (flip1) results[i] = pop[i]
        else {
            flip2 = rbinom(1, size = 1, p = 0.5)
            if (flip2) results[i] = "yes"
        }
    }
    return(results)
}

sum(simulate_EQ() == "yes") # approx. 6230
