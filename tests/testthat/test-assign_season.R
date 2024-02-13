test_that("attempt to pass character as input", {
  expect_error(assign_season("2023-01-01"), "Input not in date format.")
})

df <- data.frame(Date = as.Date(c("2023-10-01","2023-10-07","2024-10-15")))

test_that("attempt to pass character as input", {
  expect_equal(
    df %>% dplyr::mutate(season = assign_season(Date)),
    data.frame(
      Date = as.Date(c("2023-10-01","2023-10-07","2024-10-15")),
      season = c("2023-24","2023-24","2024-25")
      )
    )
})
