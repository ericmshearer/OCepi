# Desaturate Geom Using Expression

Highlight a bar, point, or line plot based on an expression while
desaturating all other data points.

## Usage

``` r
desaturate_geom(
  expr,
  pal = NULL,
  size = 3.14,
  desaturate = 0.75,
  linewidth = 1.2
)
```

## Arguments

- expr:

  Expression

- pal:

  Color for highlighted data point

- size:

  Point size if using geom_point

- desaturate:

  Level of desaturation for non-highlighted data points, ranges from 0-1
  with 1 equal to highest level of desaturation

- linewidth:

  Linewidth if using geom_line or geom_sf

## Value

Desaturated geon

## Examples

``` r
df <- data.frame(locations = letters[1:5], scores = c(80,84,91,89,80))
ggplot(data = df, aes(x = locations, y = scores)) +
geom_col() +
desaturate_geom(scores==max(scores), pal = "#d55c19", desaturate = 0.7)
```
