#' @export
print.business_tbl <- function(x, ..., view = interactive()) {
        x %>% leaflet::leaflet() %>%
                leaflet::addTiles() %>%
                leaflet::addMarkers(lng = x$lon, lat = x$lat, popup = x$name) %>%
                print(browse = view, ...)
        business_tbl <- x 
        class(business_tbl) <- class(tibble::tibble())
        print(business_tbl)
        invisible(x)
}