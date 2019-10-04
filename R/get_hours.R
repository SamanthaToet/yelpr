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
       
        if (!is.null(business_name)) {
                tbl %>%
                dplyr::filter(name %in% business_name) -> tbl
        }

        tbl %>%
                dplyr::select(name, hours) %>%
                tidyr::unnest()
}