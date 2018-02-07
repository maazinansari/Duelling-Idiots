S = 0                           # initialize finite geometric series sum that appears in each term
Ttl = 1                         # the first term in the brackets for P(A)
r = 5/6                         
e = 3                           # starting value of exponent in the factor that multiplies
                                # the finite geometric series
incr = 7                        # initial amount to be added to exponent to get next exponent
startp = 0                      # initial value of power in the first term of
                                # present finite geometric series
stopp = 2                       # initial value of power in the last term of
                                # present finite geometric series
            
for (k in 1:30) {               # the '30' is arbitrarily picked to be
                                # sufficiently large to see convergence
    for (i in startp:stopp) {   # form finite geometric sum from old sum by
                                # adding on two new terms (the FIRST sum has THREE terms
        S = S + r^i
    }
    
    M = r^e                     # factor to multiply geometric series
    Ttl_ = Ttl + M * S          # multiply and add to total
    if (Ttl_ - Ttl < 1e-9) break
    Ttl = Ttl_
    startp = stopp + 1          # update starting power for new terms to add to old sum
    stopp = startp + 1          # update final power for new terms to add to old sum
    e = e + incr                # update exponent of factor to multiply with new geometric series
    incr = incr + 4             # update exponent increment
    # print(Ttl/6)                # check for convergence
}
