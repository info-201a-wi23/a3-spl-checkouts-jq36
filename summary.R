#Q1 What is the rank of CheckoutType in the dataset based on the number of different checkout type that was recorded?
data = read.csv("2017-2023-10-Checkouts-SPL-Data.csv")

checkout_counts <- table(data$CheckoutType)

most_frequent_checkout <- names(checkout_counts)[which.max(checkout_counts)]

print(checkout_counts)
print(paste("The most frequent checkout type is", most_frequent_checkout))

#Q2 What is the month or year with the most/least checkouts for a book that you're interested in?
#I am interested in a book called "Happy birthday, Old Bear / Jane Hissey."

title_matches <- grepl("Happy birthday, Old Bear / Jane Hissey.", data$Title)

sub_data <- data[title_matches,]

year_counts <- table(sub_data$CheckoutYear)
month_counts <- table(sub_data$CheckoutMonth)


year_max <- names(year_counts)[which.max(sub_data$Checkouts)]
year_min <- names(year_counts)[which.min(sub_data$Checkouts)]
month_max <- names(month_counts)[which.max(sub_data$Checkouts)]
month_min <- names(month_counts)[which.min(sub_data$Checkouts)]

if(is.na(year_min)){
  year_min <- year_max
}

cat("For 'Happy birthday, Old Bear / Jane Hissey':\n")
cat(paste("Most checkouts in a year:", year_max, "\n"))
cat(paste("Least checkouts in a year:", year_min, "\n"))
cat(paste("Most checkouts in a month:", month_max, "\n"))
cat(paste("Least checkouts in a month:", month_min, "\n"))

#Q3  What is the month or year with the most/least checkouts for ebooks?
ebook_data <- subset(data, MaterialType == "EBOOK")

year_counts_1 <- table(ebook_data$CheckoutYear)
month_counts_1 <- table(ebook_data$CheckoutMonth)

year_max_1 <- names(year_counts)[which.max(sub_data$Checkouts)]
year_min_1 <- names(year_counts)[which.min(sub_data$Checkouts)]
month_max_1 <- names(month_counts)[which.max(sub_data$Checkouts)]
month_min_1 <- names(month_counts)[which.min(sub_data$Checkouts)]

if(is.null(year_min)){
  year_min <- year_max
}

cat("For 'EBOOK':\n")
cat(paste("Most checkouts in a year:", year_max_1, "\n"))
cat(paste("Least checkouts in a year:", year_min_1, "\n"))
cat(paste("Most checkouts in a month:", month_max_1, "\n"))
cat(paste("Least checkouts in a month:", month_min_1, "\n"))

#Q4 How has the number of print book checkouts changed over time?
book_data <- subset(data, MaterialType == "BOOK")

year_counts <- table(book_data$CheckoutYear)
month_counts <- table(book_data$CheckoutMonth)

plot(year_counts, type = "l", xlab = "Year", ylab = "Number of Checkouts",
    main = "Number of Print Book Checkouts Over Time")

#Q5 What is the most popular publisher
popular_publisher <- data %>% 
  group_by(Publisher) %>% 
  summarize(total_checkouts = sum(Checkouts)) %>% 
  slice_max(order_by = total_checkouts)


cat("The most popular publisher is:", popular_publisher$Publisher)


