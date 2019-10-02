#' Print a table of hours for a business
#'
#' This is a helper function
#'
#' @param tbl the results of yelp_search
#'
#' @return
#' @export
#'
#' @examples
get_hours <- function(tbl, business_name = NULL) {
       
        if (!is.null(business_name)) {
                tbl %>%
                dplyr::filter(name %in% business_name) -> tbl
        }

        tbl %>%
                dplyr::select(name, hours) %>%
                tidyr::unnest()
}

