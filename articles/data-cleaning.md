# data-cleaning

The functions in this package were designed to simplify and standardize
the most frequent recoding tasks. The examples below will use simulated
outbreak data included in this package.

    #> # A tibble: 10 × 6
    #>    Ethnicity              Race       Gender   Age SexualOrientation SpecimenDate
    #>    <chr>                  <chr>      <chr>  <dbl> <chr>             <date>      
    #>  1 Non-Hispanic or Latino Multiple … M         46 HET               2022-06-07  
    #>  2 Unknown                Unknown    M          4 HET               2022-06-09  
    #>  3 Non-Hispanic or Latino White      F         52 UNK               2022-06-07  
    #>  4 Non-Hispanic or Latino White      F         77 UNK               2022-06-11  
    #>  5 Unknown                American … M         71 HET               2022-06-10  
    #>  6 Non-Hispanic or Latino Other      M         70 HET               2022-06-09  
    #>  7 Non-Hispanic or Latino Black or … F         11 HET               2022-06-08  
    #>  8 Non-Hispanic or Latino Black or … F          8 HET               2022-06-12  
    #>  9 Hispanic or Latino     American … F         41 HET               2022-06-12  
    #> 10 Non-Hispanic or Latino Black or … M         56 HET               2022-06-10

## recode_race()

