test_that("title works", {

  title <- highlight_title("Hello there", words = c("Hello"="#d55c19"))

  expect_equal(title, "<span style='color:#d55c19;'>Hello</span> there")
})
