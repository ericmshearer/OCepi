OCepi Package
================

- <a href="#common-data-cleaning-functions"
  id="toc-common-data-cleaning-functions">Common Data Cleaning
  Functions</a>
  - <a href="#add-percent" id="toc-add-percent">Add Percent</a>
  - <a href="#age-groups" id="toc-age-groups">Age Groups</a>
  - <a href="#apply-suppression" id="toc-apply-suppression">Apply
    Suppression</a>
  - <a href="#assign-respiratory-season"
    id="toc-assign-respiratory-season">Assign Respiratory Season</a>
  - <a href="#batch-loading-vrbis" id="toc-batch-loading-vrbis">Batch
    loading VRBIS</a>
  - <a href="#clean-address" id="toc-clean-address">Clean Address</a>
  - <a href="#closest-city-match" id="toc-closest-city-match">Closest City
    Match</a>
  - <a href="#complete-dates" id="toc-complete-dates">Complete Dates</a>
  - <a href="#pretty-words" id="toc-pretty-words">Pretty Words</a>
  - <a href="#recode-gender" id="toc-recode-gender">Recode Gender</a>
  - <a href="#recode-raceethnicity" id="toc-recode-raceethnicity">Recode
    Race/Ethnicity</a>
  - <a href="#remove-empty-columns" id="toc-remove-empty-columns">Remove
    Empty Columns</a>
  - <a href="#split-and-print-dataframe"
    id="toc-split-and-print-dataframe">Split and Print Dataframe</a>
  - <a href="#find-mmwr-date" id="toc-find-mmwr-date">Find MMWR Date</a>
  - <a href="#find-month-date" id="toc-find-month-date">Find Month Date</a>
  - <a href="#find-week-ending-date" id="toc-find-week-ending-date">Find
    Week Ending Date</a>
- <a href="#cair2-data-cleaning-functions"
  id="toc-cair2-data-cleaning-functions">CAIR2 Data Cleaning Functions</a>
  - <a href="#baby-first-name" id="toc-baby-first-name">Baby First Name</a>
- <a href="#r-markdown-templates" id="toc-r-markdown-templates">R Markdown
  Templates</a>
  - <a href="#workflow-documentation"
    id="toc-workflow-documentation">Workflow Documentation</a>

<img src="www/hex_sticker.png" width="318" />

**Last Updated:** 10/20/2023

This R Markdown document provides an overview of the available data
cleaning functions in the OCepi package. This package is under active
development - any issues/bugs found please contact <eshearer@ochca.com>.

## Common Data Cleaning Functions

### Add Percent

Fast method to add proportion column following count(). Options to : 1)
adjust rounding (default set to one digit), 2) whether or not to
`multiply` by 100 (default set to TRUE).

``` r
freq_tbl <- data.frame(location = letters[1:5], patients = c(10, 20, 11, 3, 16))

freq_tbl %>%
  add_percent(digits = 1, multiply = TRUE)
##   location patients proportion
## 1        a       10       16.7
## 2        b       20       33.3
## 3        c       11       18.3
## 4        d        3        5.0
## 5        e       16       26.7
```

<br>

### Age Groups

Recode age variable to groups using presets. Output variable set to
factor to ensure order. Default for `type` set to “decade” when not
specified. Current options:

- **covid:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75-84, 85+
- **decade:** 0-9, 10-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80+
- **enteric:** 0-4, 5-14, 15-24, 25-44, 45-64, 65+
- **flu vax:** 0-18, 19-49, 50-64, 65+
- **hcv:** 0-17, 18-29, 30-39, 40-49, 50+
- **mpox:** 0-15, 16-24, 25-34, 35-44, 45-54, 55-64, 65+
- **school:** 0-4, 5-11, 12-17, 18-64, 65+
- **wnv:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65+

``` r
test_df <- data.frame(Ages = floor(runif(200, min = 0, max = 99)))

test_df$agegrp <- age_groups(test_df$Ages, type = "decade")

table(test_df$agegrp)
## 
##             0-9           10-19           20-29           30-39           40-49 
##              23              23              17              24              14 
##           50-59           60-69           70-79             80+ Missing/Unknown 
##              21              16              29              33               0
```

<br>

### Apply Suppression

Useful for masking categorical counts below a specified threshold when
reporting data externally. User can specify `threshold` when suppression
occurs and what value to replace suppressed values with
(`replace_with`).

``` r
df <- data.frame(Counts = c(5, 1, 10, 3, 12, 9, 4))

df$Counts_Suppressed <- apply_suppression(df$Counts, threshold = 5, replace_with = "**")

print(df)
##   Counts Counts_Suppressed
## 1      5                 5
## 2      1                **
## 3     10                10
## 4      3                **
## 5     12                12
## 6      9                 9
## 7      4                **
```

<br>

### Assign Respiratory Season

Made specifically for respiratory virus surveillance. Function
calculates season in XXXX-XX format from input date. Season is defined
as week 40 of current year to week 39 of following year.

``` r
x = as.Date("2023-10-01")

assign_season(x)
```

<br>

### Batch loading VRBIS

Use this function to pull a list of death files into R for analysis.
This function is limited to just loading VRBIS. This function assumes
your files do not have column names.

``` r
death_files <- list.files(path = "G:/file_path/", full.names = TRUE, pattern = "^death")[31:38]

combo_death <- batch_load_vrbis(death_files)
```

<br>

### Clean Address

Clean up common abbreviations in addresses (e.g. St, Blvd, Rd) with
option `keep_extra` to keep/remove extra address information (e.g. Apt
4, Spc 83). Default for `keep_extra` set to TRUE when not specified.

