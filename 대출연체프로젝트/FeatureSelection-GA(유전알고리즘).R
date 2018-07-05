setwd("C:\\Users\\acorn\\Downloads\\select")



df<-read.csv("train_1.csv", header = T)

na.omit(df)

summary(df)

sum(is.na(df))

df <- df[complete.cases(df[ , c(22,53)]), ]





#알고리즘 실행
ga_ctrl <- gafsControl(functions = rfGA, # Assess fitness with RF
                       method = "cv",    # 10 fold cross validation
                       genParallel = TRUE, # Use parallel programming
                       allowParallel = TRUE)

lev <- c("0", "1")     # Set the levels

set.seed(27)
model_1 <- gafs(x = df[-c(1,2)], y = df$TARGET,
                iters = 10, # generations of algorithm
                popSize = 5, # population size for each generation
                levels = lev,
                gafsControl = ga_ctrl)

 plot(model_1) # Plot mean fitness (AUC) by generation

model_1$ga$final
