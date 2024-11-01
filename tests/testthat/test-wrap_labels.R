df <- data.frame(group = c("Native Hawaiian or Other Pacific Islander","Black/African American","American Indian or Alaska Native"), score = c(89.5, 84, 73))

x <- ggplot(data = df, aes(x = group, y = score)) +
  geom_col() +
  scale_x_discrete(labels = wrap_labels(delim = c("/","or")))

test_that("check class", {
  expect_equal(class(scale_x_discrete(labels = wrap_labels(delim = c("/","or"))))[2], "ScaleDiscrete")
})

test_that("check wrap with or", {
  expect_equal(
    ggplot2::ggplot_build(x)$layout$panel_params[[1]]$x$get_labels()[[1]],
    "American Indian or\n Alaska Native"
    )
})

test_that("check wrap with forward slash", {
  expect_equal(
    ggplot2::ggplot_build(x)$layout$panel_params[[1]]$x$get_labels()[[2]],
    "Black/\nAfrican American"
  )
})
