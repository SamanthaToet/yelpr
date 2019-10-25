#' Scrape Reviews
#'
#' @param pagination 
#'
#' @return
#' @noRd
scrape_reviews <- function(pagination) {
        #pagination <- c(0)
        yelp_html <- xml2::read_html(paste0("https://www.yelp.com/biz/crobys-urban-viddles-charlottesville")) 
        yelp_html %>%
        rvest::html_nodes(css = "#wrap > div.main-content-wrap.main-content-wrap--full > div > div.lemon--div__373c0__1mboc.spinner-container__373c0__N6Hff.border-color--default__373c0__2oFDT > div.lemon--div__373c0__1mboc.u-space-t3.u-space-b6.border-color--default__373c0__2oFDT > div > div > div.lemon--div__373c0__1mboc.stickySidebar--heightContext__373c0__133M8.tableLayoutFixed__373c0__12cEm.arrange__373c0__UHqhV.u-space-b6.u-padding-b4.border--bottom__373c0__uPbXS.border-color--default__373c0__2oFDT > div.lemon--div__373c0__1mboc.arrange-unit__373c0__1piwO.arrange-unit-grid-column--8__373c0__2yTAx.u-padding-r6.border-color--default__373c0__2oFDT > section:nth-child(9) > div > section.lemon--section__373c0__fNwDM.u-space-t4.u-padding-t4.border--top__373c0__19Owr.border-color--default__373c0__2oFDT > div.lemon--div__373c0__1mboc.spinner-container__373c0__N6Hff.border-color--default__373c0__2oFDT > div > ul > li:nth-child(1) > div > div.lemon--div__373c0__1mboc.arrange-unit__373c0__1piwO.arrange-unit-fill__373c0__17z0h.border-color--default__373c0__2oFDT > div:nth-child(3) > p > span") %>%
                rvest::html_text()
} 

