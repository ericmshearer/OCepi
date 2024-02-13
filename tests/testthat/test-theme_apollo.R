library(ggplot2)

df <- data.frame(locations = letters[1:5], n = sample(20:60, 5))

plot <- ggplot(data = df, aes(x = locations, y = n)) +
  geom_col() +
  theme_apollo(direction = "vertical")

test_that("returns a ggplot object", {
  expect_type(
    plot,
    "list"
  )
})
