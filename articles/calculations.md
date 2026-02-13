# calculations

## add_percent()

One of the most used calculations is proportion. If you do not want to
multiply proportion by 100, add argument `multiply = FALSE`.

``` r
linelist |>
  mutate(race_ethnicity = recode_race(Ethnicity, Race, abbr_names = TRUE)) |>
  count(race_ethnicity) |>
  mutate(percent = add_percent(n, digits = 1))
#> # A tibble: 9 × 3
#>   race_ethnicity             n percent
#>   <chr>                  <int>   <dbl>
#> 1 AI/AN                     10     9.5
#> 2 Asian                      7     6.7
#> 3 Black/African American    16    15.2
#> 4 Hispanic/Latinx           19    18.1
#> 5 Missing/Unknown            8     7.6
#> 6 Multiple Races             6     5.7
#> 7 NHOPI                     10     9.5
#> 8 Other                     15    14.3
#> 9 White                     14    13.3
```

## n_percent()

When preparing data for {ggplot2}, you may want to create labels with n
and percent. Use argument `n_suppress` to suppress low values and
`reverse` to set order of n and % (default is n then %).

``` r
linelist |>
  mutate(race_ethnicity = recode_race(Ethnicity, Race, abbr_names = TRUE)) |>
  count(race_ethnicity) |>
  mutate(
    percent = add_percent(n, digits = 1),
    label = n_percent(n, percent, reverse = TRUE, n_suppress = 10)
    )
#> # A tibble: 9 × 4
#>   race_ethnicity             n percent label     
#>   <chr>                  <int>   <dbl> <chr>     
#> 1 AI/AN                     10     9.5 9.5% (10) 
#> 2 Asian                      7     6.7 **        
#> 3 Black/African American    16    15.2 15.2% (16)
#> 4 Hispanic/Latinx           19    18.1 18.1% (19)
#> 5 Missing/Unknown            8     7.6 **        
#> 6 Multiple Races             6     5.7 **        
#> 7 NHOPI                     10     9.5 9.5% (10) 
#> 8 Other                     15    14.3 14.3% (15)
#> 9 White                     14    13.3 13.3% (14)
```

## dashboard_tbl()

Pre-aggregating data for dashboarding can be a tedious and disorganized
task. One way to aggregate and organize your data is to summarize all
your data into one table. To use `dashboard_tbl`, start with your data,
then select which columns you want to summarize, then call the function:

``` r
linelist %>%
  mutate(
    race_ethnicity = recode_race(Ethnicity, Race),
    agegroups = age_groups(Age),
    Gender = recode_gender(Gender)
    ) %>%
  select(Gender, agegroups, race_ethnicity) %>%
  dashboard_tbl()
#>          Variable                               Category  n Percent      Label
#> 1          Gender                                 Female 51    48.6 48.6% (51)
#> 2          Gender                                   Male 39    37.1 37.1% (39)
#> 3          Gender                        Missing/Unknown 15    14.3 14.3% (15)
#> 4       agegroups                                    0-9 12    11.4 11.4% (12)
#> 5       agegroups                                  10-19 11    10.5 10.5% (11)
#> 6       agegroups                                  20-29 11    10.5 10.5% (11)
#> 7       agegroups                                  30-39 13    12.4 12.4% (13)
#> 8       agegroups                                  40-49 12    11.4 11.4% (12)
#> 9       agegroups                                  50-59 12    11.4 11.4% (12)
#> 10      agegroups                                  60-69  6     5.7   5.7% (6)
#> 11      agegroups                                  70-79 17    16.2 16.2% (17)
#> 12      agegroups                                    80+ 11    10.5 10.5% (11)
#> 13      agegroups                        Missing/Unknown  0     0.0     0% (0)
#> 14 race_ethnicity          American Indian/Alaska Native 10     9.5  9.5% (10)
#> 15 race_ethnicity                                  Asian  7     6.7   6.7% (7)
#> 16 race_ethnicity                 Black/African American 16    15.2 15.2% (16)
#> 17 race_ethnicity                        Hispanic/Latinx 19    18.1 18.1% (19)
#> 18 race_ethnicity                        Missing/Unknown  8     7.6   7.6% (8)
#> 19 race_ethnicity                         Multiple Races  6     5.7   5.7% (6)
#> 20 race_ethnicity Native Hawaiian/Other Pacific Islander 10     9.5  9.5% (10)
#> 21 race_ethnicity                                  Other 15    14.3 14.3% (15)
#> 22 race_ethnicity                                  White 14    13.3 13.3% (14)
```

It is important to remember you only pass the columns you want
summarized into the function, otherwise it will attempt to summarize all
columns. If you’re wanting to summarize by group or year, use `group_by`
and include that column in the group of columns you pass into the
function. To adjust digits on percent via `digits` argument, and change
n % order using `reverse`.

## rate_per_100k()

Another common calculation for our team are is incidence rate per
100,000.

``` r
linelist |>
  mutate(race_ethnicity = recode_race(Ethnicity, Race, abbr_names = TRUE)) |>
  filter(race_ethnicity %in% c("White","NHOPI","Multiple Races")) |>
  count(race_ethnicity) |>
  mutate(incidence_rate = case_when(
    race_ethnicity == "White" ~ rate_per_100k(n, 1500000, digits = 1),
    race_ethnicity == "NHOPI" ~ rate_per_100k(n, 100000, digits = 1),
    race_ethnicity == "Multiple Races" ~ rate_per_100k(n, 200000, digits = 1)
    )
  )
#> # A tibble: 3 × 3
#>   race_ethnicity     n incidence_rate
#>   <chr>          <int>          <dbl>
#> 1 Multiple Races     6            3  
#> 2 NHOPI             10           10  
#> 3 White             14            0.9
```

## time_between()

[`time_between()`](https://ericmshearer.github.io/OCepi/reference/time_between.md)
calculates the time elapsed between two dates in the following units:
days, weeks, months and years. Value is always rounded down to account
for complete elapsed time. Note: order of dates does not necessarily
matter, but beware of sign.

``` r
episode_date = as.Date("2020-04-01")
death_date = as.Date("2020-05-15")

time_between(death_date, episode_date, unit = "days")
#> [1] 44
time_between(episode_date, death_date, unit = "days")
#> [1] -44

dob = as.Date("1986-04-01")
vaccine_date = as.Date("2023-05-15")

time_between(vaccine_date, dob, unit = "years")
#> [1] 37
time_between(dob, vaccine_date, unit = "years")
#> [1] -37
```
