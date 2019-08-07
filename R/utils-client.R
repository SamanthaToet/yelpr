get_secret <- function(client_secret) {
        
        # Confirm client secret has class "yelp_key"
        if (!inherits(client_secret, "yelp_key")) {
                stop("Yelp key is invalid")
        }
        
        # Confirm they have keyring
        if (!requireNamespace("keyring", quietly = TRUE)) {
                stop("The `keyring` package is required for using the ",
                     "`yelp_key` function",
                     call. = FALSE)
        }
        
        # Confirm they have keyring support
        if (!keyring::has_keyring_support()) {
                stop("To store Yelp key via *keyring*, the system needs to have",
                     "*keyring* support", call. = FALSE)
        }
        
        # Confirm client secret is stored
        if (!("yelp" %in% keyring::key_list()$service)) {
                stop("There is no Yelp API key stored or it cannot be accessed.", call. = FALSE)
        }
        
        # If client_secret pasted in as character, use that 
        keyring::key_get(service = client_secret %>% as.character())
        
}