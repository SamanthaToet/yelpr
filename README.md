
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/SamanthaToet/yelpr.svg?branch=master)](https://travis-ci.org/SamanthaToet/yelpr)

# yelpr

R client for accessing the [Yelp Fusion
API](https://www.yelp.com/developers/documentation/v3).

## Installation

You can install the released version of yelpr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("yelpr")
```

## Connecting to Yelp

To interface with the Yelp API, you’ll need to register a [Yelp
Developer account](https://www.yelp.com/developers) and then [create an
app](https://www.yelp.com/developers/v3/manage_app). Your app will auto
generate a `Client ID` and `API Key`. Store the `API Key` in your
working directory as `client_secret`.

``` r
client_secret <- "API Key"
```

## Example

``` r
get_yelp_search_data("chicken wings", "Charlottesville, VA")
```
