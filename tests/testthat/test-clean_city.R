test_that("Test Anaheim", {
  expect_equal(clean_city("Anahim"), "Anaheim")
})

test_that("Test Anaheim then to REDCap", {
  expect_equal(clean_city("Anahim", redcap = TRUE), "1")
})

test_that("Test non-OC City", {
  expect_equal(clean_city("Norwak", ooc = FALSE), NA_character_)
})
