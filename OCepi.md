OCepi Package
================

- [Common Data Cleaning Functions](#common-data-cleaning-functions)
  - [Add Percent](#add-percent)
  - [Age Groups](#age-groups)
  - [Batch loading VRBIS](#batch-loading-vrbis)
  - [Clean Address](#clean-address)
  - [Closest City Match](#closest-city-match)
  - [Complete Dates](#complete-dates)
  - [Pretty Words](#pretty-words)
  - [Recode Gender](#recode-gender)
  - [Remove Empty Columns](#remove-empty-columns)
  - [Split and Print Dataframe](#split-and-print-dataframe)
  - [Find MMWR Date](#find-mmwr-date)
  - [Find Month Date](#find-month-date)
  - [Find Week Ending Date](#find-week-ending-date)
- [CAIR2 Data Cleaning Functions](#cair2-data-cleaning-functions)
  - [Baby First Name](#baby-first-name)

<img src="www/hex_sticker.png" width="318" />

**Last Updated:** 09/15/2023

This R Markdown document provides an overview of the available data
cleaning functions in the OCepi package. This package is under active
development - any issues/bugs found please contact <eshearer@ochca.com>.

## Common Data Cleaning Functions

<br>

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
- **school:** 0-4, 5-11, 12-17, 18-64, 65+
- **wnv:** 0-17, 18-24, 25-34, 35-44, 45-54, 55-64, 65+

``` r
test_df <- data.frame(Ages = floor(runif(200, min = 0, max = 99)))

test_df$agegrp <- age_groups(test_df$Ages, type = "decade")

table(test_df$agegrp)
## 
##             0-9           10-19           20-29           30-39           40-49 
##              15              23              22              20              21 
##           50-59           60-69           70-79             80+ Missing/Unknown 
##              23              21              14              41               0
```

<br>

### Batch loading VRBIS

Use this function to pull a list of death files into R for analysis.
This function is limited to just loading VRBIS, but if you have multiple
.CSV files using the same structure (i.e. number of columns, same column
names), then you *could* load in non-VRBIS files.

``` r
death_files <- list.files(path = "G:\\Surveillance\\Death Files\\", full.names = TRUE, pattern = "^death")[31:38]

combo_death <- batch_load_vrbis(death_files)
## [1] "G:\\Surveillance\\Death Files\\death2020.csv completed."
## [1] "G:\\Surveillance\\Death Files\\death2020reallocate.csv completed."
## [1] "G:\\Surveillance\\Death Files\\death2021.csv completed."
## [1] "G:\\Surveillance\\Death Files\\death2021reallocate.csv completed."
## [1] "G:\\Surveillance\\Death Files\\death2022.csv completed."
## [1] "G:\\Surveillance\\Death Files\\death2022reallocate.csv completed."
## [1] "G:\\Surveillance\\Death Files\\death2023.csv completed."
## [1] "G:\\Surveillance\\Death Files\\death2023reallocate.csv completed."
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

To run this function, you will need: package stringdist and oc_zips
helper file from `G:\Surveillance\Population`.

``` r
oc_cities <- read.csv("G:\\Surveillance\\Population\\oc_zips.csv", na.strings = "", stringsAsFactors = FALSE) %>%
  select(City) %>%
  unique()

fake_data <- data.frame(City = c("Anahem","El Toro","Los Angeles","Hntington Bch"," Ornge","Capo Beach","FOOTHILL RANCH"))

fake_data %>%
  rowwise() %>%
  mutate(clean_city = closest_city_match(City, oc_cities$City, threshold = 0.15))
## # A tibble: 7 × 2
## # Rowwise: 
##   City             clean_city      
##   <chr>            <chr>           
## 1 "Anahem"         Anaheim         
## 2 "El Toro"        Lake Forest     
## 3 "Los Angeles"    <NA>            
## 4 "Hntington Bch"  Huntington Beach
## 5 " Ornge"         Orange          
## 6 "Capo Beach"     Dana Point      
## 7 "FOOTHILL RANCH" Lake Forest
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
letter abbreviations for gender. Use argument `ordered` to specify
whether you want to return output as factor (default or TRUE) or
character(FALSE).

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

<br>

### Baby First Name

Remove iterations of “baby” from recipient first name.

``` r
baby_name("BABYBOY")
## [1] NA

baby_name("Twin Girl")
## [1] NA
```
