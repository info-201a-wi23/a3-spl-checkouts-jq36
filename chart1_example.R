library(dplyr)
library(ggplot2)

data <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

# select the top 1 most checked-out books for each year
top_books <- data %>%
  group_by(CheckoutYear, Title) %>%
  summarize(Checkouts = sum(Checkouts), .groups = "drop_last") %>%
  arrange(CheckoutYear, desc(Checkouts)) %>%
  group_by(CheckoutYear) %>%
  top_n(1, Checkouts)

C1 <- ggplot(top_books, aes(x = CheckoutYear, y = Checkouts, fill = Title)) +
  geom_bar(stat = "identity") +
  xlab("Year") + ylab("Number of Checkouts") +
  ggtitle("Top 1 Most Checked-Out Books Each Year") +
  theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust = 0, size = 6, lineheight = 0.8))

C1
#I include the chart because I want to know people's interested over year. Then, we can use the chart to figure out if there is a relationship between the book that people interested in and other factor if other database was provided. For example, if there is a data set that record the things that happend over all in everyday, then we can figure out what type of things that happen the most and their topic. Then, we can try to see if there is a relationship between the topic of events happend and the type of book that people read.

