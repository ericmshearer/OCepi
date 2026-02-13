test_that("convert to quarter", {
  expect_equal(
    to_quarter(as.Date("2023-10-31")), "2023-Q04"
    )
})

test_that("convert to fiscal quarter", {
  expect_equal(
    to_quarter(as.Date("2023-10-31"), fiscal = TRUE), "2023-Q02"
    )
})

test_that("convert to quarter - error", {
  expect_error(
    to_quarter("2023-10-31"), "Input not in date format.")
})
