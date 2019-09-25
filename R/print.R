#' Print a leaflet map of results 
#' 
#' @param x Yelp business table created from search query.
#' @param ... Optional arguments to print.
#' @param view Interactive
#' @export
print.business_tbl <- function(x, ..., view = interactive()) {
        popup <- paste0("<p style=\"text-align:center;\"><strong>", x$name, "</strong>", "<br>", "Rating: ", x$rating, "<br>", x$address, "</p>")
        #popup <- htmltools::tags$p(x$name) %>% as.character() - try with for loop
        x %>% leaflet::leaflet() %>%
                leaflet::addProviderTiles(
                        provider = "Stamen.TonerLite",
                        group = "Stamen Toner"
                ) %>%
                leaflet::addMarkers(lng = x$lon, lat = x$lat, popup = popup) %>%
                print(browse = view, ...)
        NextMethod()
}