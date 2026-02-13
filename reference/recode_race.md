# Recode Race/Ethnicity

Simplify race/ethnicity patient data to one variable using data from
CalREDIE, CAIR2, VRBIS, or LOINC codes. Hierarchy defaults to
Hispanic/Latinx regardless of reported race. Function can handle one
(e.g. CAIR2) or two inputs (e.g. CalREDIE). If using with VRBIS dataset,
expected input is "Multi-status Race" column.

## Usage

``` r
recode_race(ethnicity, race, abbr_names = FALSE)
```

## Arguments

- ethnicity:

  Patient ethnicity variable.

- race:

  Patient race variable.

- abbr_names:

  TRUE/FALSE, option to abbreviate long category names.

## Value

Merged race/ethnicity variable.

## Examples

``` r
recode_race("Hispanic","Black or African American")
#> [1] "Hispanic/Latinx"
recode_race("Native Hawaiian or Other Pacific Islander", abbr_names = FALSE)
#> [1] "Native Hawaiian/Other Pacific Islander"
recode_race("1")
#> [1] "White"
```
