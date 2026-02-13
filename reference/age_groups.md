# Create age groups.

Add age groups column using common age grouping presets. R Markdown
documentation has list of presets.

## Usage

``` r
age_groups(age_var, type = "decade")
```

## Arguments

- age_var:

  Age variable in numeric format.

- type:

  Specify which preset to use.

## Value

Age groups as factor.

## Examples

``` r
df <- data.frame(Age = sample(0:99, 100))
df$agegrps <- age_groups(df$Age, type = "covid")
head(df)
#>   Age agegrps
#> 1  46   45-54
#> 2  30   25-34
#> 3  67   65-74
#> 4  72   65-74
#> 5  68   65-74
#> 6   4    0-17
```
