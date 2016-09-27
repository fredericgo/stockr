#require()

#devtools::use_package("quantmod")
m1.cache <- new.env()
m2.cache <- new.env()

#' @include StockTable.R
setClass("StockDownloader",
         representation = representation(
           stock.list="StockTable",
           duration="numeric"
         )
)

check.cache <- function() {

}

StockDownloader <- function(stbl) {
  new("StockDownloader", stock.list=stbl)
}

setMethod(f="initialize",
          signature="StockDownloader",
          definition=function(.Object, stock.list, years=1) {
            cat("~~~ StockDownloader: initialize ~~~\n")
            .Object@stock.list <- stock.list
            .Object@duration <- years
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
            # check cache

            output <- list()
            endDate <- Sys.Date()
            startDate <- endDate - lubridate::dyears(1)
            data <- x@stock.list@data

            # 上市下載
            market.stks <- subset(data, market == "上市")
            tickers <- paste0(market.stks[["no"]], ".tw")
            if (!length(ls(envir=m1.cache))){
              quantmod::getSymbols(tickers, env = m1.cache,
                                   src = "yahoo", from = startDate, to = endDate)
            }

            d1 <- do.call(cbind, eapply(m1.cache, quantmod::Ad))

            otc.stks <- subset(data, market == "上櫃")
            tickers <- paste0(otc.stks[["no"]], ".two")
            if (!length(ls(envir=m2.cache))){
              quantmod::getSymbols(tickers, env = m2.cache,
                                   src = "yahoo", from = startDate, to = endDate)
            }

            d2 <- do.call(cbind, eapply(m2.cache, quantmod::Ad))

            output <- cbind(d1,d2)
            s <- strsplit(names(output), "[X.]")
            names(output) <- sapply(s, function(x){paste(x[2], x[3], sep=".")})
            output
          }
)
