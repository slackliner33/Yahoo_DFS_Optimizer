#BINARY INTEGER PROGRAM MODEL SET UP

require(lpSolve)
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

#model info / solving
constraints <- matrix(rbind(row1,row2,row3,row4,row5,row6,row7,row8,row9), nrow = 9, byrow = FALSE)
obj_fn <- DFS$Projection
RHS <- c(1,1,3,1,1,3,1,8,200)
ineq <- c(">=", ">=", ">=", ">=", ">=", ">=",">=","=","<=")

my_lp <- lp("max", obj_fn, constraints, ineq, RHS,
                        compute.sens = TRUE, all.bin=TRUE)
#results
my_lp
my_lp$solution

my_lp$num.bin.solns

soln_vec <- my_lp$solution

opt_pos <- c("PG","SG","G","SF","PF","F","C","U")
opt_name <- rep("name", 8)

Players <- DFS$Name

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

#optimal Yahoo answer
#optimal_lineup

best_val <- my_lp$objval
new_limit <- best_val - 0.1

RHS_2 <- c(RHS,new_limit)
row10 <- DFS$Projection
constraints2 <- matrix(rbind(row1,row2,row3,row4,row5,row6,row7,row8,row9,row10), nrow = 10, byrow = FALSE)
ineq2 <- c(">=", ">=", ">=", ">=", ">=", ">=",">=","=","<=","<=")

my_lp2 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
            compute.sens = TRUE, all.bin=TRUE)
#results
my_lp2
my_lp2$solution

my_lp2$num.bin.solns

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

best_val2 <- my_lp2$objval
RHS_2[10] <- best_val2 - 0.1

my_lp3 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#results
my_lp3
my_lp3$solution

my_lp3$num.bin.solns

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

best_val3 <- my_lp3$objval
RHS_2[10] <- best_val3 - 0.1

my_lp4 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#results
my_lp4
my_lp4$solution

my_lp4$num.bin.solns

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

best_val4 <- my_lp4$objval
RHS_2[10] <- best_val4 - 0.1

my_lp5 <- lp("max", obj_fn, constraints2, ineq2, RHS_2,
             compute.sens = TRUE, all.bin=TRUE)
#results
my_lp5
my_lp5$solution
best_val5<-my_lp5$objval

my_lp5$num.bin.solns

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

cost <- sum(my_lp$solution*row9)
cost2 <- sum(my_lp2$solution*row9)
cost3 <- sum(my_lp3$solution*row9)
cost4<- sum(my_lp4$solution*row9)
cost5<- sum(my_lp5$solution*row9)


#FINAL RESULTS
#optimal Yahoo line-ups (top 5)
optimal_lineup
best_val
cost

optimal_lineup2
best_val2
cost2

optimal_lineup3
best_val3
cost3

optimal_lineup4
best_val4
cost4

optimal_lineup5
best_val5
cost5