``` r
patient_address = "1234 Main Street Apt 204"

clean_address(patient_address, keep_extra = TRUE)
## [1] "1234 Main Street Apartment 204"
```

<br>

### Closest City Match

Convenient row-wise approach to fix misspelled city names. First pass
will look for “homeless”. Second pass will clean-up
neighborhood/non-city names/abbreviations (e.g. HB, El Toro, Capo
Beach). Final pass will compare city to list of cleanly formatted city
names and return the closest match below the set `threshold` (default
set to 0.15). You may adjust the `threshold` but a word of caution - the
higher the value, the more likely a false match.

To run this function, you will need: package stringdist and a helper
file with clean city names.

``` r
oc_cities <- read.csv("G:/file_path/helper_file.csv", na.strings = "", stringsAsFactors = FALSE) %>%
  select(City) %>%
  unique()

fake_data <- data.frame(City = c("Anahem","El Toro","Los Angeles","Hntington Bch"," Ornge","Capo Beach","FOOTHILL RANCH"))

fake_data %>%
  rowwise() %>%
  mutate(clean_city = closest_city_match(City, oc_cities$City, threshold = 0.15))
```

<br>

### Complete Dates

Fill in missing dates from time series. `Level` options: day, week,
month. You must specify when you want to start filling in dates using
`start_date` argument. Works nicely following count().

``` r
tseries <- data.frame(
  Dates = c("2023-01-01","2023-02-01","2023-05-01","2023-09-01"),
  Cases = c(2,4,1,6)
  )

tseries$Dates <- as.Date(tseries$Dates)

tseries %>%
  complete_dates(start_date = min(tseries$Dates), level = "month")
##        Dates Cases
## 1 2023-01-01     2
## 2 2023-02-01     4
## 5 2023-03-01    NA
## 6 2023-04-01    NA
## 3 2023-05-01     1
## 7 2023-06-01    NA
## 8 2023-07-01    NA
## 9 2023-08-01    NA
## 4 2023-09-01     6
```

<br>

### Pretty Words

Convert messy string to title casing.

``` r
test_string = "MeSsY dAtA gIvEs Me A hEaDaChe"

pretty_words(test_string)
## [1] "Messy Data Gives Me A Headache"
```

<br>

### Recode Gender

Function specifically for cleaning CalREDIE data. CalREDIE uses 1-2
letter abbreviations for gender. Use argument `ordered` to return output
as factor (default = TRUE) or character (FALSE).

``` r
fake_udf <- data.frame(Gender = c("F","M","D","D","U","TF","TF","TM","I","G",NA))

fake_udf %>%
  mutate(Gender_new = recode_gender(Gender, ordered = TRUE))
##    Gender             Gender_new
## 1       F                 Female
## 2       M                   Male
## 3       D        Missing/Unknown
## 4       D        Missing/Unknown
## 5       U        Missing/Unknown
## 6      TF      Transgender woman
## 7      TF      Transgender woman
## 8      TM        Transgender man
## 9       I    Identity Not Listed
## 10      G Genderqueer/Non-binary
## 11   <NA>        Missing/Unknown
```

<br>

### Recode Race/Ethnicity

Function specifically for cleaning CalREDIE and CAIR2 data. Hierarchy
defaults to Hispanic/Latinx regardless of reported race. Able to accept
ethnicity and race, or just one single race/ethnicity variable. If using
ethnicity and race, argument order should be ethnicity then race.

``` r
recode_race("Hispanic or Latino","Asian")
## [1] "Hispanic/Latinx"

recode_race("Black or African American")
## [1] "Black/African American"

recode_race("Not Hispanic or Latino","Black or African American")
## [1] "Black/African American"
```

<br>

### Remove Empty Columns

Make large datasets more manageable by dropping columns that are
completely empty.

``` r
test <- data.frame(a = c(NA,NA,NA), b = c("","",""), c = c(1,2,3))
remove_empty_cols(test)
##   c
## 1 1
## 2 2
## 3 3
```

<br>

### Split and Print Dataframe

Ability to take a dataframe, split into smaller dataframes with
specified number of rows, then print as .CSV to specified path. Use
`prefix` to set a custom prefix, otherwise default to set “List”.

``` r
split_df(path = "G:/file_path/", df = test_data, chunks = 200, prefix = "helloworld_")
```

<br>

### Find MMWR Date

Calculate disease week or epidemiological year from input date. Must
specify `types`: week, year, or both

``` r
episode_date = as.Date("2015-01-01")

to_mmwr_date(episode_date, type = "week")
## [1] 53
to_mmwr_date(episode_date, type = "year")
## [1] 2014
to_mmwr_date(episode_date, type = "both")
## [1] "2014-53"
```

<br>

### Find Month Date

Calculate month from input date. Returned format is `YYYY-MM-01`.

``` r
episode_date = as.Date("2015-01-01")

to_month(episode_date)
## [1] "2015-01-01"
```

<br>

### Find Week Ending Date

Calculate week ending date (Saturday) from input date.

``` r
episode_date = as.Date("2015-01-01")

week_ending_date(episode_date)
## [1] "2015-01-03"
```

<br>

## CAIR2 Data Cleaning Functions

### Baby First Name

Remove iterations of “baby” from recipient first name.

``` r
baby_name("BABYBOY")
## [1] NA

baby_name("Twin Girl")
## [1] NA
```

<br>

## R Markdown Templates

### Workflow Documentation

For all projects, including routine surveillance analysis, use workflow
template to explain what/how your script works. Once a R Project is
created, go to File \> New File \> R Markdown. Select “From Template”,
then “Epi Workflow”. Keep this file in your main project directory in
case another epidemiologist needs to run script as backup.