[`recode_race()`](https://ericmshearer.github.io/OCepi/reference/recode_race.md)
can be used several different ways: ethnicity and race (CalREDIE), race
only (CAIR2), LOINC codes (Syndromic, thank you Monterey for
suggestion), and ‘Multi-race Status’ (VRBIS). If recoding using
ethnicity and race, order should be `recode_race(ethnicity, race)`. To
abbreviate long categories (i.e. Native Hawaiian/Other Pacific Islander
to NHOPI), set `abbr_names` to TRUE.

``` r
linelist |>
  mutate(
    race_ethnicity = recode_race(Ethnicity, Race, abbr_names = FALSE)
  ) |>
  count(race_ethnicity)
#> # A tibble: 9 × 2
#>   race_ethnicity                             n
#>   <chr>                                  <int>
#> 1 American Indian/Alaska Native             10
#> 2 Asian                                      7
#> 3 Black/African American                    16
#> 4 Hispanic/Latinx                           19
#> 5 Missing/Unknown                            8
#> 6 Multiple Races                             6
#> 7 Native Hawaiian/Other Pacific Islander    10
#> 8 Other                                     15
#> 9 White                                     14
```

Other use cases:

``` r
recode_race("2028-9") #Syndromic/ESSENCE
#> [1] "Asian"

recode_race("3") #VRBIS
#> [1] "American Indian/Alaska Native"
```

## recode_gender()

Can be used with CalREDIE, VRBIS, and CAIR2 (or really any other dataset
that abbreviates their gender variable to single letters).

``` r
linelist |>
  mutate(Gender = recode_gender(Gender)) |>
  count(Gender)
#> # A tibble: 3 × 2
#>   Gender              n
#>   <chr>           <int>
#> 1 Female             51
#> 2 Male               39
#> 3 Missing/Unknown    15
```

## recode_orientation()

Designed specifically for use with CalREDIE. Expects CTCIAdtlDemOrient
variable.

``` r
linelist |>
  mutate(SexualOrientation = recode_orientation(SexualOrientation)) |>
  count(SexualOrientation)
#> # A tibble: 4 × 2
#>   SexualOrientation                       n
#>   <chr>                               <int>
#> 1 Bisexual                                1
#> 2 Gay, lesbian, or same gender-loving     3
#> 3 Heterosexual or straight               89
#> 4 Missing/Unknown                        12
```

## age_groups()

“If you have to copy and paste code more than twice, create a function”.
With
[`age_groups()`](https://ericmshearer.github.io/OCepi/reference/age_groups.md),
we no longer have to copy + paste long
[`dplyr::case_when()`](https://dplyr.tidyverse.org/reference/case-and-replace-when.html)
statements to recode age to age groups.

``` r
linelist |>
  mutate(age_group = age_groups(Age), type = "decade") |>
  count(age_group)
#> # A tibble: 9 × 2
#>   age_group     n
#>   <fct>     <int>
#> 1 0-9          12
#> 2 10-19        11
#> 3 20-29        11
#> 4 30-39        13
#> 5 40-49        12
#> 6 50-59        12
#> 7 60-69         6
#> 8 70-79        17
#> 9 80+          11
```

The default age groups is set to decade, but the following presets are
available for use:

- **cair2 peds**: \<12 M, 12-15 M, 16-23 M, 24 M, 25-47 M, 4-6 Years, 6+
  Years
- **covid:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75-84, 85+
- **decade:** 0-9, 10-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80+
- **enteric:** 0-4, 5-14, 15-24, 25-44, 45-64, 65+
- **flu vax:** 0-18, 19-49, 50-64, 65+
- **hcv:** 0-17, 18-39, 40-59, 60+
- **infant:** 0-2M, 3-4M, 5-6M, 7-8M, 9-10M, 11-12M
- **mpox:** 0-15, 16-24, 25-34, 35-44, 45-54, 55-64, 65+
- **pertussis:** \<1, 1-6, 7-10, 11-19, 20+
- **school:** 0-4, 5-11, 12-17, 18-64, 65+
- **wnv:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65+

Please note: the returned output is set to factor to maintain proper
ordering.

## clean_address()

Our best attempt to standardize and clean addresses is through
[`clean_address()`](https://ericmshearer.github.io/OCepi/reference/clean_address.md).
This function will: convert characters to title casing, recode
abbreviated cardinal directions, and recode abbreviated street endings
(i.e. Street, Circle, Plaza). Set `keep_extra` to FALSE to drop
additional address data (i.e. Apartment, Unit).

``` r
cases <- data.frame(
  Address = c("1234 Main Street Apt 204","501 N Capital St","233 W Green Plz Unit 3")
)

cases |>
  mutate(
    Address_clean = clean_address(Address, keep_extra = TRUE)
    )
#>                    Address                  Address_clean
#> 1 1234 Main Street Apt 204 1234 Main Street Apartment 204
#> 2         501 N Capital St       501 North Capital Street
#> 3   233 W Green Plz Unit 3    233 West Green Plaza Unit 3
```

## clean_phone()

We also attempt to standardize phone number to a 10 digit U.S. format.
If after removing country code and symbols, and length is not 10
characters, returned value is NA.

``` r
cases <- data.frame(
  HomePhone = c("1-714-777-1234","(949) 555-1234","+442071539000")
)

cases |>
  mutate(HomePhone_clean = clean_phone(HomePhone))
#>        HomePhone HomePhone_clean
#> 1 1-714-777-1234      7147771234
#> 2 (949) 555-1234      9495551234
#> 3  +442071539000            <NA>
```

## recode_ctract()

Census tract across datasets are not always the same - some contain
state and county fips codes, some do not. To make them match, use
[`recode_ctract()`](https://ericmshearer.github.io/OCepi/reference/recode_ctract.md)
to remove state and county fips code.

``` r
recode_ctract("06059099244")
#> [1] "099244"
```

## vrbis_manner_death()

Expects “Manner of Death” variable, follows CCDF data dictionary

``` r
vrbis_manner_death("A")
#> [1] "Accident"
```

## vrbis_place_death()

Expects “Place of Death (Facility)”, follows CCDF data dictionary

``` r
vrbis_place_death(6)
#> [1] "LTCF"
```

## vrbis_resident()

To use
[`vrbis_resident()`](https://ericmshearer.github.io/OCepi/reference/vrbis_resident.md),
you will need to know your county fips code and CCDF county code
(appendix G). Returned output is 0/1 where 1 indicates death belongs to
your county. For columns, you’ll need (in order): “Place of Death
(Facility)”, “County of Death (Code)”, “Decedents County of Residence
(NCHS Code)”. Next, plug in your fips code to `fips` and CCDF county
code to `county_code` arguments.

``` r
#Example 1 - OC SNF resident
vrbis_resident(
  "6",
  "30",
  "059",
  fips = "059",
  county_code = "30"
  )
#> [1] 1

#Example 2 - OC Community Death
vrbis_resident(
  "1",
  "30",
  "059",
  fips = "059",
  county_code = "30"
  )
#> [1] 1

#Example 3 - Non-OC resident dies in OC facility
vrbis_resident(
  "1",
  "29",
  "058",
  fips = "059",
  county_code = "30"
  )
#> [1] 0
```

## suppress()

Small cell sizes may need to be suppressed to protect patient
confidentiality prior to reporting. In this example, any cell sizes
`less_than` 10 will be suppressed and `replace_with` double asterisk.

``` r
linelist |>
  mutate(age_group = age_groups(Age)) |>
  count(age_group) |>
  mutate(n_suppress = suppress(n, less_than = 10, replace_with = "**"))
#> # A tibble: 9 × 3
#>   age_group     n n_suppress
#>   <fct>     <int> <chr>     
#> 1 0-9          12 12        
#> 2 10-19        11 11        
#> 3 20-29        11 11        
#> 4 30-39        13 13        
#> 5 40-49        12 12        
#> 6 50-59        12 12        
#> 7 60-69         6 **        
#> 8 70-79        17 17        
#> 9 80+          11 11
```

## hiv_redact()

Depending on unit/program policy, any mention of HIV or AIDS may need to
be removed from the dataset. While not yet exhaustive, this function
accounts for several variations of HIV and AIDS. If found, a warning
message is printed to the console.

``` r
df <- data.frame(cause = c("cancer","hepatitis","COVID-19","HIV"))
print(df)
#>       cause
#> 1    cancer
#> 2 hepatitis
#> 3  COVID-19
#> 4       HIV

df <- hiv_redact(df)
#> Warning in hiv_redact(df): HIV/AIDS data detected.
print(df)
#>       cause
#> 1    cancer
#> 2 hepatitis
#> 3  COVID-19
#> 4
```

## baby_name()

Removes variants of baby/twin/newborn from first name. Addresses data
quality issue in birth hepatitis B doses.

``` r
baby_name("baby BOY")
#> [1] NA

baby_name("NEWBORN")
#> [1] NA

baby_name("twin A")
#> [1] NA
```

## pos()/neg()

To simplify the tedious task of recoding ELR results, we coalesced as
many common variants of “positive” and “negative” into
[`pos()`](https://ericmshearer.github.io/OCepi/reference/elr.md) and
[`neg()`](https://ericmshearer.github.io/OCepi/reference/elr.md). We
built the functions in such a way you can use them with either `%in%` or
[`grepl()`](https://rdrr.io/r/base/grep.html) string detection.

``` r
elr <- data.frame(
  Results = c("Pos","POSITIVE","DETECTED","NOT DETECTED","reactive")
)

elr <- elr |>
  mutate(
    Results = toupper(Results),
    test_result = case_when(
      Results %in% pos() ~ "Positive", #method 1
      grepl(neg(collapse = TRUE), Results, ignore.case = TRUE) ~ "Negative" #method 2
    )
  )

print(elr)
#>        Results test_result
#> 1          POS    Positive
#> 2     POSITIVE    Positive
#> 3     DETECTED    Positive
#> 4 NOT DETECTED    Negative
#> 5     REACTIVE    Positive
```
