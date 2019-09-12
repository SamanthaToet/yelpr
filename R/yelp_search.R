#' Search yelp business data
#'
#' With this function you can search all businesses in the Yelp directory based
#' on geographic location.
#'
#' The output is a large table containing relevant businesses and a Leaflet map 
#' pinpointing their location. 
#'
#' @param term Search term as a string, for example `"coffee"` or
#'   `"restaurants"`. The term may also be business names, such as
#'   `"Starbucks"`.
#' @param location Search location as a string. City with two letter state
#'   abbreviation. EX. `"Charlottesville, VA"`. Required if either latitude or
#'   longitude is not provided.
#' @param latitude,longitude The geographic latitude and longitude measurements as a decimal. EX. `38.1`.
#'   Required if `location` is not provided. If provided `location`, will be ignored. 
#' @param radius Optional integer. A suggested search radius in meters. The max
#'   value is 40,000 meters (about 25 miles).
#' @param categories Optional string. Categories to filter the search results
#'   with, such as `"automotive"` or `"retail"`.
#'   \href{https://www.yelp.com/developers/documentation/v3/all_category_list}{See
#'   list of supported categories}.
#' @param locale Optional string. Specify the language and country codes.
#'   Defaults to `en_US`.
#'   \href{https://www.yelp.com/developers/documentation/v3/all_category_list}{See
#'   list of supported locales}.
#' @param limit Optional integer. Number of business results to return. Defaults
#'   to `20` and maximum is `50`.
#' @param price Optional string. Price categories to filter the search results
#'   with, ranging from `"$"` to `"$$$$"`
#' @param attributes Optional string. Additional filters to the search results
#'   such as `"wheelchair_accessible"`, or `"reservations"`.
#' @param client_secret Required. Your personal Yelp API key stored in your
#'   keychain and retrieved by `get_key(service = "yelp")`.
#' 
#' @export
yelp_search <- function(term = NULL,
                        location = NULL,
                        latitude = NULL,
                        longitude = NULL,
                        radius = NULL,
                        categories = NULL,
                        locale = NULL,
                        limit = 50,
                        price = NULL,
                        attributes = NULL,
                        client_secret = yelp_key("yelp")) {
        
        # Get client secret
        client_secret <- get_secret(client_secret = client_secret)
        
        
        # Check that either location or lat/lon is provided
        if (is.null(location) & (is.null(latitude) & is.null(longitude))) {
                stop("Either the `location`  or `latitude` and `longitude` ",
                     "is required.", call. = FALSE)
        }
        
        # If radius is provided make sure it is under 40000 and rounded up to nearest whole number 
        if (!is.null(radius)) {
                if (!is.numeric(radius)) {
                        stop("Radius must be a numeric value.", call. = FALSE)  
                }
                if (radius > 40000) {
                        radius <- 40000
                        warning("The provided radius was greater than 40000 ",
                                "so it was coerced to the maximum possible value of 40000.", call. = FALSE)
                }
                radius %>% ceiling %>% as.integer() -> radius
        }
        
        
        # Make the connection to Yelp
        yelp_data <- 
                httr::RETRY(
                        verb = "GET",
                        url = "https://api.yelp.com/v3/businesses/search",
                        query = list(
                                term = term,
                                location = location,
                                latitude = latitude,
                                longitude = longitude,
                                radius = radius,
                                categories = categories,
                                locale = locale,
                                limit = limit,
                                price = price,
                                attributes = attributes),
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
                
                # Convert from JSON and store in busines_tbl
                business_tbl <- 
                        jsonlite::fromJSON(httr_content, flatten = TRUE)$businesses %>% 
                        dplyr::as_tibble() %>%
                        dplyr::select(
                                id,
                                name,
                                city = location.city,
                                state = location.state,
                                address = location.address1, 
                                rating,
                                price, 
                                lat = coordinates.latitude, 
                                lon = coordinates.longitude,
                                
                        )
                
        } else {
                
                # Create empty business table
                business_tbl <- create_empty_business_tbl()
        }
        
        # Sort in descenting order
        # TODO: Augment table with extra API calls 
        business_tbl <- business_tbl %>% 
                dplyr::arrange(dplyr::desc(rating)) %>%
                yelp_businesses() %>%
                dplyr::select(-id)
        
        # Change the class of business_tbl to "business_tbl"
        class(business_tbl) <- c("business_tbl", class(business_tbl))
        business_tbl
}




#' Assign "yelp_key" class to your Yelp API key
#' 
#' This is an internal function for assigning the custom class "yelp_key" to the key value.
#' 
#' @param key yelp key
#' @export
yelp_key <- function(key) {
        class(key) <- "yelp_key"
        key
}


#' Create empty Yelp business table
#'
#' This is an internal function for creating an empty Yelp business table. The function `import_yelp_business_records` populates the table with relevant business data. 
#'
#' @noRd
create_empty_business_tbl <- function() {
        
        # Build an empty data frame and assign names and classes to columns 
        dplyr::tibble(
                name = character(), city = character(), state = character(), address = character(),
                rating = numeric(), price = character(), lat = numeric(), lon = numeric())
}
