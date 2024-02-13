df <- data.frame(manner = c("A","S","U"))

test_that("recode abbreviation to full response per data dictionary", {
  expect_equal(
    df %>% dplyr::mutate(manner = vrbis_manner_death(manner)),
    data.frame(manner = c("Accident","Suicide",NA))
    )
})
