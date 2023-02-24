library(ggplot2)

book_checkouts <- data[data$MaterialType %in% c("BOOK", "EBOOK","AUDIOBOOK"), ]

checkouts_by_material_and_year <- aggregate(Checkouts ~ MaterialType + CheckoutYear, data = book_checkouts, sum)

C2 <- ggplot(checkouts_by_material_and_year, aes(x = CheckoutYear, y = Checkouts, color = MaterialType)) +
  geom_line() +
  labs(title = "Different type of Books Checkouts Over Time",
       x = "Year",
       y = "Number of Checkouts",
       color = "Materials") +
  scale_color_manual(values = c("#1f77b4", "#ff7f0e","#ff1287")) # set custom colors for the lines

# I include this plot since I want to figure out how the number of checkout change for different type of books over year. So, we can try to predict what the data will be in the next year and to see what kind of book's checkout number drop dramatically.