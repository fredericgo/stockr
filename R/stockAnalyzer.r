#require()

setClass("StockAnalyzer",
         representation = representation(
           filename="character"
         ),
         contains = "StockTable"
)
