
<!-- badges: start -->

[![R-CMD-check](https://github.com/ericmshearer/OCepi/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ericmshearer/OCepi/actions/workflows/R-CMD-check.yaml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/ericmshearer/OCepi/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ericmshearer/OCepi?branch=main)

<!-- badges: end -->

# OCepi <img src="man/figures/hex_sticker.png" align="right" width="180"/>

{OCepi} aims to provide a standardized approach to the mundane data
wrangling tasks for public health epidemiologists. The functions
included in this package can be broadly applied but were made
specifically for epidemiologists at county and State agencies. This
package addresses the following priorities:

- standardization of recoding demographic data, specifically:
  ethnicity/race, gender, sexual orientation, and age groups
- elevated branding for ggplots with tidy labels and aesthetics
- simple methods to suppress/redact information prior to public
  reporting
- methods to group cases/episode into MMWR disease weeks and years

For full documentation, see vignette/OCepi.md

## Installation

For the latest development version:

``` r
# install.packages("devtools")
devtools::install_github("ericmshearer/OCepi")
```

## Example Use Cases

### Recoding + Plot

Here we have simulated outbreak data that needs cleaning prior to
reporting/summarizing:

    #> # A tibble: 6 × 5
    #>   Ethnicity              Race                  Gender   Age `Sexual Orientation`
    #>   <chr>                  <chr>                 <chr>  <dbl> <chr>               
    #> 1 Hispanic or Latino     Asian                 F         63 HET                 
    #> 2 Non-Hispanic or Latino Other                 F         15 UNK                 
    #> 3 Hispanic or Latino     Other                 U          1 HET                 
    #> 4 Hispanic or Latino     American Indian or A… F         42 DNK                 
    #> 5 Non-Hispanic or Latino Unknown               M         77 NOT                 
    #> 6 Non-Hispanic or Latino Other                 M         31 HET

Applying the core functions:

``` r
linelist <- linelist %>%
  mutate(
    Gender = recode_gender(Gender),
    race_ethnicity = recode_race(Ethnicity, Race, abbr_names = FALSE),
    age_group = age_groups(Age, type = "school"),
    `Sexual Orientation` = recode_orientation(`Sexual Orientation`)
  )
```

    #> # A tibble: 5 × 2
    #>   Gender                n
    #>   <chr>             <int>
    #> 1 Female             2187
    #> 2 Male               2224
    #> 3 Missing/Unknown     583
    #> 4 Transgender man       2
    #> 5 Transgender woman     4

    #> # A tibble: 9 × 2
    #>   race_ethnicity                             n
    #>   <chr>                                  <int>
    #> 1 American Indian/Alaska Native            506
    #> 2 Asian                                    499
    #> 3 Black/African American                   492
    #> 4 Hispanic/Latinx                          963
    #> 5 Multiple Races                           548
    #> 6 Native Hawaiian/Other Pacific Islander   517
    #> 7 Other                                    491
    #> 8 Unknown                                  509
    #> 9 White                                    475

    #> # A tibble: 5 × 2
    #>   age_group     n
    #>   <fct>     <int>
    #> 1 0-4         250
    #> 2 5-11        394
    #> 3 12-17       366
    #> 4 18-64      2562
    #> 5 65+        1428

    #> # A tibble: 4 × 2
    #>   `Sexual Orientation`                    n
    #>   <chr>                               <int>
    #> 1 Bisexual                               56
    #> 2 Gay, lesbian, or same gender-loving   102
    #> 3 Heterosexual or straight             3979
    #> 4 Missing/Unknown                       863

Next we’ll make a nice plot for a slide deck/report. Functions
`add_percent` will be used to create a percentage variable, and
`n_percent` for making plot labels. We can control the order of n and
percent in the label by using argument `reverse`.

``` r
linelist %>%
  count(age_group) %>%
  mutate(
    percent = add_percent(n),
    label = n_percent(formatC(n, big.mark = ","), percent, reverse = TRUE)
  ) %>%
  ggplot(aes(x = age_group, y = percent, label = label)) +
  geom_col(fill = "#283747") +
  scale_y_continuous(expand = c(0,0), limits = c(0,60)) +
  theme_apollo(direction = "vertical") +
  labs(
    title = "Age Distribution of Disease X, Your LHJ, Year",
    subtitle = "Unit/Program Name",
    x = "Age Group (Years)",
    y = "Percentage (%)"
  ) +
  apollo_label(direction = "vertical")
```

<img src="man/figures/README-plot-1.png" style="display: block; margin: auto;" />

## Contact

Simplest ways to contact me:

- Questions/Feedback: <ericshearer@me.com>
- Issues/Bugs: <https://github.com/ericmshearer/OCepi/issues>
