df <- data.frame(place = c(1:7,9))

test_that("recode place, numeric", {
  expect_equal(
    df %>% dplyr::mutate(place = vrbis_place_death(place)),
    data.frame(place = c("Inpatient","Emergency Room/Outpatient","Dead on Arrival","At Home","Hospice Facility","LTCF","Other","Unknown"))
    )
})

test_that("recode place, character", {
  expect_equal(
    df %>% dplyr::mutate(place = vrbis_place_death(as.character(place))),
    data.frame(place = c("Inpatient","Emergency Room/Outpatient","Dead on Arrival","At Home","Hospice Facility","LTCF","Other","Unknown"))
  )
})
