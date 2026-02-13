# Lollipop Plot

Point plot with stem. Custom aesthetics via: linetype (stem), linewidth
(stem), color (point), size (point).

## Usage

``` r
geom_lollipop(
  data = NULL,
  mapping = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  position = "identity",
  line.colour = NULL,
  na.rm = FALSE,
  ...
)

GeomLollipop
```

## Format

An object of class `GeomLollipop` (inherits from `Geom`, `ggproto`,
`gg`) of length 7.

## Arguments

- data:

  Dataframe

- mapping:

  x and y mapping.

- show.legend:

  Boolean.

- inherit.aes:

  If TRUE combine with default mapping at the top level of the plot.

- position:

  Default set to "identity".

- line.colour:

  Hex code to override line color

- na.rm:

  Boolean to remove NA values.

- ...:

  The other arguments!

## Value

Lollipop plot.

## Examples

``` r
df <- data.frame(locations = letters[1:5], scores = c(90,82,87,91,74))

ggplot(data = df, aes(x = locations, y = scores, yend = 0)) +
 geom_lollipop(size = 10, linewidth = 2, linetype = "dashed", color = "red")
```
