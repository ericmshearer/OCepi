# Wrap Long Axis Labels

Break long axis labels at one or more "delimiters".

## Usage

``` r
wrap_labels(x, delim)
```

## Arguments

- x:

  Input list of labels.

- delim:

  Vector of characters or words to break label.

## Value

Wrapped labels.

## Examples

``` r
df <- data.frame(group = c("Native Hawaiian or Other Pacific Islander",
"Black or African American","American Indian or Alaska Native"), score = c(89.5, 84, 73))

ggplot(data = df, aes(x = group, y = score)) +
 geom_col() +
 scale_x_discrete(labels = wrap_labels(delim = "or"))
```
