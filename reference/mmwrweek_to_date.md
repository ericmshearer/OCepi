# Convert Disease Week to Week Ending Date

When calendar date is unknown, convert disease week to week ending date.

## Usage

``` r
mmwrweek_to_date(year, week)
```

## Arguments

- year:

  MMWR Year.

- week:

  MMWR Week.

## Value

Week ending date (Saturday).

## Examples

``` r
mmwrweek_to_date(2023, 52)
#> [1] "2023-12-30"
```
