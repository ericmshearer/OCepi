df <- data.frame(locations = letters[1:5], n = sample(20:60, 5))

plot <- ggplot2::ggplot(data = df, ggplot2::aes(x = locations, y = n, label = n)) +
  ggplot2::geom_col() +
  theme_apollo(direction = "vertical") +
  apollo_label(direction = "vertical")

test_that("returns a ggplot object", {
  expect_type(
    plot,
    "list"
  )
})
