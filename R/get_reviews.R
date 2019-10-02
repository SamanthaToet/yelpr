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
        
        if (!is.null(business_name)) {
                tbl %>%
                        dplyr::filter(name %in% business_name) -> tbl
        }
        
        tbl %>%
                dplyr::select(name, reviews) %>%
                tidyr::unnest()
}