Date & Time Conversions/Calculations
================

- [MMWR](#mmwr)
- [Respiratory Season](#respiratory-season)
- [Month](#month)
- [Time Between Dates](#time-between-dates)

## MMWR

Core Functions:

- `mmwr_year` - calculate epidemiological year
- `mmwr_week` - calculate epidemiological week (or disease week)
- `week_ending_date` - calculate Saturday of disease week
- `mmwr_calendar` - returns data.frame with columns for disease week,
  week start and end date, for a given epidemiological year
- `mmwrweek_to_date` - calculate week ending date from epidemiological
  year and week

``` r
dates <- linelist %>%
  select(`Specimen Date`) %>%
  mutate(`Specimen Date` = as.Date(`Specimen Date`, format = "%m/%d/%Y")) %>%
  arrange(`Specimen Date`) %>%
  mutate(
    epi_year = mmwr_year(`Specimen Date`),
    disease_week = mmwr_week(`Specimen Date`),
    week_ending = week_ending_date(`Specimen Date`)
  )

head(dates)
#> # A tibble: 6 × 4
#>   `Specimen Date` epi_year disease_week week_ending
#>   <date>             <dbl>        <dbl> <date>     
#> 1 2022-06-04          2022           22 2022-06-04 
#> 2 2022-06-04          2022           22 2022-06-04 
#> 3 2022-06-04          2022           22 2022-06-04 
#> 4 2022-06-05          2022           23 2022-06-11 
#> 5 2022-06-05          2022           23 2022-06-11 
#> 6 2022-06-06          2022           23 2022-06-11
```

Convert epidemiological year and week to week ending date:

``` r
dates <- dates %>%
  select(epi_year, disease_week) %>%
  mutate(
    week_ending = mmwrweek_to_date(epi_year, disease_week)
  )

head(dates)
#> # A tibble: 6 × 3
#>   epi_year disease_week week_ending
#>      <dbl>        <dbl> <date>     
#> 1     2022           22 2022-06-04 
#> 2     2022           22 2022-06-04 
#> 3     2022           22 2022-06-04 
#> 4     2022           23 2022-06-11 
#> 5     2022           23 2022-06-11 
#> 6     2022           23 2022-06-11
```

To make `mmwr_calendar` with total disease weeks + start/end dates:

``` r
mmwr_calendar(2023) %>%
  head(20)
#>    Year Week      Start        End
#> 1  2023    1 2023-01-01 2023-01-07
#> 2  2023    2 2023-01-08 2023-01-14
#> 3  2023    3 2023-01-15 2023-01-21
#> 4  2023    4 2023-01-22 2023-01-28
#> 5  2023    5 2023-01-29 2023-02-04
#> 6  2023    6 2023-02-05 2023-02-11
#> 7  2023    7 2023-02-12 2023-02-18
#> 8  2023    8 2023-02-19 2023-02-25
#> 9  2023    9 2023-02-26 2023-03-04
#> 10 2023   10 2023-03-05 2023-03-11
#> 11 2023   11 2023-03-12 2023-03-18
#> 12 2023   12 2023-03-19 2023-03-25
#> 13 2023   13 2023-03-26 2023-04-01
#> 14 2023   14 2023-04-02 2023-04-08
#> 15 2023   15 2023-04-09 2023-04-15
#> 16 2023   16 2023-04-16 2023-04-22
#> 17 2023   17 2023-04-23 2023-04-29
#> 18 2023   18 2023-04-30 2023-05-06
#> 19 2023   19 2023-05-07 2023-05-13
#> 20 2023   20 2023-05-14 2023-05-20
```

## Respiratory Season

For epidemiologists working viral respiratory surveillance,
patients/laboratory results can also be categorized by season. Season in
this context spans week 40 of current year to week 39 of following year.

``` r
df <- data.frame(spec_date = as.Date(c("2023-10-01","2023-11-04","2024-09-28","2024-09-29")))

df %>% mutate(season = assign_season(spec_date))
#>    spec_date  season
#> 1 2023-10-01 2023-24
#> 2 2023-11-04 2023-24
#> 3 2024-09-28 2023-24
#> 4 2024-09-29 2024-25
```

## Month

An alternative to grouping cases at the year or week level is by month.
Returned output is a date formatted YYYY-MM-01.

``` r
df <- data.frame(spec_date = as.Date(c("2023-10-01","2023-11-04","2024-09-28","2024-09-29")))

df %>% mutate(month = to_month(spec_date))
#>    spec_date      month
#> 1 2023-10-01 2023-10-01
#> 2 2023-11-04 2023-11-01
#> 3 2024-09-28 2024-09-01
#> 4 2024-09-29 2024-09-01
```

## Time Between Dates

`time_between` calculates the time elapsed between two dates in the
following units: days, weeks, months and years. Value is always rounded
down to account for complete elapsed time. Note: order of dates does not
necessarily matter, but beware of sign.

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
