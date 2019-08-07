test_tbl <- yelp_search("thai", "Charlottesville")



test_tbl %>% leaflet() %>%
        addTiles() %>%
        addMarkers(lng = test_tbl$lon, lat = test_tbl$lat, popup = test_tbl$name)



empty_table <- yelpr:::create_empty_business_tbl()
dplyr::bind_rows(test_tbl, empty_table)
