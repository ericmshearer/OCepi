# Recode VRBIS Place of Death

Convert number to full responses per CCDF data dictionary.

## Usage

``` r
vrbis_place_death(col)
```

## Arguments

- col:

  Expects "Place of Death (Facility)" column from VRBIS dataset.

## Value

Recoded response as character.

## Examples

``` r
vrbis_place_death(6)
#> [1] "LTCF"
vrbis_place_death("6")
#> [1] "LTCF"
```
