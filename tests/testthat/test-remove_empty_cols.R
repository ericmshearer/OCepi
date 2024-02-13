df <- data.frame(a = c("","",""), b = c(NA,NA,NA), c = c("0","1","2"))

test_that("drop empty columns", {
  expect_equal(
    suppressMessages(df %>% remove_empty_cols()),
    data.frame(c = c("0","1","2"))
    )
})
