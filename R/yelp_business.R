#' Connect to Yelp and get a table of businesses
#'
#' This function connects to the Yelp API and gets data for a relevant business based on the business id.  
#'
#' The output is
#' 
#' @param id The business id provided by Yelp
#'
#' @param client_secret Your Yelp API client secret
#'
#' @export
yelp_businesses <- function(ids, client_secret = yelp_key("yelp")) {
        
        # Get client secret
        client_secret <- get_secret(client_secret = client_secret)
        
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
                httr_content <- httr::content(yelp_data, as = "text")
                
                # Convert to JSON and store in tbl
                tbl <- jsonlite::fromJSON(httr_content, flatten = TRUE)$hours %>% 
                        dplyr::as_tibble()
                browser()
                
        # } else {
        #         
        #         business_tbl <- create_empty_business_tbl()
        # }
        }
        }
        # Print the table
        tbl
}

