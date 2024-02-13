test_that("total weeks, 52", {
  expect_equal(
    total_weeks(2023),
    52
    )
})

test_that("total weeks, 53", {
  expect_equal(
    total_weeks(2014),
    53
  )
})

test_that("attempt to pass input string", {
  expect_error(
    total_weeks("2024"),
    "Input not in numeric format."
  )
})
