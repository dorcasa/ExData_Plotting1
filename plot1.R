# plot1.R
# read data for Feb 1-2, 2007
# create histogram of Global Active Power (GAP) measurements
# print to PNG file 480x480 pixels

# read table and abbreviate the column names
print("reading data file...")
data <- read.table("household_power_consumption.txt", sep=";", skip=1, stringsAsFactors=FALSE)
names(data) <- c("D","T","GAP","GRP","V","GI","S1","S2","S3")

# get rows of data only for Feb 1-2, 2007
d2 <- subset(data, D %in% c("1/2/2007","2/2/2007"))

# combine date and time into one new column
d2$DT <- strptime(paste(d2$D, d2$T), format = "%d/%m/%Y %H:%M:%S")

# convert character field GAP to numeric
d2$GAP <- as.numeric(d2$GAP)

# create histogram and print to PNG file
print("generating histogram...")
png(file = "plot1.png", width=480, height=480, units="px")
with(d2, hist(GAP, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()

print("histogram printed to file: plot1.png")