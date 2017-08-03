
#' Function to get the data from the bank account.
#'
#' @export
billys_bank_lines <- function(...){

  base_url <- httr::parse_url("https://api.billysbilling.com/")

  base_url$path <- "/v2/bankLines"
  base_url$query <- list(...)

  base_url <- httr::build_url(base_url)

  billy_res <-billys_GET(base_url)

  billy_con <- httr::content(x = billy_res, encoding = "UTF-8")

  billy_con <- billy_con[["bankLines"]]
  billy_con <- purrr::map(billy_con, is_null_replacement_purrr)
  billy_con <- purrr::map(billy_con, tibble::as_tibble)
  billy_con <- dplyr::bind_rows(billy_con)

  billy_con
}
