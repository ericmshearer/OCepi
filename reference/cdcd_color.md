# Use Team Colors in Plots

Function to call commonly used colors for data visualizations.

## Usage

``` r
cdcd_color(...)
```

## Arguments

- ...:

  Vector of color names. Run cdcd_color() to view all options.

## Value

Hex codes.

## Examples

``` r
cdcd_color()
#>        green    turquoise   light blue  london pink       orange  title color 
#>    "#5ea15d"    "#63c5b5"    "#6da7de"    "#9e0059"    "#F28C28"    "#231f20" 
#>   axis color   grid color grid color 2         plum      mustard      dodgers 
#>    "#353d42"    "#E8EDEE"     "gray65"    "#b366a4"    "#da9400"    "#005A9C" 
cdcd_color("green")
#> [1] "#5ea15d"
```
