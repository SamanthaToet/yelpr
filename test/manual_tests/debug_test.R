
term <- "chicken wings"
location <- "Charlottesville, VA"

req <- httr::RETRY(
        verb = "GET",
        url = "https://api.yelp.com/v3/businesses/search",
        query = list(
                term = term,
                location = location),
        httr::add_headers(authorization = paste0("Bearer ", client_secret)))

business_list <- httr::content(
        x = req,
        encoding = "UTF-8")$businesses

yelpr:::import_yelp_business_records(business_list)

chx <- yelp_search("chicken wings", "Charlottesville, VA", client_secret = client_secret)


