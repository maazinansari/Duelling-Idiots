library(magrittr)
library(ztable)
chambers = 6
haxis = 1:chambers
duelists = c("A", "B")
colors = c(A = "red", B = "blue")
hlabel = sapply(haxis, function(x) rep(duelists[1 - x %% 2 + 1], x)) %>% unlist
col_colors = colors[hlabel]

#                     A  B  B  A  A  A  B  B  B  B  A  A  A  A  A  B  B  B  B  B  B
numerators =   list(c(1),
                    c(5, 5, 4, 1),
                    c(5, 5, 4, 5, 1),
                    c(5, 5, 4, 5, 4, 1),
                    c(5, 5, 4, 5, 4, 3, 5, 4, 3, 2, 1),
                    c(5, 5, 4, 5, 4, 3, 5, 4, 3, 2, 5, 1),
                    c(5, 5, 4, 5, 4, 3, 5, 4, 3, 2, 5, 4, 1),
                    c(5, 5, 4, 5, 4, 3, 5, 4, 3, 2, 5, 4, 3, 1),
                    c(5, 5, 4, 5, 4, 3, 5, 4, 3, 2, 5, 4, 3, 2, 1))
#                     A  B  B  A  A  A  B  B  B  B  A  A  A  A  A  B  B  B  B  B  B
get_denom = function(num) {
    ifelse(num == 1, 0, num + 1)
}
denominators = lapply(numerators, get_denom)
replace_0s = c(6, 6, 5, 4, 6, 5, 4, 3, 2)
# change 0s to replace_0s
for (i in 1:length(denominators)) {
    denominators[[i]] = replace(x = denominators[[i]],
                                list = which(denominators[[i]] == 0),
                                values = replace_0s[i])
}

# table ----
outcomes = length(numerators)
numerators = lapply(numerators, `length<-`, length(hlabel)) %>% 
    unlist %>% 
    matrix(nrow = outcomes, byrow = TRUE)

denominators = lapply(denominators, `length<-`,length(hlabel)) %>% 
    unlist %>% 
    matrix(nrow = outcomes, byrow = TRUE)

output = mapply(paste, numerators, denominators,
                MoreArgs = list(sep = "/"), SIMPLIFY = TRUE) %>% 
    matrix(nrow = outcomes) %>%
    sub(pattern = "NA/NA", replacement = "")

rownames(output) = paste("Outcome", 1:outcomes)
colnames(output) = paste(" ", hlabel, " ")
z = ztable(output)
z = addColColor(z, which(hlabel =="A") + 1, colors["A"])
z = addColColor(z, which(hlabel =="B") + 1, colors["B"])
z
# solve ----
probs = mapply("/", numerators, denominators, SIMPLIFY = TRUE) %>% 
    matrix(nrow = outcomes)
total_prob = apply(probs, 1, prod, na.rm = TRUE) %>% sum()
