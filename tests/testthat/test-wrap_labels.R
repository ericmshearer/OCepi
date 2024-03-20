df <- data.frame(group = c("Native Hawaiian or Other Pacific Islander","Black or African American","American Indian or Alaska Native"), score = c(89.5, 84, 73))

x <- ggplot(data = df, aes(x = group, y = score)) +
  geom_col() +
  scale_x_discrete(labels = wrap_labels(width = 15))

ggplot2::ggplot_build(x)$layout$panel_params[[1]]$x$get_labels()[[1]]

test_that("check class", {
  expect_equal(class(scale_x_discrete(labels = wrap_labels(width = 15)))[2], "ScaleDiscrete")
})

test_that("check wrap", {
  expect_equal(
    ggplot2::ggplot_build(x)$layout$panel_params[[1]]$x$get_labels()[[1]],
    "American\nIndian or\nAlaska Native"
    )
})
