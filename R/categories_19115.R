#' Get categories of 19115 requests
#'
#' @param token individual API token.
#' @return list of 19115 request categories
#' @examples
#' get_19115_cats()
#' @export
get_19115_cats <- function(token=Sys.getenv("WAWA_API_TOKEN")){
  if(identical(token, "")){
    stop("Please provide valid API token")
  }
  url <- "http://api.um.warszawa.pl/api/action/19115v2_categories"
  req <- httr2::request(url) %>%
    httr2::req_url_query(apikey = token) %>%
    httr2::req_user_agent("apiwawa (https://github.com/krystiankorzec/apiwawa)")
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  resp
}
