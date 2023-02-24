publisher_counts <- as.data.frame(table(data$Publisher))
top_publishers <- head(publisher_counts[order(-publisher_counts$Freq), ], 10)
C3 <- barplot(top_publishers$Freq, 
              names.arg = top_publishers$Var1, 
              col = rainbow(10), 
              main = "Top 10 Publishers by Checkouts", 
              xlab = "", 
              ylab = "Number of Checkouts",
              las = 2) # adjust the orientation of the x-axis labels


