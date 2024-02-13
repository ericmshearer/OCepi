test_that("make simple label, forward", {
  expect_equal(n_percent(5, 20, reverse = FALSE), "5 (20%)")
})

test_that("make simple label, reverse", {
  expect_equal(n_percent(5, 20, reverse = TRUE), "20% (5)")
})

df <- data.frame(n = c("5"), percent = c("20"))

test_that("make simple label from df, forward", {
  expect_equal(
    df %>% dplyr::mutate(label = n_percent(n, percent, reverse = FALSE)),
    data.frame(n = c("5"), percent = c("20"), label = c("5 (20%)"))
    )
})

test_that("make simple label from df, reverse", {
  expect_equal(
    df %>% dplyr::mutate(label = n_percent(n, percent, reverse = TRUE)),
    data.frame(n = c("5"), percent = c("20"), label = c("20% (5)"))
  )
})
