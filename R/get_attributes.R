#' Print a table of up to three reviews for each business.
#' 
#' This is a helper function to be used with `yelp_search` to parse the reviews for a specific business or list of businesses. The Yelp API currently only returns up to three truncated reviews for each business. 
#'
#' @param tbl The results of `yelp_search` stored as a dataframe.
#' @param business_name Optional string. The name of a specific business to get reviews for. Defaults to `NULL`.
#'
#' @return A dataframe with up to 3 truncated reviews for each business.
#' 
#' @examples 
#' get_reviews(tbl)
#' get_reviews(tbl, "Wegmans")
#' 
#' @export
get_reviews <- function(tbl, business_name = NULL) {
        
        if (!("reviews" %in% names(tbl))) {
                stop("Reviews not found. Make sure to set `reviews = TRUE` in `yelp_search`.", call. = FALSE)
        }
        
        get_column(tbl = tbl, column_name = reviews, business_name = business_name)
}


#' Print a table of operating hours for a business.
#'
#' This is a helper function to be used with `yelp_search` to parse the hours for a specific business or list of businesses. 
#'
#' @param tbl The results of `yelp_search` stored as a dataframe. 
#' @param business_name Optional string. The name of a specific business to get operating hours for. Defaults to `NULL`.  
#'
#' @return A dataframe of hours of operation. 
#' 
#' @examples
#' get_hours(tbl) 
#' get_hours(tbl, "Wegmans")
#' 
#' @export
get_hours <- function(tbl, business_name = NULL) {
        
        get_column(tbl = tbl, column_name = hours, business_name = business_name)
}

#' Get a list column to parse.
#' 
#' This is an internal function for parsing out list columns such as reviews and hours. 
#' 
#' @noRd
get_column <- function(tbl, column_name, business_name = NULL) {
        if (!is.null(business_name)) {
                tbl %>%
                        dplyr::filter(name %in% business_name) -> tbl
        }
        
        tbl %>%
                dplyr::select(name, {{ column_name }}) %>%
                tidyr::unnest(cols = {{ column_name }})
}       