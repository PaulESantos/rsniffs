#' @title Retrieve Registry of Commercial Establishments and Deposits of Forest and Wildlife Products
#'
#' @description
#' Downloads and processes the official dataset titled
#' **"Listado de Depósitos y Establecimientos Comerciales de Productos Forestales y de Fauna Silvestre"**,
#' published by SERFOR (Servicio Nacional Forestal y de Fauna Silvestre) through the
#' National Forest and Wildlife Information System (SNIFFS).
#'
#' This dataset includes companies authorized to handle, store, and commercialize
#' forest and wildlife products in Peru.
#'
#' @return A **tibble** with cleaned and standardized columns, including information on
#' establishment name, region, authorization details, and more.
#'
#' @note
#' Requires an active internet connection. The source spreadsheet must remain public to allow download.
#'
#' @source
#' SERFOR (Servicio Nacional Forestal y de Fauna Silvestre)
#' Dataset: "Listado de Depósitos y Establecimientos Comerciales"
#' System: SNIFFS - Sistema Nacional de Información Forestal y de Fauna Silvestre
#'
#' @author
#' Paul Efren Santos Andrade
#'
#' @examples
#' \dontrun{
#' # Retrieve the registry
#' registry <- pic_depositos_establecimientos()
#'
#' # View the first rows
#' head(registry)
#'
#' # Get a list of unique departments
#' unique(registry$nomdep)
#' }
#'
#' @export
pic_depositos_establecimientos <- function() {
  # Parameters
  skip_rows <- 2
  gdrive_url <- "https://docs.google.com/spreadsheets/d/17cvKzpldeMrDBWbCUi3p73M8eypn36TS/edit?gid=1368577966#gid=1368577966"

  # Extract file ID from URL
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)

  # Construct direct download URL (valid only for files exported to Excel format)
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Create temp file to store downloaded Excel
  temp_file <- tempfile(fileext = ".xlsx")

  # Download with error handling
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    stop("Error downloading the file: ", e$message)
  })

  # Check for successful download
  if (httr::status_code(response) != 200) {
    stop("Download failed. Status code: ", httr::status_code(response))
  }

  # Read and clean the Excel data
  data_clean <- suppressMessages(
    readxl::read_excel(temp_file, skip = skip_rows) |>
      janitor::clean_names() |>
      janitor::remove_empty("cols")
  )

  return(data_clean)
}

pic_depositos_establecimientos()
