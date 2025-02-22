
<!-- README.md is generated from README.Rmd. Please edit that file -->

# actcrime

<!-- badges: start -->
<!-- badges: end -->

The goal of `actcrime` is to provide an R interface to access ACT crime
data.

## Installation

You can install the development version of actcrime from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("TengMCing/actcrime")
```

## Example

``` r
library(actcrime)
# Load the package
```

The package includes a built-in dataset, `act_crime_stat_2024_09_30`,
which contains cleaned and structured ACT crime statistics sourced from
[dataACT](https://www.data.act.gov.au/Justice-Safety-and-Emergency/ACT-Crime-Statistics/2egm-dieb/about_data)
as of **February 22, 2025**.

``` r
act_crime_stat_2024_09_30 |> tibble::as_tibble()
#> # A tibble: 101,308 × 8
#>    district  suburb crime_code crime_type        year  quarter month_range count
#>    <chr>     <chr>  <chr>      <chr>             <chr> <chr>   <chr>       <dbl>
#>  1 Belconnen ARANDA 1          Homicide          2014  Q1      Jan-Mar         0
#>  2 Belconnen ARANDA 2a         Assault - FV      2014  Q1      Jan-Mar         0
#>  3 Belconnen ARANDA 2b         Assault - Non-FV  2014  Q1      Jan-Mar         0
#>  4 Belconnen ARANDA 3          Sexual Assault    2014  Q1      Jan-Mar         0
#>  5 Belconnen ARANDA 4          Other offences a… 2014  Q1      Jan-Mar         0
#>  6 Belconnen ARANDA 5a         Robbery - armed   2014  Q1      Jan-Mar         0
#>  7 Belconnen ARANDA 5b         Robbery - other   2014  Q1      Jan-Mar         0
#>  8 Belconnen ARANDA 6a         Burglary dwellin… 2014  Q1      Jan-Mar         1
#>  9 Belconnen ARANDA 6b         Burglary shops    2014  Q1      Jan-Mar         0
#> 10 Belconnen ARANDA 6c         Burglary other    2014  Q1      Jan-Mar         0
#> # ℹ 101,298 more rows
```

Additionally, the package provides the function `get_act_crime_stat()`,
which allows users to download the latest available crime statistics.

``` r
get_act_crime_stat()
#> # A tibble: 101,308 × 8
#>    district  suburb crime_code crime_type        year  quarter month_range count
#>    <chr>     <chr>  <chr>      <chr>             <chr> <chr>   <chr>       <dbl>
#>  1 Belconnen ARANDA 1          Homicide          2014  Q1      Jan-Mar         0
#>  2 Belconnen ARANDA 2a         Assault - FV      2014  Q1      Jan-Mar         0
#>  3 Belconnen ARANDA 2b         Assault - Non-FV  2014  Q1      Jan-Mar         0
#>  4 Belconnen ARANDA 3          Sexual Assault    2014  Q1      Jan-Mar         0
#>  5 Belconnen ARANDA 4          Other offences a… 2014  Q1      Jan-Mar         0
#>  6 Belconnen ARANDA 5a         Robbery - armed   2014  Q1      Jan-Mar         0
#>  7 Belconnen ARANDA 5b         Robbery - other   2014  Q1      Jan-Mar         0
#>  8 Belconnen ARANDA 6a         Burglary dwellin… 2014  Q1      Jan-Mar         1
#>  9 Belconnen ARANDA 6b         Burglary shops    2014  Q1      Jan-Mar         0
#> 10 Belconnen ARANDA 6c         Burglary other    2014  Q1      Jan-Mar         0
#> # ℹ 101,298 more rows
```
