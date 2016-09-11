#require()

#devtools::use_package("quantmod")

setClass("StockDownloader",
         representation = representation(
           stock.list="data.frame",
           duration="numeric"
         )
)

setMethod(f="initialize",
          signature="StockDownloader",
          definition=function(.Object, stock.list, years=1) {
            cat("~~~ StockTable: initialize ~~~\n")
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
            m1Data <- new.env()
            m2Data <- new.env()
            output <- list()
            endDate <- Sys.Date()
            startDate <- endDate - dyears(1)

            # 上市下載
            market.stks <- subset(x@stock.list, market == "上市")
            tickers <- paste0(market.stks[["no"]], ".tw")[1:3]
            quantmod::getSymbols(tickers, env = m1Data,
                       src = "yahoo", from = startDate, to = endDate)
            d1 <- do.call(cbind, eapply(m1Data, quantmod::Ad))

            otc.stks <- subset(x@stock.list, market == "上櫃")
            tickers <- paste0(otc.stks[["no"]], ".two")[1:3]
            quantmod::getSymbols(tickers, env = m2Data,
                                 src = "yahoo", from = startDate, to = endDate)
            d2 <- do.call(cbind, eapply(m2Data, quantmod::Ad))

            output <- cbind(d1,d2)
            s <- strsplit(names(df), "[X.]")
            names(output) <- sapply(s, function(x){paste(x[4],x[2], x[3], sep=".")})
            output
          }
)
