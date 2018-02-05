# The elements of 'duration' are the number of duels of length k,
# i.e. duration[k] = # of duels that require k trigger-pulls to complete, where k = 1, 2, 3, ...

set.seed(Sys.time())
Duels = 10000           # total number of duels
duration = rep(0, 60)   # assume no duels exceed 60 trigger pulls
a = 0                   # number of times A has won, so far
nd = 0                  # number of duels completed, so far
tp = 0                  # number of trigger-pulls, so far, in present duel

while (nd < Duels) {
    ra = runif(1)
    rb = runif(1)
    tp = tp + 1         # A pulls trigger
    if (ra <= 1/6) {    # A wins
        duration[tp] = duration[tp] + 1 # duel is over, update 'duration'
        tp = 0          # initialize number of trigger-pulls for the next duel
        a = a + 1
        nd = nd + 1
    }
    else {
        tp = tp + 1     # B pulls trigger
        if (rb <= 1/6) {    # B wins
            duration[tp] = duration[tp] + 1
            tp = 0
            nd = nd + 1
        }
    }
}

a = a / Duels
paste("The probability A wins is", a)
k = 1:length(duration)
average = sum(k * duration[k], na.rm = TRUE) / Duels
paste("The average number of trigger-pulls/duel is", average)
barplot(duration,
        main = "Relative frequency of the number of trigger-pulls per duel",
        xlab = "Duration of duels (number of trigger-pulls)",
        ylab = "Number of duels",
        xlim = c(0,60),
        ylim = c(0, 2000),
        col = rep(1:2, length.out = 60))
legend("topright", c("A wins", "B wins"), fill = 1:2)
axis(side = 1, 1:60)
    