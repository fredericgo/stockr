setClass("StockTable",
         representation = representation(
           filename="character",
           data="data.frame"
         )
)

StockTable <- function(fn) {
  s <- new("StockTable", filename=fn)
  print(s)
  s
}

setGeneric("setData<-", function(object,value) {standardGeneric("setData<-")})

setReplaceMethod(f="setData",
                 signature="StockTable",
                 definition=function(object, value) {
                   #data <- read.csv(x@filename, row.names=NULL)
                   object@data <- value
                   return(object)
                 }
)

setMethod(f="initialize",
          signature="StockTable",
          definition=function(.Object, filename) {
            cat("~~~ StockTable: initialize ~~~\n")
            .Object@filename <- filename
            .Object@data <- .filterData(read.csv(.Object@filename, row.names=NULL))
            validObject(.Object)
            return(.Object)
          }
)

.filterData <- function(df) {
  fields <- c("市場別", "代號", "商品名稱", "數量")
  df <- df[,fields]
  names(df) <- c("market", "no", "name", "qty")
  df <- subset(df, df$market != "")
  df
}

