test_that("crude rate", {
  expect_equal(rate_per_100k(5, 1000, digits = 1), 500)
})

df <- data.frame(n = c(5))

test_that("crude rate df", {
  expect_equal(
    df %>% dplyr::mutate(rate = rate_per_100k(n, 1000, digits = 1)),
    data.frame(n = c(5), rate = c(500))
    )
})

test_that("pass string as input", {
  expect_error(
    df %>% dplyr::mutate(rate = rate_per_100k("5", 1000, digits = 1)),
    "Input variables are not numeric."
  )
})

test_that("pass string as input", {
  expect_error(
    df %>% dplyr::mutate(rate = rate_per_100k(n, "1000", digits = 1)),
    "Input variables are not numeric."
  )
})
