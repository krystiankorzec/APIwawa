library(httr2)
library(magrittr)
token <- "ecf88b99-03d7-4c00-8477-f5d8932ed21e"
# GET
req <- request("http://api.um.warszawa.pl/api/action/19115v2_categories") %>%
  req_url_query(apikey = token) %>%
  req_user_agent("apiwawa (https://github.com/krystiankorzec/apiwawa)")

resp <- req %>% req_perform()
resp %>% resp_body_json() %>% str()
# POST
filter_array <- list(filters = list(list(field = "CREATE_DATE",
                              operator = "GEQ",
                              value = list("2022-04-01T10:15:04Z")),
                         list(field = "CREATE_DATE",
                              operator = "LEQ",
                              value = list("2022-04-01T11:15:04Z"))),
          operators = list("AND"),
          sorters = list(list(field = "CREATE_DATE",
                              sorterType = "ASC")),
          paginator = list(resultLimit = 5L,
                           resultOffset = 0L))
req <- request("https://api.um.warszawa.pl/api/action/19115v2_incidents/") %>%
  req_url_query(apikey = token) %>%
  req_user_agent("apiwawa (https://github.com/krystiankorzec/apiwawa)")

resp <- req %>%
  req_body_json(data = filter_array) %>%
  req_perform()

resp %>% resp_body_json() %>% str()

library(magrittr)
img <- magick::image_read("wawa.svg")
res <- img %>% magick::image_resize("1080 x 400")
hexSticker::sticker(res, package="apiwawa", p_size=7,
                   p_y = 1.5,p_color = "#062047",
                   s_x=1, s_y=0.8, s_width=1,
                   s_height = 12,h_fill="#FFFFFF",h_color = "#062047",
                   filename="apiwawa.png")


