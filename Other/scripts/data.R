library(openxlsx)

data <- read.xlsx("data/Carbon_data_agrecalc_v02.xlsx")

rownuke <- vector("logical", nrow(data))
for(i in 1:nrow(data)) {
    rownuke[i] <- sum(data[i, 6:ncol(data)]) == 0
}

table(rownuke)
data <- data[-which(rownuke),]

data <- data[-which(data$lineitem_code == "C1" | data$lineitem_code == "C3" | 
  data$lineitem_code == "C6" | data$lineitem_code == "G6" |
  data$lineitem_code == "FORAGE"),]

for(i in 6:ncol(data)){
  data[1,i] <- sum(data[2:5,i])
}

for(i in 6:ncol(data)){
  data[6,i] <- sum(data[7:10,i])
}

# write.csv(data, "data/carbon_data_clean.csv", row.names=F)

rm(i, rownuke)


