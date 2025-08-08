test_that("redcap-read-error", {
  expect_error(
    read_redcap(url = "https://redcap.chop.edu/api/", token = "1")
  )
})
