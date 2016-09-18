#require()
#' StockAnalyzer
#'
#' The main controller for stockr package.
#' It automatically download historical OHLC data from a specific CSV file,
#' and calculate the performance of the portfolio.

#' @include StockTable.R
#' @include StockDownloader.R
setClass("StockAnalyzer",
         representation = representation(
           filename="character",
           table="StockTable",
           downloader="StockDownloader",
           ts="xts"
         )
)

#' Constructor for StockAnalyzer
StockAnalyzer <- function(filename) {
  s <- new("StockAnalyzer", filename)
  s
}

setMethod(f="initialize",
          signature="StockAnalyzer",
          definition=function(.Object, filename) {
            cat("~~~ StockTable: initialize ~~~\n")
            .Object@filename <- filename
            .Object@table <- StockTable(filename)
            .Object@downloader <- StockDownloader(.Object@table)
            .Object@ts <- download_historical(.Object@downloader)
            validObject(.Object)
            return(.Object)
          }
)

setGeneric("analyse",
           function(x) {standardGeneric("analyse")})

setMethod(f="analyse",
          signature("StockAnalyzer"),
          definition=function(x) {
            cat("~~~ StockAnalyzer: analyze ~~~\n")
            # calculate
            ts <- Return.calculate(x@ts)
            #ts <- na.omit(ts)
            chart.RiskReturnScatter(ts)
          }
)

