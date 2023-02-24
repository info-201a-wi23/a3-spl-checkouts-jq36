library(dplyr)

data <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

get_summary_info <- function(data) {
  summary_info <- list()
  
  # Q1: What is the rank of CheckoutType in the dataset based on the number of different checkout types that were recorded?
  checkout_counts <- table(data$CheckoutType)
  summary_info$most_frequent_checkout <- names(checkout_counts)[which.max(checkout_counts)]
  
  # Q2: What is the month or year with the most/least checkouts for a book that you're interested in?
  # I am interested in a book called "Happy birthday, Old Bear / Jane Hissey."
  title_matches <- grepl("Happy birthday, Old Bear / Jane Hissey.", data$Title)
  sub_data <- data[title_matches,]
  year_counts <- table(sub_data$CheckoutYear)
  month_counts <- table(sub_data$CheckoutMonth)
  summary_info$year_max <- names(year_counts)[which.max(year_counts)]
  summary_info$year_min <- names(year_counts)[which.min(year_counts)]
  summary_info$month_max <- names(month_counts)[which.max(month_counts)]
  summary_info$month_min <- names(month_counts)[which.min(month_counts)]
  
  # Q3: What is the month or year with the most/least checkouts for ebooks?
  ebook_data <- subset(data, MaterialType == "EBOOK")
  year_counts_1 <- table(ebook_data$CheckoutYear)
  month_counts_1 <- table(ebook_data$CheckoutMonth)
  summary_info$year_max_1 <- names(year_counts_1)[which.max(year_counts_1)]
  summary_info$year_min_1 <- names(year_counts_1)[which.min(year_counts_1)]
  summary_info$month_max_1 <- names(month_counts_1)[which.max(month_counts_1)]
  summary_info$month_min_1 <- names(month_counts_1)[which.min(month_counts_1)]
  
  # Q4: How has the number of print book checkouts changed over time?
  book_data <- subset(data, MaterialType == "BOOK")
  year_counts_2 <- table(book_data$CheckoutYear)
  summary_info$Q4 <- list(year_counts_2)
  
  # Q5: What is the most popular publisher?
  summary_info$popular_publisher <- data %>% 
    group_by(Publisher) %>% 
    summarize(total_checkouts = sum(Checkouts)) %>% 
    slice_max(order_by = total_checkouts) %>%
    pull(Publisher)
  
  return(summary_info)
}

summary_info <- get_summary_info(data)
print(summary_info)
