df <- data.frame(ornt = c("BIS","HET",NA,"HOM"))

test_that("recode orientation from CalREDIE", {
  expect_equal(
    df %>% dplyr::mutate(ornt_new = recode_orientation(ornt)),
    data.frame(
      ornt = c("BIS","HET",NA,"HOM"),
      ornt_new = c("Bisexual","Heterosexual or straight","Missing/Unknown","Gay, lesbian, or same gender-loving")
      )
    )
})
