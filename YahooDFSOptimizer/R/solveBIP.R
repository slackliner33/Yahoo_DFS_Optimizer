#' Optimize function
#'
#' This function generates 10 best lineups based off the Rotowire NBA DFS
#' predictions for the given day of NBA games
#' @param Defaults to TRUE
#' @keywords
#' @export
#' @examples
#' generateLineups()

generateLineups <- function(){

#Restructures data and preps for Binary IP
PG <- DFS_Data[which(DFS_Data$Position == "PG"),]
SG <- DFS_Data[which(DFS_Data$Position == "SG"),]
SF <- DFS_Data[which(DFS_Data$Position == "SF"),]
PF <- DFS_Data[which(DFS_Data$Position == "PF"),]
C <- DFS_Data[which(DFS_Data$Position == "C"), ]
DFS <- rbind(PG,SG,SF,PF,C)
DFS_len <- nrow(DFS)
PG_len <- nrow(PG)
SG_len <- nrow(SG)
SF_len <- nrow(SF)
PF_len <- nrow(PF)
C_len <- nrow(C)

#creation of constraint matrix
row1 <- rep(0, DFS_len)
row1[1:PG_len] <- 1
row2 <- rep(0, DFS_len)
row2[(PG_len+1):(PG_len+SG_len)] <- 1
row3 <- rep(0, DFS_len)
row3[1:(PG_len+SG_len)] <- 1
row4 <- rep(0, DFS_len)
row4[(PG_len+SG_len+1):(PG_len+SG_len+SF_len)] <- 1
row5 <- rep(0, DFS_len)
row5[(PG_len+SG_len+SF_len+1):(PG_len+SG_len+SF_len+PF_len)] <- 1
row6 <- rep(0, DFS_len)
row6[(PG_len+SG_len+1):(PG_len+SG_len+SF_len+PF_len)] <- 1
row7 <- rep(0, DFS_len)
row7[(PG_len+SG_len+SF_len+PF_len+1):DFS_len] <- 1
row8 <- rep(1,DFS_len)
row9 <- DFS$Salary

#IP model set-up / solving
constraints <- matrix(rbind(row1,row2,row3,row4,row5,row6,row7,row8,row9), nrow = 9, byrow = FALSE)
obj_fn <- DFS$Projection
RHS <- c(1,1,3,1,1,3,1,8,200)
ineq <- c(">=", ">=", ">=", ">=", ">=", ">=",">=","=","<=")

my_lp <- lp("max", obj_fn, constraints, ineq, RHS,
                        compute.sens = TRUE, all.bin=TRUE)
#   results

#my_lp
#my_lp$solution

#my_lp$num.bin.solns

soln_vec <- my_lp$solution

opt_pos <- c("PG","SG","G","SF","PF","F","C","U")
opt_name <- rep("name", 8)

Players <- DFS$Name

#matches IP solution to specific player names
counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup) <- c("Position", "Name")

#addition of constraint (optimal - 0.1) to force IP to select next best
#solution... Iterative process /code to generate next 9 lineups
best_val <- round(my_lp$objval,1)
new_limit <- best_val - 0.1

RHS_2 <- c(RHS,new_limit)
row10 <- DFS$Projection
constraints2 <- matrix(rbind(row1,row2,row3,row4,row5,row6,row7,row8,row9,row10), nrow = 10, byrow = FALSE)
ineq2 <- c(">=", ">=", ">=", ">=", ">=", ">=",">=","=","<=","<=")

my_lp2 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
            compute.sens = TRUE, all.bin=TRUE)
#my_lp2
#my_lp2$solution

#my_lp2$num.bin.solns

soln_vec <- my_lp2$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup2 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup2) <- c("Position", "Name")

best_val2 <- round(my_lp2$objval,1)
RHS_2[10] <- best_val2 - 0.1

my_lp3 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#my_lp3
#my_lp3$solution
#my_lp3$num.bin.solns

soln_vec <- my_lp3$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup3 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup3) <- c("Position", "Name")

best_val3 <- round(my_lp3$objval,1)
RHS_2[10] <- best_val3 - 0.1

my_lp4 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#my_lp4
#my_lp4$solution
#my_lp4$num.bin.solns

soln_vec <- my_lp4$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup4 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup4) <- c("Position", "Name")

