test_that("mmwr calendar", {
  expect_equal(
    head(mmwr_calendar(2024)),
    data.frame(
      Year = rep(2024, 6),
      Week = as.numeric(c(1:6)),
      Start = as.Date(c("2023-12-31","2024-01-07","2024-01-14","2024-01-21","2024-01-28","2024-02-04")),
      End = as.Date(c("2024-01-06","2024-01-13","2024-01-20","2024-01-27","2024-02-03","2024-02-10"))
      )
    )
})

test_that("attempt to pass input string", {
  expect_error(
    mmwr_calendar("2024"),
    "Input not in numeric format."
  )
})
