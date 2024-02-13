OCepi - Vignette
================

- [Basic Data Cleaning](#basic-data-cleaning)
  - [Recoding Patient Data](#recoding-patient-data)
  - [Misc Data Cleaning](#misc-data-cleaning)
  - [VRBIS](#vrbis)
- [Data Masking](#data-masking)
  - [Suppression](#suppression)
  - [Redaction](#redaction)
- [Grouping Patients in Time](#grouping-patients-in-time)
  - [MMWR](#mmwr)
  - [Respiratory Season](#respiratory-season)
  - [Month](#month)
- [Data Management](#data-management)
  - [Data.frames](#dataframes)
- [Data Visualizations](#data-visualizations)
  - [Plot Themes](#plot-themes)

The functions in this package were designed to simplify the most
frequent recoding tasks. Patient data is *messy*, often times requiring:
converting abbreviations to full responses, coalescing race and
ethnicity to a unified column, fixing all the variations of misspelled
city names, or grouping patients into time by week/month/year.

The examples below will use the simulated outbreak data:

    #> # A tibble: 10 × 5
    #>    Ethnicity              Race                 Gender   Age `Sexual Orientation`
    #>    <chr>                  <chr>                <chr>  <dbl> <chr>               
    #>  1 Hispanic or Latino     Asian                F         63 HET                 
    #>  2 Non-Hispanic or Latino Other                F         15 UNK                 
    #>  3 Hispanic or Latino     Other                U          1 HET                 
    #>  4 Hispanic or Latino     American Indian or … F         42 DNK                 
    #>  5 Non-Hispanic or Latino Unknown              M         77 NOT                 
    #>  6 Non-Hispanic or Latino Other                M         31 HET                 
    #>  7 Non-Hispanic or Latino White                F         11 HET                 
    #>  8 Hispanic or Latino     Asian                M         60 BIS                 
    #>  9 Hispanic or Latino     Multiple Races       F         56 HET                 
    #> 10 Non-Hispanic or Latino American Indian or … F         36 HET

## Basic Data Cleaning

### Recoding Patient Data

Core Functions:

- `recode_race` - able to accept: ethnicity and race, race only, LOINC
  codes, and ‘Multi-race Status’ variable from VRBIS.

- `recode_gender` - can be used with CalREDIE or VRBIS; aims to use the
  most inclusive terms possible.

- `recode_orientation` - created specifically for CalREDIE. Expects
  CTCIAdtlDemOrient variable.

- `age_groups` - has several presets for grouping age:

  - **census zip** (from decennial)**:** 0-4, 5-9, 10-14, 15-17, 18-19,
    20, 21, 22-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50-54, 55-59,
    60-61, 62-64, 65-66, 67-69, 70-74, 75-79, 80-84, 85+
  - **covid:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75-84,
    85+
  - **decade:** 0-9, 10-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70-79,
    80+
  - **enteric:** 0-4, 5-14, 15-24, 25-44, 45-64, 65+
  - **flu vax:** 0-18, 19-49, 50-64, 65+
  - **hcv:** 0-17, 18-29, 30-39, 40-49, 50+
  - **mpox:** 0-15, 16-24, 25-34, 35-44, 45-54, 55-64, 65+
  - **school:** 0-4, 5-11, 12-17, 18-64, 65+
  - **wnv:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65+

Typical starting point in exploratory analysis is to recode
demographics.

``` r
linelist <- linelist %>%
  mutate(
    Gender = recode_gender(Gender),
    race_ethnicity = recode_race(Ethnicity, Race, abbr_names = TRUE),
    age_group = age_groups(Age, type = "school"),
    `Sexual Orientation` = recode_orientation(`Sexual Orientation`)
  )
```

`recode_race` has the option to abbreviate long category names
i.e. “American Indian or Alaska Native” to “AI/AN”. Set `abbr_names` to
FALSE for full length names.

Now run a frequency table with percentage using `add_percent` and crude
rates using `rate_per_100k`:

``` r
linelist %>%
  count(age_group) %>%
  mutate(
    percent = add_percent(n),
    rate = case_when(
      age_group == "0-4" ~ rate_per_100k(n, 100000, digits = 1),
      age_group == "5-11" ~ rate_per_100k(n, 300000, digits = 1),
      age_group == "12-17" ~ rate_per_100k(n, 500000, digits = 1),
      age_group == "18-64" ~ rate_per_100k(n, 1000000, digits = 1),
      age_group == "65+" ~ rate_per_100k(n, 2000000, digits = 1)
      )
    )
#> # A tibble: 5 × 4
#>   age_group     n percent  rate
#>   <fct>     <int>   <dbl> <dbl>
#> 1 0-4         250     5   250  
#> 2 5-11        394     7.9 131. 
#> 3 12-17       366     7.3  73.2
#> 4 18-64      2562    51.2 256. 
#> 5 65+        1428    28.6  71.4
```

### Misc Data Cleaning

Core functions:

- `recode_ctract` - removes state (##) and county fips code (###) from
  census tract. Useful if joining to shapefiles or health places index.
- `clean_phone` - reformat phone number to U.S. 10 digit number. Useful
  in matching algorithms or preparing line lists for contact tracing.
- `clean_address` - convert address to title casing with option to
  `keep_extra` components such as apartment, unit, etc. Useful in
  preparing data for geocoding or matching.
- `pretty_words` - convert messy string to title casing

All of the functions below can be applied to data.frames within
`dplyr::mutate`:

``` r
recode_ctract("06059099244")
#> [1] "099244"

clean_phone("(714) 998-8172")
#> [1] "7149988172"

clean_address("1234 Main Street Apt 204", keep_extra = TRUE)
#> [1] "1234 Main Street Apartment 204"

clean_address("1234 Main Street Apt 204", keep_extra = FALSE)
#> [1] "1234 Main Street"

pretty_words("MeSsY dAtA gIvEs Me A hEaDaChe")
#> [1] "Messy Data Gives Me A Headache"
```

### VRBIS

Core functions:

- `vrbis_manner_death` - expects “Manner of Death” variable, follows
  CCDF data dictionary
- `vrbis_place_death` - expects “Place of Death (Facility)”, follows
  CCDF data dictionary
- `vrbis_resident` - determine if death belongs to your local health
  jurisdiction

``` r
vrbis_manner_death("A")
#> [1] "Accident"

vrbis_place_death(6)
#> [1] "LTCF"
```

To use `vrbis_resident`, you will need to know your county fips code and
CCDF county code (from appendix G). Returned output is 0/1 where 1
indicates death belongs to your county. For columns, you’ll need (in
order): “Place of Death (Facility)”, “County of Death (Code)”,
“Decedents County of Residence (NCHS Code)”. Next, plug in your fips
code to `fips` and CCDF county code to `county` arguments.

``` r
df <- df %>%
  mutate(
    lhj_resident = vrbis_resident(
      place_of_death,
      county_of_death_code,
      decedents_county_of_residence_NCHS_Code,
      fips = "059",
      county = "30"
      )
    ) %>%
  filter(lhj_resident == 1)
```

## Data Masking

### Suppression

Small cell sizes may need to be suppressed to protect patient
confidentiality prior to reporting. In this example, any cell sizes
`less_than` 5 will be suppressed and `replace_with` double asterisk.

``` r
linelist %>% count(Gender) %>% mutate(n_suppress = suppress(n, less_than = 5, replace_with = "**"))
#> # A tibble: 5 × 3
#>   Gender                n n_suppress
#>   <chr>             <int> <chr>     
#> 1 Female             2187 2187      
#> 2 Male               2224 2224      
#> 3 Missing/Unknown     583 583       
#> 4 Transgender man       2 **        
#> 5 Transgender woman     4 **
```

### Redaction

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

## Grouping Patients in Time

### MMWR

Core Functions:

- `mmwr_year` - calculate epidemiological year
- `mmwr_week` - calculate epidemiological week (or disease week)
- `week_ending_date` - calculate Saturday of disease week
- `mmwr_calendar` - returns data.frame with columns for disease week,
  week start and end date, for a given epidemiological year

Epidemiologists typically group cases by epidemiological year or week.
From CDC:

“The first day of any MMWR week is Sunday. MMWR week numbering is
sequential beginning with 1 and incrementing with each week to a maximum
of 52 or 53. MMWR week 1 of an MMWR year is the first week of the year
that has at least four days in the calendar year. For example, if
January 1 occurs on a Sunday, Monday, Tuesday or Wednesday, the calendar
week that includes January 1 would be MMWR week 1. If January 1 occurs
on a Thursday, Friday, or Saturday, the calendar week that includes
January 1 would be the last MMWR week of the previous year (52 or 53).
Because of this rule, December 29, 30, and 31 could potentially fall
into MMWR week 1 of the following MMWR year.”

``` r
date_seq = seq.Date(from = as.Date("2023-10-01"), to = as.Date("2024-09-28"), by = "day")

mmwr <- data.frame(spec_date = sample(date_seq, 20, replace = FALSE))

mmwr <- mmwr %>%
  arrange(spec_date) %>%
  mutate(
  epi_year = mmwr_year(spec_date),
  disease_week = mmwr_week(spec_date),
  week_ending = week_ending_date(spec_date)
  )

head(mmwr)
#>    spec_date epi_year disease_week week_ending
#> 1 2023-10-05     2023           40  2023-10-07
#> 2 2023-10-19     2023           42  2023-10-21
#> 3 2023-10-21     2023           42  2023-10-21
#> 4 2023-10-25     2023           43  2023-10-28
#> 5 2023-11-14     2023           46  2023-11-18
#> 6 2023-11-30     2023           48  2023-12-02
```

Presenting time series data by disease week with no other time reference
is typically not helpful. The reader is left guessing when disease week
27 or 46 is. If needed you can convert backward to week ending date from
year and week:

``` r
mmwr <- mmwr %>%
  mutate(
    week_ending2 = mmwrweek_to_date(epi_year, disease_week)
  )

head(mmwr)
#>    spec_date epi_year disease_week week_ending week_ending2
#> 1 2023-10-05     2023           40  2023-10-07   2023-10-07
#> 2 2023-10-19     2023           42  2023-10-21   2023-10-21
#> 3 2023-10-21     2023           42  2023-10-21   2023-10-21
#> 4 2023-10-25     2023           43  2023-10-28   2023-10-28
#> 5 2023-11-14     2023           46  2023-11-18   2023-11-18
#> 6 2023-11-30     2023           48  2023-12-02   2023-12-02
```

Use `mmwr_calendar` whenever you need to know total MWWR weeks in a
given epidemiological year, or week start/end dates

``` r
mmwr_calendar(2023) %>%
  head(20)
#>    Year Week      Start        End
#> 1  2023    1 2023-01-01 2023-01-07
#> 2  2023    2 2023-01-08 2023-01-14
#> 3  2023    3 2023-01-15 2023-01-21
#> 4  2023    4 2023-01-22 2023-01-28
#> 5  2023    5 2023-01-29 2023-02-04
#> 6  2023    6 2023-02-05 2023-02-11
#> 7  2023    7 2023-02-12 2023-02-18
#> 8  2023    8 2023-02-19 2023-02-25
#> 9  2023    9 2023-02-26 2023-03-04
#> 10 2023   10 2023-03-05 2023-03-11
#> 11 2023   11 2023-03-12 2023-03-18
#> 12 2023   12 2023-03-19 2023-03-25
#> 13 2023   13 2023-03-26 2023-04-01
#> 14 2023   14 2023-04-02 2023-04-08
#> 15 2023   15 2023-04-09 2023-04-15
#> 16 2023   16 2023-04-16 2023-04-22
#> 17 2023   17 2023-04-23 2023-04-29
#> 18 2023   18 2023-04-30 2023-05-06
#> 19 2023   19 2023-05-07 2023-05-13
#> 20 2023   20 2023-05-14 2023-05-20
```

### Respiratory Season

For epidemiologists working viral respiratory surveillance,
patients/laboratory results can also be categorized by season. Season in
this context spans week 40 of current year to week 39 of following year.

``` r
df <- data.frame(spec_date = as.Date(c("2023-10-01","2023-11-04","2024-09-28","2024-09-29")))

df %>% mutate(season = assign_season(spec_date))
#>    spec_date  season
#> 1 2023-10-01 2023-24
#> 2 2023-11-04 2023-24
#> 3 2024-09-28 2023-24
#> 4 2024-09-29 2024-25
```

### Month

An alternative to grouping cases at the year or week level is by month.

``` r
df <- data.frame(spec_date = as.Date(c("2023-10-01","2023-11-04","2024-09-28","2024-09-29")))

df %>% mutate(month = to_month(spec_date))
#>    spec_date      month
#> 1 2023-10-01 2023-10-01
#> 2 2023-11-04 2023-11-01
#> 3 2024-09-28 2024-09-01
#> 4 2024-09-29 2024-09-01
```

The returned output is a date formatted YYYY-MM-01. This can further be
customized if importing into Tableau or using ggplot2.

## Data Management

### Data.frames

Core functions:

- `batch_load` - import all .CSV files from a directory into unified
  data.frame
- `remove_empty_cols` - drop all columns from data.frame that are blank
  (represented by `NA` or ““)

To batch load .csv files, a list of files from a directory is required.
Specify if your files have `col_names`.

``` r
files <- list.files(path = "G:/file_path/", full.names = TRUE, pattern = ".csv")

df <- batch_load(files, col_names = TRUE)
```

Shrink large datasets by dropping columns that are completely
empty/blank. Message printed to console with total columns dropped.

``` r
df <- data.frame(a = c(NA,NA,NA), b = c("","",""), c = c(1,2,3))
print(df)
#>    a b c
#> 1 NA   1
#> 2 NA   2
#> 3 NA   3

df <- remove_empty_cols(df)
#> 2 columns dropped.
print(df)
#>   c
#> 1 1
#> 2 2
#> 3 3
```

## Data Visualizations

### Plot Themes

Core functions:

- `theme_apollo` - standardized branding for plots across the
  surveillance branches
- `apollo_label` - labels that match branding aesthetic
- `n_percent` - format labels using frequency and percentage to improve
  clarity

Building off of the outbreak data:

``` r
linelist %>%
  count(age_group) %>%
  ggplot(aes(x = age_group, y = n)) +
  geom_col()
```

![](figures/vignette-boring-plot-1.png)<!-- -->

Now apply `theme_apollo` and specify titles/axes labels:

``` r
linelist %>%
  count(age_group) %>%
  mutate(
    percent = add_percent(n),
    label = n_percent(formatC(n, big.mark = ","), percent, reverse = TRUE)
  ) %>%
  ggplot(aes(x = age_group, y = percent, label = label)) +
  geom_col(fill = "#283747") +
  scale_y_continuous(expand = c(0,0), limits = c(0,60)) +
  theme_apollo(direction = "vertical") +
  labs(
    title = "Title Goes Here",
    subtitle = "Subtitle Goes Here",
    x = "Age Groups (Years)",
    y = "Percentage (%)"
  ) +
  apollo_label(direction = "vertical")
```

![](figures/vignette-nice-plot-1.png)<!-- -->

Note: when using `coord_flip` for horizontal bar charts, set `direction`
to “horizontal”.
