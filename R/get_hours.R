#' Print a table of hours for a business
#'
#' @param tbl 
#' @param client_secret 
#'
#' @return
#' @export
#'
#' @examples
get_hours <- function(tbl, client_secret = yelp_key("yelp")) {
        
        # Get client secret
        client_secret <- get_secret(client_secret = client_secret)
        
        # Get business table
        yelp_businesses()
        
        # Get the business name and id from that df
        
        # Use the id to print the hours 
}
