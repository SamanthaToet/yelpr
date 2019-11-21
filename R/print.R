#' Print a Leaflet map of results 
#' 
#' @param x Yelp business table created from search query.
#' @param ... Optional arguments to print.
#' @param view Interactive leaflet map.
#' 
#' @return Returns a table of relevant businesses in the console and prints an interactive Leaflet map in the Viewer tab. Relevant businesses are marked. 
#' 
#' @export
print.business_tbl <- function(x, ..., view = interactive(), show_map = getOption("yelpr.show_map")) {
        popup <- paste0("<p style=\"text-align:center;\"><strong>", x$name, "</strong>", "<br>", "Rating: ", x$rating, "<br>", x$address, "</p>")
        #TODO: popup <- htmltools::tags$p(x$name) %>% as.character() - try with for loop
        
        if (isTRUE(show_map) || is.null(show_map)) {
        x %>% leaflet::leaflet() %>%
                leaflet::addProviderTiles(
                        provider = "Stamen.TonerLite",
                        group = "Stamen Toner"
                ) %>%
                leaflet::addMarkers(lng = x$lon, lat = x$lat, popup = popup) %>%
                print(browse = view, ...)
        NextMethod()
        }
}