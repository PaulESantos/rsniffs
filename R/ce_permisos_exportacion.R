#' Get Export Permit Records for Forest and Wildlife Products
#'
#' @description
#' Downloads and processes the official dataset on export permits for forest and wildlife products,
#' as published by SERFOR (National Forest and Wildlife Service of Peru). The data is part of
#' the "Foreign Trade" section of the statistical module of the National Forest and Wildlife Information System (SNIFFS).
#'
#' @details
#' The function accesses a public Google Sheet maintained by SERFOR, parses it into a tidy format, and returns a clean data frame.
#' This dataset includes information on issued permits, export destinations, product types, and issuing entities.
#'
#' @return A tibble containing the structured data on export permits.
#'
#' @note Requires an active internet connection. The source file is regularly updated by SERFOR.
#'
#' @source
#' SERFOR (National Forest and Wildlife Service). Public data available via Google Drive.
#' System: SNIFFS (National Forest and Wildlife Information System)
#'
#' @author
#' Paul Efren Santos Andrade
#'
#' @export
ce_permisos_exportacion <- function() {
  # Google Drive public link to the data source
  gdrive_url <- "https://docs.google.com/spreadsheets/d/1-h3KkHSU00P91j16nQlgRUYrDV1e4rsQ/edit?gid=1433005855#gid=1433005855"

  # Extract file ID from the Google Drive URL
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)

  # Construct direct download URL
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Create a temporary file to save the downloaded Excel file
  temp_file <- tempfile(fileext = ".xlsx")

  # Attempt to download the file
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    stop("Error downloading the file: ", e$message)
  })

  # Check if the download was successful (HTTP status 200)
  if (httr::status_code(response) != 200) {
    stop("Download failed. HTTP status code: ", httr::status_code(response))
  }

  # Read and clean the Excel data
  data_raw <- suppressMessages(
    suppressWarnings(
      readxl::read_excel(temp_file) |>
        janitor::clean_names() |>
        janitor::remove_empty("cols")
    )
  )

  return(data_raw)
}
