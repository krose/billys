
library(dplyr)


billys_bank_payments <- function(){

  base_url <- httr::parse_url("https://api.billysbilling.com/")

  base_url$path <- "/v2/bankPayments"

  base_url <- httr::build_url(base_url)

  billy_res <-
    httr::GET(base_url,
              config = httr::add_headers("X-Access-Token" = Sys.getenv("BILLYS_PAT")),
              httr::user_agent("https://github.com/krose/billys"))

  billy_con <- httr::content(x = billy_res, encoding = "UTF-8")

  is_null_replacement <- function(x){
    if(is.null(x)){
      NA
    } else {
      x
    }
  }

  is_null_replacement_purrr <- function(x){

    purrr::map(x, is_null_replacement)
  }


  billy_con <- billy_con[["bankPayments"]]
  billy_con <- purrr::map(billy_con, is_null_replacement_purrr)
  billy_con <- purrr::map(billy_con, tibble::as_tibble)
  billy_con <- dplyr::bind_rows(billy_con)

  billy_con
}
