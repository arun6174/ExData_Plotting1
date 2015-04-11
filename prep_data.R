dloadDataFile <- function(fileURL, fname) {
  if(!file.exists(fname)) {
    download.file(fileURL, destfile=fname, method="curl")
  }
  fname
}

preparePlottingData <- function() {
  cachedFile <- "plot_data.csv"
  if(file.exists(cachedFile)) {
    tbl <- read.csv(cachedFile)
    tbl$DateTime <- strptime(tbl$DateTime, "%Y-%m-%d %H:%M:%S")
  }
  else {
    fname <- dloadDataFile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
    conn <- unz(fname, "household_power_consumption.txt")
    tbl <- read.table(conn, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
    tbl <- tbl[(tbl$Date == "1/2/2007") | (tbl$Date == "2/2/2007"),]
    tbl$DateTime <- strptime(paste(tbl$Date, tbl$Time), "%d/%m/%Y %H:%M:%S")
    write.csv(tbl, cachedFile)
  }
  tbl
}