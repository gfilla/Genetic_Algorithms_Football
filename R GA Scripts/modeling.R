

#install.packages('genalg')
library(genalg)
library(ggplot2)
library(XML)
library(reshape2)


setwd("C:/Users/IBM_ADMIN/Google Drive/_School Docs/CSC578 - ML and NN/Final Project")
df <- read.csv("score-salary-position-11-10.csv")

#removed 0 or low scoring players
df <- read.csv("score-salary-position-11-10-filtered.csv")
#adjusted projected points based on star/sit research.. human +GA
df <- read.csv("score-salary-position-11-10-filtered-human-values.csv")

#values adjusted Saturday night and Sunday morning
df <- read.csv("score-salary-position-sunday-values.csv")
df[1:5,]

#scatterplot
ggplot(dkdata,aes(x=AvgPointsPerGame, y = Salary, colour = Position,shape=Position))+geom_point(size=2.5)

#Get indices of player positions
TE_ind <- which(df[4]=='TE') 
QB_ind <- which(df[4]=='QB') 
RB_ind <- which(df[4]=='RB')
WR_ind <- which(df[4]=='WR')
DEF_ind <- which(df[4]=='Defense')


#update eval function to check for total number of players and types of players


evalFunc <- function(x) {
  team_ind <- which(x==1)
  current_solution_points <- sum(df[team_ind,2])
  current_solution_weight <- sum(df[team_ind,3])
#   print(current_solution_weight)
#   print(current_solution_points)

   if(current_solution_weight > sal.limit) return(abs(50000 - current_solution_weight))
  #print('1')
   if(sum(x) != 9 )  return(100)
  #print('2')
   if(sum(x[QB_ind]) >1|| sum(x[DEF_ind]) >1 )   return(sum(x[DEF_ind])*100 +sum(x[QB_ind]) ) 
  #print('3')
   if(sum(x[TE_ind]) == 2 && (sum(x[RB_ind]) >2 || sum(x[WR_ind]) >3)) {return(sum(x[TE_ind])*50)}
  #print('4')
   if(sum(x[WR_ind]) == 4 && (sum(x[RB_ind]) >2 || sum(x[TE_ind]) >1)) {return(50)}
  #print('5')
   if(sum(x[WR_ind]) > 4  || (sum(x[RB_ind]) >3 || sum(x[TE_ind]) >2)) {return(50)}
  #print('6')
  #print(current_solution_points)
   return(-current_solution_points)#    return(-current_solution_survivalpoints)
}



#Model building
iter = 500
player_size <- length(df[,1])
#Salary Limit from DK
sal.limit <- 50000


GAmodel <- rbga.bin(size = player_size, popSize = 500, iters = iter, mutationChance = 0.01, 
                    elitism = T, evalFunc = evalFunc)


bestSolution<-GAmodel$population[which.min(GAmodel$evaluations),]
best_ind <- which(bestSolution==1)
df[best_ind,]
sum(df[best_ind,2])
sum(df[best_ind,3])

cat(genalg:::summary.rbga(GAmodel,echo=T))
# sum(GAmodel$best)
# GAmodel$best

# 
# animate_plot <- function(x) {
#   for (i in seq(1, iter)) {
# i = 1
#         temp <- data.frame(Generation = c(seq(1, i), seq(1, i)), Variable = c(rep("mean", 
#                                                                               i), rep("best", i)), fantasyPts = c(-GAmodel$mean[1:i], -GAmodel$best[1:i]))
#     
#     pl <- ggplot(temp, aes(x = Generation, y = Survivalpoints, group = Variable, 
#           colour = Variable)) + geom_line() + scale_x_continuous(limits = c(0,iter)) + 
#           scale_y_continuous(limits = c(0, 110)) + geom_hline(y = max(temp$fantasyPts),       
#                   lty = 2) + annotate("text", x = 1, y = max(temp$fantasyPts) + 2,
#                 hjust = 0, size = 3, color = "black", label = paste("Best solution:", 
#                 max(temp$fantasyPts))) + scale_colour_brewer(palette = "Set1") 
#         + theme(title = "Evolution Fantasy Football Optimization Model")
#     
#     print(pl)
#   }
# }
# 
# install.packages('animation')
# 
# library(animation)
# saveGIF(animate_plot(),movie.name='ga.gif', interval = 0.1, outdir = getwd())
# saveMovie(expr, movie.name = "animation.gif", img.name = "Rplot", convert = "convert", 
#           cmd.fun = system, clean = TRUE, ...)
# 
# 
# animate_plot <- function(x) {
#   for (i in seq(1, iter)) {
# i <- 1
#      temp <- data.frame(Generation = c(seq(1, i), seq(1, i)), Variable = c(rep("mean", 
#                                                                               i), rep("best", i)), Survivalpoints = c(-GAmodel$mean[1:i], -GAmodel$best[1:i]))
#     
#     pl <- ggplot(temp, aes(x = Generation, y = Survivalpoints, group = Variable, colour = Variable)) 
#     pl <- pl + geom_line() + scale_x_continuous(limits = c(0,iter)) + scale_y_continuous(limits = c(0, 110)) + geom_hline(y = max(temp$Survivalpoints), lty = 2) + annotate("text", x = 1, y = max(temp$Survivalpoints) + 2, hjust = 0, size = 3, color = "black", label = paste("Best solution:",   max(temp$Survivalpoints))) + scale_colour_brewer(palette = "Set1") 
#      
#     
#     print(pl)
#   }
# }
# 
# # in order to save the animation
# library(animation)
# saveGIF(animate_plot(),movie.name='ga.gif', interval = 0.1, outdir = getwd())
