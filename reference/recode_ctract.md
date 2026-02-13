# Recode VRBIS Census Tract

Remove state and county fips code from census tract for
matching/joining.

## Usage

``` r
recode_ctract(col)
```

## Arguments

- col:

  Expects "Residence Census Tract 2010" variable from VRBIS dataset.

## Value

Recoded census tract as character.

## Examples

``` r
recode_ctract("06059099244")
#> [1] "099244"
recode_ctract(as.numeric("06059099244"))
#> [1] "099244"
```
