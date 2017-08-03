
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

billys_GET <- function(url){

  billy_res <-
    httr::GET(url,
              config = httr::add_headers("X-Access-Token" = Sys.getenv("BILLYS_PAT")),
              httr::user_agent("https://github.com/krose/billys"))

  billy_res
}
