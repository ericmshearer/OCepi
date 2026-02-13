# ELR Terms

A vector of SNOMED codes and keywords to be used with ELR recoding.

## Usage

``` r
pos(collapse = FALSE, add_in = NULL)

neg(collapse = FALSE, add_in = NULL)
```

## Arguments

- collapse:

  Boolean to collapse string separated by "\|".

- add_in:

  Vector of additional lab results.

## Value

Vector of characters.

## Examples

``` r
pos(collapse = TRUE)
#> [1] "POSITIVE|REACTIVE|DETECTED|10828004|260373001|840533007|PCRP11|PDETD|COVPRE|11214006|Positive for IgG|POS|DECTECTED|REA|PPOSI|REAC"
pos()
#>  [1] "POSITIVE"         "REACTIVE"         "DETECTED"         "10828004"        
#>  [5] "260373001"        "840533007"        "PCRP11"           "PDETD"           
#>  [9] "COVPRE"           "11214006"         "Positive for IgG" "POS"             
#> [13] "DECTECTED"        "REA"              "PPOSI"            "REAC"            
neg(collapse = TRUE)
#> [1] "NEGATIVE|NON REACTIVE|NON-REACTIVE|NOT REACTIVE|NOT DETECTED|NEG|NDET|NOT DETECT|260385009|26041500|NOTDETECTED|131194007|895231008|NONE DETECTED|NO DETECTED|NOT DETECTABLE|NOT DETECTE|NOT DETECTIVE|NOTDETECT|NOTDETECTED|NR|NONREACTIVE|NOTREACTIVE"
neg()
#>  [1] "NEGATIVE"       "NON REACTIVE"   "NON-REACTIVE"   "NOT REACTIVE"  
#>  [5] "NOT DETECTED"   "NEG"            "NDET"           "NOT DETECT"    
#>  [9] "260385009"      "26041500"       "NOTDETECTED"    "131194007"     
#> [13] "895231008"      "NONE DETECTED"  "NO DETECTED"    "NOT DETECTABLE"
#> [17] "NOT DETECTE"    "NOT DETECTIVE"  "NOTDETECT"      "NOTDETECTED"   
#> [21] "NR"             "NONREACTIVE"    "NOTREACTIVE"   
```
