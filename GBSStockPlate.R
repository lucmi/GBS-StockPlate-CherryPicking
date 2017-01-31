library(xlsx) #this can fail if R and java have different architecture ie 64 bit R and 32 bit Java.

startPlate <- 1234
inFile <- file.choose()

stockPlateOutPath <- "stockPlate.csv"
remainderOutPath <- "Remainder.xlsx"

data <- read.xlsx(inFile, 1)

WholePlateLayout <- read.csv("plateLayout.csv")

out <- NULL

while(nrow(data) >= 93){
  plate <- head(data, 93)
  data <- data[94:nrow(data),]
  
  wellSample <- sample(nrow(WholePlateLayout),93)
  wellSample <- sort(wellSample)
  
  plate$Well <- WholePlateLayout[wellSample,]
  plate$PlateID <- startPlate
  
  plate <- plate[,c("PlateID", "SampleID", "Well")]
  
  out <- rbind(out,plate)
  startPlate <- startPlate + 1
}

write.csv(out,stockPlateOutPath, row.names = FALSE, quote = FALSE)

write.xlsx(data, remainderOutPath, row.names = FALSE)




