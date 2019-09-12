#' Connect to Yelp and get a table of businesses
#'
#' This function connects to the Yelp API and gets data for a relevant business based on the business id.  
#' @noRd
yelp_businesses <- function(tbl, client_secret = yelp_key("yelp")) {
        
        # Get client secret
        client_secret <- get_secret(client_secret = client_secret)
        
        # Pull ids out of business_tbl
        ids <- tbl %>% dplyr::pull(id)
        
        hours_vec <- c()

        for (id in ids) {
                
                # Make the connection to Yelp
                yelp_data <- httr::RETRY(
                        verb = "GET",
                        url = paste0("https://api.yelp.com/v3/businesses/", id),
                        httr::add_headers(authorization = paste0("Bearer ", client_secret)))
                
                # If connection fails because of credential issues, show why
                if (yelp_data %>% httr::status_code() >= 400 &
                    yelp_data %>% httr::status_code() < 500) {
                        
                        # Print error code
                        status_code <- yelp_data %>% httr::status_code()
                        stop("Cannot connect to the Yelp API. Status code is ", status_code, ".", call. = FALSE)
                }
                
                # If connection works, get the data  
                if (yelp_data %>% httr::status_code() >= 200 &
                    yelp_data %>% httr::status_code() < 300) {
                        
                        # Retrieve the content 
                        httr_content <- httr::content(yelp_data, as = "text", encoding = "UTF-8")
                        
                        # Convert to JSON and store in hours
                        hours_from_json <- jsonlite::fromJSON(httr_content, flatten = TRUE)$hours 
                        
                        if(is.null(hours_from_json)) {
                                hours <- NA_character_
                        } else { 
                                hours <- hours_from_json %>%
                                        dplyr::as_tibble() %>% dplyr::select(`open`) %>%
                                        .$`open` %>%
                                        .[[1]] %>% 
                                        tidyr::unite(col = "hours", start, end, sep = " - ") %>%
                                        tidyr::complete(day = tidyr::full_seq(day, 1)) %>%
                                        dplyr::select(hours) %>% 
                                        t() %>% 
                                        dplyr::as_tibble() %>% 
                                        unlist() %>% 
                                        unname() %>%
                                        paste(collapse = ";")
                        }
                        
                        # Add to hours vector
                        hours_vec <- c(hours_vec, hours)
                
                }
        }
        suppressWarnings(
                tbl %>%
                        dplyr::mutate(hours = hours_vec) %>%
                        tidyr::separate(
                                col = hours, 
                                into = paste0("hours_", c("sun", "mon", "tue", "wed", "thu", "fri", "sat")), 
                                sep = ";", convert = TRUE)
        )
}