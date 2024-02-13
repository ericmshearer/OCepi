test_that("convert to month", {
  expect_equal(
    to_month(as.Date("2023-10-31")), as.Date("2023-10-01"))
})

test_that("convert to month", {
  expect_error(
    to_month("2023-10-31"), "Input not in date format.")
})
