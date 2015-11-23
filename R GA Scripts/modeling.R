

#install.packages('genalg')
library(genalg)
library(ggplot2)



#setwd("C:/Users/IBM_ADMIN/Google Drive/_School Docs/CSC578 - ML and NN/Final Project")
setwd("C:/Users/IBM_ADMIN/Documents/Github/Genetic_Algorithms_Football/Example Datasets/Week 11")
df <- read.csv("week11-full.csv")

# #removed 0 or low scoring players
# df <- read.csv("score-salary-position-11-10-filtered.csv")
# #adjusted projected points based on star/sit research.. human +GA
# df <- read.csv("score-salary-position-11-10-filtered-human-values.csv")
# 
# #values adjusted Saturday night and Sunday morning
# df <- read.csv("score-salary-position-sunday-values.csv")
df[1:5,]

#scatterplot
#ggplot(dkdata,aes(x=AvgPointsPerGame, y = Salary, colour = Position,shape=Position))+geom_point(size=2.5)


#Get indices of player positions
TE_ind <- which(df[4]=='TE') 
QB_ind <- which(df[4]=='QB') 
RB_ind <- which(df[4]=='RB')
WR_ind <- which(df[4]=='WR')
DEF_ind <- which(df[4]=='DST')#DEF_ind <- which(df[4]=='Defense')


#update eval function to check for total number of players and types of players


evalFunc <- function(x) {
  team_ind <- which(x==1)
  current_solution_points <- sum(df[team_ind,2])
  current_solution_weight <- sum(df[team_ind,3])
#   print(current_solution_weight)
#   print(current_solution_points)

   if(current_solution_weight > sal.limit) return(abs(50000 - current_solution_weight))
   if(sum(x) != 9 )  return(200*(abs(sum(x)-9)))
   if(sum(x[QB_ind]) >1|| sum(x[DEF_ind]) >1 )   return(500)
   if(sum(x[TE_ind]) == 2 && (sum(x[RB_ind]) >2 || sum(x[WR_ind]) >3)) {return(sum(x[TE_ind])*50)}
   if(sum(x[WR_ind]) == 4 && (sum(x[RB_ind]) >2 || sum(x[TE_ind]) >1)) {return(sum(x[WR_ind])*50)}
   if(sum(x[WR_ind]) > 4  || (sum(x[RB_ind]) >3 || sum(x[TE_ind]) >2)) {return(sum(x[WR_ind])*50)}
   return(-current_solution_points)
}



#Model building
iter = 500
player_size <- length(df[,1])
#Salary Limit from DK
sal.limit <- 50000


GAmodel <- rbga.bin(size = player_size, popSize = 500, iters = iter, mutationChance = 0.01,  evalFunc = evalFunc)



cat(genalg:::summary.rbga(GAmodel,echo=T))
