#' Connect to Yelp and get data 
#'
#' With this function you can connect to Yelp using your API client secret or keyring. 
#'
#' The output is a large table containing relevant businesses.
#' 
#' @param id The business id provided by Yelp
#'
#' @param client_secret Your Yelp API client secret
#'
#' @export
yelp_business <- function(id, client_secret = yelp_key("yelp")) {
        
        # Get client secret
        client_secret <- get_secret(client_secret = client_secret)
        
        httr::RETRY(
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
                
                httr_content <- httr::content(yelp_data, as = "text")
                
                tbl <- 
                        jsonlite::fromJSON(httr_content, flatten = TRUE)$businesses %>% 
                        dplyr::as_tibble()
                
        # } else {
        #         
        #         business_tbl <- create_empty_business_tbl()
        # }
        }
        tbl
}
