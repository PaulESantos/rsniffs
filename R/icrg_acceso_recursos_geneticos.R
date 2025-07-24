#' Get Registry of Access Contracts to Genetic Resources
#'
#' @description
#' This function accesses the registry of contracts for access to genetic resources of wild flora and fauna species,
#' under the item "Scientific Research and Genetic Resources" from the statistical component of the
#' National Forest and Wildlife Information System (SNIFFS).
#'
#' It downloads and processes official data from SERFOR (National Forest and Wildlife Service)
#' available through Google Drive.
#'
#' @return A tibble (data frame) containing the registry data.
#'
#' @author
#' Paul Efren Santos Andrade
#'
#' @source
#' SERFOR - National Forest and Wildlife Service. Data accessed via Google Drive.
#' Component: SNIFFS - National Forest and Wildlife Information System.
#'
#' @note
#' Requires an active internet connection. Data may be updated periodically by SERFOR.
#'
#' @examples
#' \dontrun{
#' data <- icrg_acceso_recursos_geneticos()
#' head(data)
#' View(data)
#' }
#'
#' @export
icrg_acceso_recursos_geneticos <- function() {
  # Define the public Google Drive URL of the spreadsheet
  gdrive_url <- "https://docs.google.com/spreadsheets/d/1zDiqV9l7rXM_7mcM588tuWZhsCj03YuO/edit?gid=80336252#gid=80336252"

  # Extract the file ID from the Google Drive URL
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)

  # Build the download URL (may only work for files explicitly published as downloadable Excel)
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Create a temporary file to store the Excel
  temp_file <- tempfile(fileext = ".xlsx")

  # Attempt to download the file with error handling
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    stop("Error downloading the file: ", e$message)
  })

  # Check if the download was successful
  if (httr::status_code(response) != 200) {
    stop("Download failed. HTTP status code: ", httr::status_code(response))
  }

  # Read and clean the Excel data
  data_raw <- suppressMessages(
    suppressWarnings(
      readxl::read_excel(temp_file, skip = 4) |>
        janitor::clean_names() |>
        janitor::remove_empty("cols")
    )
  )

  return(data_raw)
}
