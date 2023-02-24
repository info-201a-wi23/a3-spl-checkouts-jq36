library(dplyr)
library(ggplot2)

# select the top 1 most checked-out books for each year
top_books <- data %>%
  group_by(CheckoutYear, Title) %>%
  summarize(Checkouts = sum(Checkouts)) %>%
  arrange(CheckoutYear, desc(Checkouts)) %>%
  group_by(CheckoutYear) %>%
  top_n(1, Checkouts)

# create a stacked bar chart of the top 10 most checked-out books for each year
C1 <- ggplot(top_books, aes(x = CheckoutYear, y = Checkouts, fill = Title)) +
  geom_bar(stat = "identity") +
  xlab("Year") + ylab("Number of Checkouts") +
  ggtitle("Top 1 Most Checked-Out Books Each Year") +
  theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust = 0, 
                                   size = 6, lineheight = 0.8),
        legend.position = "bottom")
