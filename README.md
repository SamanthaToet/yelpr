
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/SamanthaToet/yelpr.svg?branch=master)](https://travis-ci.org/SamanthaToet/yelpr)

# yelpr

R client for accessing Yelp’s REST API.

## Installation

You can install the released version of yelpr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("yelpr")
```

## Connecting to Yelp

To interface with the Yelp API, you’ll need to create a Yelp Developer
account. To do this, go to `https://www.yelp.com/developers`, and create
an account through Yelp Fusion. Your app will auto generate a `Client
ID` and `API Key`. Store the `API Key` in your working directory as
`client_secret`.

## Example

``` r
get_yelp_search_data("chicken wings", "Charlottesville, VA")
```
