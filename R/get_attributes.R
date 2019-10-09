#' Print a table of three reviews for each business
#'
#' @param tbl 
#' @param business_name 
#'
#' @return
#' @export
#'
#' @examples
get_reviews <- function(tbl, business_name = NULL) {
        
        if (!("reviews" %in% names(tbl))) {
                stop("Reviews not found. Make sure to set `reviews = TRUE` in `yelp_search`.", call. = FALSE)
        }
        
        get_column(tbl = tbl, column_name = reviews, business_name = business_name)
}



#' Print a table of hours for a business
#'
#' This is a helper function to be used with `yelp_search` to parse the hours for a specific business or list of businesses. 
#'
#' @param tbl The results of `yelp_search` stored as a dataframe. 
#' @param business_name Optional string. The name of a specific business to get hours for. Defaults to `NULL`.  
#'
#' @return A dataframe of hours of operation. 
#' 
#' @export
#'
#' @examples 
#' get_hours(tbl)
#' get_hours(tbl, "Wegmans")
get_hours <- function(tbl, business_name = NULL) {
        
        get_column(tbl = tbl, column_name = hours, business_name = business_name)
}


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