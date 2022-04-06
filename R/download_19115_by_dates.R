################################################################################
download_19115_req_map_fun <- function(datetime, token){
  Sys.sleep(1)
  print(datetime)
  datetime_start <- datetime
  datetime_end <- paste0(substr(datetime, 1, 17), "59Z")
  filter_array <- list(filters = list(list(field = "CREATE_DATE",
                                           operator = "GEQ",
                                           value = list(datetime_start)),
                                      list(field = "CREATE_DATE",
                                           operator = "LEQ",
                                           value = list(datetime_end))),
                       operators = list("AND"),
                       sorters = list(list(field = "CREATE_DATE",
                                           sorterType = "ASC")),
                       paginator = list(resultLimit = 100L,
                                        resultOffset = 0L))

  req <- httr2::request("https://api.um.warszawa.pl/api/action/19115v2_incidents/") %>%
    httr2::req_url_query(apikey = token) %>%
    httr2::req_user_agent("apiwawa (https://github.com/krystiankorzec/apiwawa)") %>%
    httr2::req_body_json(data = filter_array)
  resp <- httr2::req_perform(req)
  if (httr2::resp_status(resp) == 200){
    resp <- resp %>%
      httr2::resp_body_string() %>%
      jsonlite::fromJSON() %>%
      .$result %>% .$result %>% .$result %>%
      tibble::tibble()
  }
  resp
}

download_19115_by_dates <- function(start_date, end_date,
                                    token = Sys.getenv("WAWA_API_TOKEN")){
  start_date <- start_date %>% paste("00:00")
  end_date <- end_date %>% paste("23:59")
  datetimes <- seq(from=as.POSIXct(start_date),to=as.POSIXct(end_date),by="min") %>%
    stringr::str_trim() %>% stringr::str_replace(" ", "T") %>% paste0(.,"Z")
  datetimes
  res <- purrr::map_dfr(datetimes, ~download_19115_req_map_fun(datetime = ., token=token))
  res
}
