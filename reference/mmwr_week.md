# Date to MMWR Disease Week

Following CDC MMWR schema, calculate week number based on input date.

## Usage

``` r
mmwr_week(date)
```

## Arguments

- date:

  Input date i.e. episode date, specimen collection date.

## Value

Epidemiological week per MMWR schema.

## Details

From CDC: The first day of any MMWR week is Sunday. MMWR week numbering
is sequential beginning with 1 and incrementing with each week to a
maximum of 52 or 53. MMWR week \#1 of an MMWR year is the first week of
the year that has at least four days in the calendar year. For example,
if January 1 occurs on a Sunday, Monday, Tuesday or Wednesday, the
calendar week that includes January 1 would be MMWR week \#1. If January
1 occurs on a Thursday, Friday, or Saturday, the calendar week that
includes January 1 would be the last MMWR week of the previous year (#52
or \#53). Because of this rule, December 29, 30, and 31 could
potentially fall into MMWR week \#1 of the following MMWR year.

## Examples

``` r
episode_date = as.Date("2020-01-14")
mmwr_week(episode_date)
#> [1] 3
```