best_val4 <- round(my_lp4$objval,1)
RHS_2[10] <- best_val4 - 0.1

my_lp5 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#my_lp5
#my_lp5$solution
#my_lp5$num.bin.solns

soln_vec <- my_lp5$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup5 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup5) <- c("Position", "Name")

best_val5 <- round(my_lp5$objval,1)
RHS_2[10] <- best_val5 - 0.1

my_lp6 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#my_lp6
#my_lp6$solution
#my_lp6$num.bin.solns

soln_vec <- my_lp6$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup6 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup6) <- c("Position", "Name")

best_val6 <- round(my_lp6$objval,1)
RHS_2[10] <- best_val6 - 0.1

my_lp7 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#my_lp7
#my_lp7$solution
#my_lp7$num.bin.solns

soln_vec <- my_lp7$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup7 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup7) <- c("Position", "Name")

best_val7 <- round(my_lp7$objval,1)
RHS_2[10] <- best_val7 - 0.1

my_lp8 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#my_lp8
#my_lp8$solution
#my_lp8$num.bin.solns

soln_vec <- my_lp8$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup8 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup8) <- c("Position", "Name")

best_val8 <- round(my_lp8$objval, 1)
RHS_2[10] <- best_val8 - 0.1

my_lp9 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#my_lp9
#my_lp9$solution
#my_lp9$num.bin.solns

soln_vec <- my_lp9$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup9 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup9) <- c("Position", "Name")

best_val9 <- round(my_lp9$objval,1)
RHS_2[10] <- best_val9 - 0.1

my_lp10 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#my_lp10
#my_lp10$solution
#my_lp10$num.bin.solns
best_val10<- round(my_lp10$objval,1)

soln_vec <- my_lp10$solution

counter <- 1
for (i in 1:length(soln_vec)) {
  if (soln_vec[i]==1) {
    opt_name[counter] <- Players[i]
    counter <- counter + 1
    next
  }
}
optimal_lineup10 <- as.data.frame(cbind(opt_pos,opt_name))
colnames(optimal_lineup10) <- c("Position", "Name")

#determining costs of each line-up
cost <- sum(my_lp$solution*row9)
cost2 <- sum(my_lp2$solution*row9)
cost3 <- sum(my_lp3$solution*row9)
cost4<- sum(my_lp4$solution*row9)
cost5<- sum(my_lp5$solution*row9)
cost6 <- sum(my_lp6$solution*row9)
cost7 <- sum(my_lp7$solution*row9)
cost8 <- sum(my_lp8$solution*row9)
cost9<- sum(my_lp9$solution*row9)
cost10<- sum(my_lp10$solution*row9)


#FINAL RESULTS, OUTPUT
#optimal Yahoo line-ups (top 10)

Best_10_Lineups <- cbind(optimal_lineup,optimal_lineup2$Name,optimal_lineup3$Name,
      optimal_lineup4$Name,optimal_lineup5$Name,optimal_lineup6$Name,
      optimal_lineup7$Name,optimal_lineup8$Name,optimal_lineup9$Name,
      optimal_lineup10$Name)
colnames(Best_10_Lineups) <- (c("Position","Optimal","2nd Best","3rd Best",
                                "4th Best","5th Best","6th Best","7th Best",
                                "8th Best","9th Best", "10th Best"))
projected_totals <- as.data.frame(t(c("Proj Pts",best_val,best_val2,best_val3,best_val4,best_val5,
                      best_val6,best_val7,best_val8,best_val9,best_val10)))
costs <- as.data.frame(t(c("Cost $",cost,cost2,cost3,cost4,cost5,cost6,cost7,cost8,cost9, cost10)))
colnames(projected_totals) <- (c("Position","Optimal","2nd Best","3rd Best",
                                 "4th Best","5th Best","6th Best","7th Best",
                                 "8th Best","9th Best", "10th Best"))
colnames(costs) <- (c("Position","Optimal","2nd Best","3rd Best",
                                 "4th Best","5th Best","6th Best","7th Best",
                                 "8th Best","9th Best", "10th Best"))

Best_10_Lineups <- rbind(Best_10_Lineups,projected_totals,costs)

Best_10_Lineups <<- Best_10_Lineups

}
