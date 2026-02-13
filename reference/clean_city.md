# Find Closest City Match

Instead of hard coding spelling on city names, use string distance to
find the closest match and recode. For OC users, a reference list of
correctly spelled city names have been included, as well as hard coding
of common abbreviations/nicknames. For non-OC users, you will need to
provide a vector or data.frame of correctly spelled city names for
string distance matching.

## Usage

``` r
clean_city(x, reference, threshold = 0.15, redcap = FALSE, ooc = TRUE)
```

## Arguments

- x:

  Character, input city data.

- reference:

  Character, provide your own vector of correctly spelled city names for
  reference. For OC users, leave blank to use internal vector of OC city
  names.

- threshold:

  Numeric, range 0 to 1. Controls sensitivity/specificity of string
  distance matching. Default set to 0.15.

- redcap:

  Logical, convert character to numeric mapping for REDCap bulk upload.

- ooc:

  Logical, choice to keep or recode out of county cities to NA.

## Value

Character, returned city names with closest match to reference vector.

## Examples

``` r
clean_city("Anahim")
#> [1] "Anaheim"
clean_city("Anahim", redcap = TRUE)
#> [1] "1"
```
