# Highlight Geom Using Expression

Highlight a bar, point, or line plot based on an expression.

## Usage

``` r
highlight_geom(expr, pal = NULL, size = 3.14, linewidth = 1.2)
```

## Arguments

- expr:

  Expression

- pal:

  color for highlighted geom

- size:

  Point size if using geom_point

- linewidth:

  Linewidth if using geom_line or geom_sf

## Value

ggplot2 with highlighted layer

## Examples

``` r
df <- data.frame(locations = letters[1:5], scores = c(80,84,91,89,80))
ggplot(data = df, aes(x = locations, y = scores)) +
geom_col() +
highlight_geom(scores==max(scores), pal = "#9E0059")
```
