df <- data.frame(age = c(1,10,20,30,40,50,60,80,NA))

test_that("default grouping to decade", {
  expect_equal(
    df %>%
      dplyr::mutate(age_group = age_groups(age)),
    data.frame(
      age = c(1,10,20,30,40,50,60,80,NA),
      age_group = factor(
        c("0-9","10-19","20-29","30-39","40-49","50-59","60-69","80+","Missing/Unknown"),
        levels = c("0-9","10-19","20-29","30-39","40-49","50-59","60-69","70-79","80+","Missing/Unknown")
        )
      )
    )
})

test_that("input not numeric/integer", {
  expect_error(
    df %>%
      dplyr::mutate(age_group = age_groups("A")),
    "Age variable is not numeric format."
  )
})

test_that("group not in preset list", {
  expect_error(
    df %>%
      dplyr::mutate(age_group = age_groups(age, type = "ebola")),
    "Age grouping not found."
  )
})
