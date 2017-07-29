<!-- README.md is generated from README.Rmd. Please edit that file -->
billys
======

The goal of billys is to make a few convenience functions to help myself. To make it work, save a key from Billys.com to your .Renviron file as BILLY\_PAT.

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r

library(billys)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

class(billys_bank_payments())
#> [1] "tbl_df"     "tbl"        "data.frame"
```
