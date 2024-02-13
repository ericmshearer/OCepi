df <- data.frame(ctract = c("06059099244","06059099243","06059099242"))

test_that("remove state and county fips code, string", {
  expect_equal(
    df %>% dplyr::mutate(ctract = recode_ctract(ctract)),
    data.frame(ctract = c("099244","099243","099242"))
    )
})

test_that("remove state and county fips code, numeric", {
  expect_equal(
    df %>% dplyr::mutate(ctract = recode_ctract(as.numeric(ctract))),
    data.frame(ctract = c("099244","099243","099242"))
  )
})
