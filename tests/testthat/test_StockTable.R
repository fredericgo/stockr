library(stringr)
context("String length")

mystock.file <- system.file("extdata", "fred.csv", package = "stockr")

test_that("can load from csv file", {
  st <- StockTable(mystock.file)
  expect_is(st, "StockTable")
})
