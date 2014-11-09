# plot3.R
# read data for Feb 1-2, 2007
# create line graph of sub metering measurements (S1, S2, S3)
# plot over time on x-axis
# print to PNG file 480x480 pixels

# read table and abbreviate the column names
print("reading data file...")
data <- read.table("household_power_consumption.txt", sep=";", skip=1, stringsAsFactors=FALSE)
names(data) <- c("D","T","GAP","GRP","V","GI","S1","S2","S3")

# get rows of data only for Feb 1-2, 2007
d2 <- subset(data, D %in% c("1/2/2007","2/2/2007"))

# combine date and time into one new column
d2$DT <- strptime(paste(d2$D, d2$T), format = "%d/%m/%Y %H:%M:%S")

# convert character fields S1, S2, S3 to numeric
d2$S1 <- as.numeric(d2$S1)
d2$S2 <- as.numeric(d2$S2)
d2$S3 <- as.numeric(d2$S3)

# create line graph and print to PNG file
print("generating line graph...")
png(file = "plot3.png", width=480, height=480, units="px")
plot(d2$DT, d2$S1, type="n", ylab="Energy sub metering", xlab="")
lines(d2$DT, d2$S1)
lines(d2$DT, d2$S2, col="green")
lines(d2$DT, d2$S3, col="blue")
legend("topright", lwd=c(1,1,1), col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

print("line graph printed to file: plot3.png")