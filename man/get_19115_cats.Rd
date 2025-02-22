% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/categories_19115.R
\name{get_19115_cats}
\alias{get_19115_cats}
\title{Get categories of 19115 requests}
\usage{
get_19115_cats(token = Sys.getenv("WAWA_API_TOKEN"))
}
\arguments{
\item{token}{individual API token.}
}
\value{
tibble of 19115 request categories
}
\description{
Get categories of 19115 requests
}
\examples{
get_19115_cats()
}
