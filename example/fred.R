mystock.file <- system.file("extdata", "fred.csv", package = "stockr")

st <- StockTable(mystock.file)
sa <- StockAnalyzer()

df <- st@data
sd <- StockDownloader(df)
o <- download_historical(sd)
s <- strsplit(names(o), "[X.]")
sapply(s, function(x){paste(x[4],x[2], x[3], sep=".")})
stks <- new.env()
tickers <- paste0(tickers, ".tw")
getSymbols(tickers, env = stks)

install.packages("Quandl")
library(Quandl)

stk <- Quandl("YAHOO/TW_8011", start_date=start_date)
df <- st@data
df.m1 <- subset(df, market == "上市")
df.m2 <- subset(df, market == "上櫃")
install.packages('quantmod')
library(quantmod)
getSymbols("3078.two")
`3078.TWO`
stk <- Quandl("YAHOO/TWO_3078", start_date=start_date)
?getSymbols
