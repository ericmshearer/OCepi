# Recode Sexual Orientation in CalREDIE

Made specifically for CaLREDIE UDF data export. Recode abbreviations to
full names.

## Usage

``` r
recode_orientation(col)
```

## Arguments

- col:

  CTCIAdtlDemOrient column from CalREDIE.

## Value

Recoded column as character.

## Examples

``` r
recode_orientation("BIS")
#> [1] "Bisexual"
recode_orientation(NA)
#> [1] "Missing/Unknown"
```
