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
           downloader="StockDownloader"
         )
)

#' Constructor for StockAnalyzer
StockAnalyzer <- function() {
  s <- new("StockAnalyzer")
  s
}

setMethod(f="initialize",
          signature="StockAnalyzer",
          definition=function(.Object, filename) {
            cat("~~~ StockTable: initialize ~~~\n")
            .Object@filename <- filename
            .Object@data <- .filterData(read.csv(.Object@filename))
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
            # 上市下載
            market.stks <- subset(x@data, "上市")
          }
)

