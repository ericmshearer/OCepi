df <- data.frame(n = c(10, 3, 5, 11, 9))

test_that("basic suppression", {
  expect_equal(
    df %>% dplyr::mutate(n_suppress = suppress(n, less_than = 5, replace_with = "**")),
    data.frame(n = c(10, 3, 5, 11, 9), n_suppress = c("10","**","5","11","9"))
    )
})

test_that("attempt to pass string as n", {
  expect_error(
    df %>% dplyr::mutate(n_suppress = suppress(as.character(n), less_than = 5, replace_with = "**")),
    "Input not in numerical format."
  )
})
