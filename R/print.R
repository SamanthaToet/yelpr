#' Print a leaflet map of results 
#' 
#' @param x Yelp business table created from search query.
#' @param ... Optional arguments to print.
#' @param view Interactive
#' @export
print.business_tbl <- function(x, ..., view = interactive()) {
        x %>% leaflet::leaflet() %>%
                leaflet::addTiles() %>%
                leaflet::addMarkers(lng = x$lon, lat = x$lat, popup = x$name) %>%
                print(browse = view, ...)
        print.tibble(x)
        invisible(x)
}


# leaflet::addProviderTiles(
#         provider = "Stamen.Toner",
#         group = "Stamen Toner"
# )

#' Print a table of the business listings
#' 
#' @param x Yelp business search results.
#' @param ... Optional arguments to print.
#' @param view Interactive
#' @export
print.tibble <- function(x, ..., view = interactive()) {
        class(x) <- class(tibble::tibble())
        business_tbl <- x
        print(business_tbl)
}

