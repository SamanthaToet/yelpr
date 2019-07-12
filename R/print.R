#' Print a leaflet map of results 
#' 
#' @param x Yelp business table created from search query
#' @export
print.business_tbl <- function(x, ..., view = interactive()) {
        x %>% leaflet::leaflet() %>%
                leaflet::addTiles() %>%
                leaflet::addMarkers(lng = x$lon, lat = x$lat, popup = x$name) %>%
                print(browse = view, ...)
        print.tibble(x)
        invisible(x)
}

#' Print a table of the business listings
#' 
#' @param x Yelp business search results 
#' @export
print.tibble <- function(x, ..., view = interactive()) {
        class(x) <- class(tibble::tibble())
        business_tbl <- x
        print(business_tbl)
}

