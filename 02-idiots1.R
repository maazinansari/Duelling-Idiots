set.seed(20180204)

# one duel ----
did_fire = function() {
    shot = sample(x = 6, size = 1, replace = FALSE)
    return(shot == 1)
}
    
duel = function(shooters = c("A", "B")) {
    turn = 1
    nshooters = length(shooters)
    
    # repeat until a shot is fired
    while (TRUE) {
        # first shooter is A (2 - 1 mod 2 = 1)
        # second shooter is B (2 - 2 mod 2 = 2)
        shooter = shooters[nshooters - turn %% nshooters]
        
        # pull trigger
        if ( did_fire() ) {
            return(list(shooter, turn))
            break
        } 
        # pass gun to next shooter
        else {
            turn = turn + 1
        }
    }
}

# simulate many duels ----
N = 10000

# result is 2 x N matrix. Row 1 is winner. Row 2 is number of turns.
simulations = as.array(replicate(N, duel(), simplify = TRUE))

# results ----
# How many times A won
mean(simulations[1,] == "A")

# Average number of turns 
mean(unlist(simulations[2,]))

# for A
simulations[1,] == "A" 

system.time(source("nahin-R/02-idiots1.R"))
system.time(replicate(N, duel(), simplify = TRUE))
