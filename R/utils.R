day_lookup_tbl <- function(){
        dplyr::tibble(day = 0:6, weekday = 1:7, day_name = c("sun", "mon", "tue", "wed", "thu", "fri", "sat"))
}

empty_day_tbl <- function(){
        day_lookup_tbl() %>%
                dplyr::mutate(start = NA_real_, end = NA_real_, is_overnight = NA) %>%
                dplyr::select(day = day_name, weekday, start, end, is_overnight)
}