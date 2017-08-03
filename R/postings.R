
#' Function to get the data from the bank account.
#'
#' @export
billys_postings <- function(...){

  base_url <- httr::parse_url("https://api.billysbilling.com/")

  base_url$path <- "/v2/postings"
  base_url$query <- list(...)

  base_url <- httr::build_url(base_url)

  billy_res <- billys_GET(base_url)
  billy_con <- httr::content(x = billy_res, encoding = "UTF-8")

  billy_con_list <- vector("list", length = billy_con$meta$paging$pageCount)

  billy_con_list[[1]] <- billy_con$postings

  counter <- 1
  while(billy_con$meta$paging$page != billy_con$meta$paging$pageCount){

    counter <- counter + 1

    billy_res <- billys_GET(billy_con$meta$paging$nextUrl)

    billy_con <- httr::content(billy_res, encoding = "UTF-8")

    billy_con_list[[counter]] <- billy_con$postings
  }

  billy_con_list <- purrr::map(billy_con_list, ~purrr::map(.x, is_null_replacement_purrr))
  billy_con_list <- purrr::map(billy_con_list, ~purrr::map(.x, tibble::as_tibble))
  billy_con_list <- purrr::map(billy_con_list, ~dplyr::bind_rows(.x))
  billy_con_list <- dplyr::bind_rows(billy_con_list)

  billy_con_list
}
