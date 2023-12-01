OCepi Package
================

- [Common Data Cleaning Functions](#common-data-cleaning-functions)
  - [Add Percent](#add-percent)
  - [Age Groups](#age-groups)
  - [Apply Suppression](#apply-suppression)
  - [Assign Respiratory Season](#assign-respiratory-season)
  - [Batch loading VRBIS](#batch-loading-vrbis)
  - [Clean Address](#clean-address)
  - [Clean Phone Number](#clean-phone-number)
  - [Closest City Match](#closest-city-match)
  - [Complete Dates](#complete-dates)
  - [Pretty Words](#pretty-words)
  - [Recode Gender](#recode-gender)
  - [Recode Race/Ethnicity](#recode-raceethnicity)
  - [Remove Empty Columns](#remove-empty-columns)
  - [Split and Print Dataframe](#split-and-print-dataframe)
  - [Find MMWR Date](#find-mmwr-date)
  - [Find Month Date](#find-month-date)
  - [Find Week Ending Date](#find-week-ending-date)
- [CAIR2 Data Cleaning Functions](#cair2-data-cleaning-functions)
  - [Baby First Name](#baby-first-name)
- [R Markdown Templates](#r-markdown-templates)
  - [Workflow Documentation](#workflow-documentation)

<img src="www/hex_sticker.png" width="318" />

**Last Updated:** 12/01/2023

This R Markdown document provides an overview of the available data
cleaning functions in the OCepi package. Any issues/bugs found please
contact <eshearer@ochca.com>.

## Common Data Cleaning Functions

### Add Percent

Add proportion column following count(). Options to : 1) adjust rounding
(default set to one digit), 2) whether or not to `multiply`.

``` r
starwars %>%
  head(20) %>%
  count(species) %>%
  add_percent(digits = 1, multiply = TRUE)
##          species  n proportion
## 1          Droid  3         15
## 2          Human 13         65
## 3           Hutt  1          5
## 4         Rodian  1          5
## 5        Wookiee  1          5
## 6 Yoda's species  1          5
```

<br>

### Age Groups

Recode age variable to groups using presets. Output variable set to
factor to ensure order. Default for `type` set to “decade” when not
specified. Current options:

- **census zip:** 0-4, 5-9, 10-14, 15-17, 18-19, 20, 21, 22-24, 25-29,
  30-34, 35-39, 40-44, 45-49, 50-54, 55-59, 60-61, 62-64, 65-66, 67-69,
  70-74, 75-79, 80-84, 85+
- **covid:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75-84, 85+
- **decade:** 0-9, 10-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80+
- **enteric:** 0-4, 5-14, 15-24, 25-44, 45-64, 65+
- **flu vax:** 0-18, 19-49, 50-64, 65+
- **hcv:** 0-17, 18-29, 30-39, 40-49, 50+
- **mpox:** 0-15, 16-24, 25-34, 35-44, 45-54, 55-64, 65+
- **school:** 0-4, 5-11, 12-17, 18-64, 65+
- **wnv:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65+

Note: census zip should match age groups found in Decennial Census when
pulling data at the zip code level.

``` r
test_df <- data.frame(Ages = floor(runif(200, min = 0, max = 99)))

test_df$agegrp <- age_groups(test_df$Ages, type = "decade")

table(test_df$agegrp)
## 
##             0-9           10-19           20-29           30-39           40-49 
##              21              25              28              19              15 
##           50-59           60-69           70-79             80+ Missing/Unknown 
##              22              20              18              32               0
```

<br>

### Apply Suppression

Useful for masking categorical counts below a specified threshold. User
specifies `threshold` cutoff and what to replace suppressed values with.

``` r
df <- starwars %>%
  head(20) %>%
  count(species)

df$Counts_Suppressed <- apply_suppression(df$n, threshold = 5, replace_with = "**")

print(df)
## # A tibble: 6 × 3
##   species            n Counts_Suppressed
##   <chr>          <int> <chr>            
## 1 Droid              3 **               
## 2 Human             13 13               
## 3 Hutt               1 **               
## 4 Rodian             1 **               
## 5 Wookiee            1 **               
## 6 Yoda's species     1 **
```

<br>

### Assign Respiratory Season

Made specifically for respiratory virus surveillance. Function
calculates season in XXXX-XX format from input date. Season is defined
as week 40 of current year to week 39 of following year.

``` r
x = as.Date("2023-10-01")

assign_season(x)
## [1] "2023-24"
```

<br>

### Batch loading VRBIS

Input requires list of files from a directory (with full path names).
This function is limited to just loading vital records. This function
assumes your files do not have column names.

``` r
death_files <- list.files(path = "G:/file_path/", full.names = TRUE, pattern = "^death")[31:38]

combo_death <- batch_load_vrbis(death_files)
```

<br>

### Clean Address

Tidy up addresses for geocoding or matching. Use `keep_extra` to
keep/remove apartment, space, unit, etc.

``` r
patient_address = "1234 Main Street Apt 204"

clean_address(patient_address, keep_extra = TRUE)
## [1] "1234 Main Street Apartment 204"

clean_address(patient_address, keep_extra = FALSE)
## [1] "1234 Main Street"
```

<br>

### Clean Phone Number

Tidy up phone numbers to 10 digit U.S. based format.

``` r
#Local Domino's pizza
clean_phone("(714)777-6700")
## [1] "7147776700"

#Best local brewery
clean_phone("(714) 998-8172")
## [1] "7149988172"

 #Apple store in London
clean_phone("+442074471400")
## [1] NA
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
month. Specify `start_date` in case you want time series to begin prior
to the earliest known date. Works nicely following dplyr::count().

Month:

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
## 3 2023-03-01    NA
## 4 2023-04-01    NA
## 5 2023-05-01     1
## 6 2023-06-01    NA
## 7 2023-07-01    NA
## 8 2023-08-01    NA
## 9 2023-09-01     6
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
specified number of rows, then print as .csv to specified path. Use
`prefix` to set a custom prefix (default to set “List”).

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
