x <- "https://www.test.com"

test_that("Missing start date", {
  expect_error(nssp_date_range(x), "Missing start date. Please provide start date.")
})

test_that("Check start date", {
  expect_equal(nssp_date_range(x, start = as.Date("2026-01-01")), "1Jan2026")
})

test_that("Invalid date format", {
  expect_error(nssp_date_range(x, start = "2026-01-01"), "Start/End date not in date format.")
})
