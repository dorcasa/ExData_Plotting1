# plot4.R
# read data for Feb 1-2, 2007
# create 4 line graphs of:
#   Global Active Power (GAP)
#   Energy sub metering (S1, S2, S3)
#   Voltage (V)
#   Global reactive power (GRP)
# plot over time on x-axis
# print to PNG file 480x480 pixels

# read table and abbreviate column names
print("reading data file...")
data <- read.table("household_power_consumption.txt", sep=";", skip=1, stringsAsFactors=FALSE)
names(data) <- c("D","T","GAP","GRP","V","GI","S1","S2","S3")

# get rows of data only for Feb 1-2, 2007
d2 <- subset(data, D %in% c("1/2/2007","2/2/2007"))

# combine date and time into one new column
d2$DT <- strptime(paste(d2$D, d2$T), format = "%d/%m/%Y %H:%M:%S")

# convert character GAP to numeric
d2$GAP <- as.numeric(d2$GAP)

# convert character S1, S2, S3 to numeric
d2$S1 <- as.numeric(d2$S1)
d2$S2 <- as.numeric(d2$S2)
d2$S3 <- as.numeric(d2$S3)

# convert character Voltage to numeric
d2$V <- as.numeric(d2$V)

# convert character GRP to numeric
d2$GRP <- as.numeric(d2$GRP)

# create line graphs and print to PNG file
print("generating line graphs...")
png(file = "plot4.png", width=480, height=480, units="px")

# create 2x2 grid of graphs
par(mfcol=c(2,2))

# Global Active Power line graph
plot(d2$DT, d2$GAP, type="n", ylab="Global Active Power", xlab="")
lines(d2$DT, d2$GAP)

# Sub metering line graph
plot(d2$DT, d2$S1, type="n", ylab="Energy sub metering", xlab="")
lines(d2$DT, d2$S1)
lines(d2$DT, d2$S2, col="red")
lines(d2$DT, d2$S3, col="blue")
legend("topright", bty="n", lwd=c(1,1,1), col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Voltage line graph
plot(d2$DT, d2$V, type="n", ylab="Voltage", xlab="datetime")
lines(d2$DT, d2$V)

# Global Reactive Power line graph
plot(d2$DT, d2$GRP, type="n", ylab="Global_reactive_power", xlab="datetime")
lines(d2$DT, d2$GRP)

# close graphic device
dev.off()

print("line graphs printed to file: plot4.png")