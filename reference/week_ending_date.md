# Week Ending Date

Calculate week ending date following CDC MMWR schema.

## Usage

``` r
week_ending_date(date)
```

## Arguments

- date:

  Input date.

## Value

Output date.

## Examples

``` r
episode_date = as.Date("2020-01-14")
week_ending_date(episode_date)
#> [1] "2020-01-18"
```
