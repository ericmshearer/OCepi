df <- data.frame(locations = letters[1:5], n = c(20,18,21,12,16))

test_that("add percent", {
  expect_equal(
    df %>% dplyr::mutate(percent = add_percent(n)),
    data.frame(
      locations = letters[1:5],
      n = c(20,18,21,12,16),
      percent = c(22.99,20.69,24.14,13.79,18.39)
      )
    )
})

test_that("round to 3 digits", {
  expect_equal(
    df %>% dplyr::mutate(percent = add_percent(n, digits = 3)),
    data.frame(
      locations = letters[1:5],
      n = c(20,18,21,12,16),
      percent = c(22.989,20.690,24.138,13.793,18.391)
    )
  )
})

test_that("disable multiplication by 100", {
  expect_equal(
    df %>% dplyr::mutate(percent = add_percent(n, multiply = FALSE)),
    data.frame(
      locations = letters[1:5],
      n = c(20,18,21,12,16),
      percent = c(0.23,0.21,0.24,0.14,0.18)
    )
  )
})
