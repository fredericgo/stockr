library(DT)
library(stockr)
library(PerformanceAnalytics)
mystock.file <- system.file("extdata", "fred.csv", package = "stockr")
stable <- stockr::StockTable(mystock.file)
stock.table <- stable@data
ds <- stockr::StockAnalyzer(mystock.file)
data <- ds@ts
stk.names <- names(data)
stk.num <- sapply(strsplit(stk.names, '.', fixed=TRUE), function(x){x[1]})
stock.table <- subset(stock.table, no %in% stk.num)
stock.table <- stock.table[order(stock.table$no),]
td <- Return.calculate(data)
td <- td[,order(names(td))]

shinyServer(function(input, output, session) {

  output$x1 = DT::renderDataTable(stock.table, server = FALSE)

  # highlight selected rows in the scatterplot
  output$x2 = renderPlot({
    s = input$x1_rows_selected
    #par(mar = c(4, 4, 1, .1))
    #plot(data)
    if (length(s)) {
      chart.RiskReturnScatter(td[, s])
    }
  })

  # server-side processing
  data2 = stock.table
  output$x3 = DT::renderDataTable(data2, server = TRUE)

  # print the selected indices
  output$x4 = renderPrint({
    s = input$x3_rows_selected
    if (length(s)) {
      cat('These rows were selected:\n\n')
      cat(s, sep = ', ')
    }
  })

})
