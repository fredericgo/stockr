mystock.file <- system.file("extdata", "fred.csv", package = "stockr")

st <- StockTable(mystock.file)
sd <- StockDownloader(st)
d <- download_historical(sd)
sa <- StockAnalyzer(mystock.file)
analyse(sa)


ts <- Return.calculate(sa@ts)
r <- na.omit(ts)
chart.RiskReturnScatter(r)
r
charts.PerformanceSummary(r, colorset=rich12equal)
chart.CumReturns(r)
ta <- t(table.CalendarReturns(r))
charts.PerformanceSummary(ts[,'9914.TW'])
