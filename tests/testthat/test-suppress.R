df <- data.frame(n = c(10, 3, 5, 11, 9))

test_that("multiplication works", {
  expect_equal(
    df %>% dplyr::mutate(n_suppress = suppress(n, less_than = 5, replace_with = "**")),
    data.frame(n = c(10, 3, 5, 11, 9), n_suppress = c("10","**","5","11","9"))
    )
})
