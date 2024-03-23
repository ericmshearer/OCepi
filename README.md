
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
- elevated theming for ggplots
- simple methods to suppress/redact information prior to public
  reporting
- convert dates to weeks, months, and years

For extended documentation with examples, see vignettes.

## Installation

For the latest development version:

``` r
# install.packages("devtools")
devtools::install_github("ericmshearer/OCepi")
```

## Example Use Case

Here we have simulated outbreak data that needs cleaning prior to
reporting/summarizing:

    #> # A tibble: 6 × 6
    #>   Ethnicity              Race  Gender   Age `Sexual Orientation` `Specimen Date`
    #>   <chr>                  <chr> <chr>  <dbl> <chr>                <chr>          
    #> 1 Non-Hispanic or Latino Mult… M         46 HET                  6/7/2022       
    #> 2 Unknown                Unkn… M          4 HET                  6/9/2022       
    #> 3 Non-Hispanic or Latino White F         52 UNK                  6/7/2022       
    #> 4 Non-Hispanic or Latino White F         77 UNK                  6/11/2022      
    #> 5 Unknown                Amer… M         71 HET                  6/10/2022      
    #> 6 Non-Hispanic or Latino Other M         70 HET                  6/9/2022

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

    #> # A tibble: 6 × 8
    #>   Ethnicity              Race  Gender   Age `Sexual Orientation` `Specimen Date`
    #>   <chr>                  <chr> <chr>  <dbl> <chr>                <chr>          
    #> 1 Non-Hispanic or Latino Mult… Male      46 Heterosexual or str… 6/7/2022       
    #> 2 Unknown                Unkn… Male       4 Heterosexual or str… 6/9/2022       
    #> 3 Non-Hispanic or Latino White Female    52 Missing/Unknown      6/7/2022       
    #> 4 Non-Hispanic or Latino White Female    77 Missing/Unknown      6/11/2022      
    #> 5 Unknown                Amer… Male      71 Heterosexual or str… 6/10/2022      
    #> 6 Non-Hispanic or Latino Other Male      70 Heterosexual or str… 6/9/2022       
    #> # ℹ 2 more variables: race_ethnicity <chr>, age_group <fct>

Now that our outbreak data is cleaned up, we can better visualize the
results. Utilizing the functions to extend ggplot2:

``` r
linelist %>%
  count(age_group) %>%
  mutate(
    percent = add_percent(n, digits = 1),
    label = n_percent(n, percent, reverse = TRUE)
  ) %>%
  ggplot(aes(x = age_group, y = percent, label = label)) +
  geom_col(fill = "#00577D") +
  scale_y_continuous(expand = c(0,0), limits = c(0,60)) +
  theme_apollo(direction = "vertical") +
  labs(
    title = "Age Distribution of Cases, Outbreak X, Year",
    subtitle = "Public Health Services/Division Name\n",
    x = "Age Group (Years)",
    y = "Percentage (%)",
    caption = "Data source notes go here."
  ) +
  apollo_label(direction = "vertical")
```

<img src="man/figures/README-plot-1.png" style="display: block; margin: auto;" />

## Contact

Simplest ways to contact me:

- Questions/Feedback: <ericshearer@me.com>
- Issues/Bugs: <https://github.com/ericmshearer/OCepi/issues>
