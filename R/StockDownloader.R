#require()

setClass("StockDownloader",
         representation = representation(
           data="data.frame"
         )
)

StockTable <- function(df) {
  s <- new("StockDownloader", data=df)
  s
}

setMethod(f="initialize",
          signature="StockDownloader",
          definition=function(.Object, filename) {
            cat("~~~ StockTable: initialize ~~~\n")
            .Object@filename <- filename
            .Object@data <- .filterData(read.csv(.Object@filename))
            validObject(.Object)
            return(.Object)
          }
)

setGeneric("download_historical",
           function(x) {standardGeneric("download_historical")})

setMethod(f="download_historical",
          signature("StockDownloader"),
          definition=function(x) {
            cat("~~~ StockDownloader: download ~~~\n")
            # 上市下載
            market.stks <- subset(x@data, "上市")
          }
)
