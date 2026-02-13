# Data Suppression for Low Category Frequencies

Mask values/counts below a specified threshold to maintain patient
confidentiality.

## Usage

``` r
suppress(n, less_than = 5, replace_with = "**")
```

## Arguments

- n:

  Input field to be suppressed.

- less_than:

  Maximum value for suppression.

- replace_with:

  Value to use when input field is suppressed. String, numeric, or NA.

## Value

Suppressed value.

## Examples

``` r
df <- data.frame(Counts = c(5, 1, 10, 3, 12, 9, 4))
df$Counts_Suppressed <- suppress(df$Counts, less_than = 5, replace_with = "**")
df
#>   Counts Counts_Suppressed
#> 1      5                 5
#> 2      1                **
#> 3     10                10
#> 4      3                **
#> 5     12                12
#> 6      9                 9
#> 7      4                **
```
