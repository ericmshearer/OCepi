df <- data.frame(Date = as.Date(c("2023-01-01","2023-02-01")), scores = c(88,84))
rownames(df) <- as.character(rownames(df))

test_that("basic use", {
  expect_equal(end_points(df, Date), data.frame(Date = c(as.Date("2023-02-01")), scores = c(84), row.names = 2))
})
