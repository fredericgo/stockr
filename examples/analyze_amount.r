library(ggplot2)
library(dplyr)
mystock.file <- system.file("extdata", "fred.csv", package = "stockr")
st <- StockTable(mystock.file)

portfolio <- st@data
portfolio <- portfolio %>%
  arrange(qty) %>%
  mutate(name = factor(name, levels=name))

portfolio$group <- cut(portfolio$qty,
    breaks=c(0, 2000, 4000, 6000, 200000),
    labels = c("A", "B", "C", "D"))

mean_qty <- mean(portfolio$qty)
summary(portfolio$qty)

ggplot(portfolio, aes(x=group, y=qty)) + geom_boxplot()

ggplot(portfolio, aes(x=name, y=qty)) + geom_density() +
  theme(text = element_text(family = "STHeiti")) + coord_flip()

portfolio %>%
  filter(group=="A")
