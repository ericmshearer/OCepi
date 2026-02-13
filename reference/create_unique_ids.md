# Create Unique Alphanumeric ID's

Create Unique Alphanumeric ID's

## Usage

``` r
create_unique_ids(n, char_len = 12)
```

## Arguments

- n:

  Numeric or integer, how many ID's do you need.

- char_len:

  Numeric or integer, total ID character length. Default set to 12.

## Value

Character, length of n unique ID's.

## Examples

``` r
create_unique_ids(n = 5)
#> [1] "Sy0ISrwZQdHO" "rDslYqjRmVMu" "JacgWfAlMkPN" "1WRZorR1u5Cj" "cJSLnb4eYrKP"
```
