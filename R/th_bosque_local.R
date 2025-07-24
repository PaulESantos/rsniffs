#' @title Retrieve Local Forest (Bosque Local) Data from SNIFFS - SERFOR
#'
#' @description
#' Downloads and processes the most recent dataset of Local Forests (Bosques Locales)
#' from the statistical component of the Sistema Nacional de Información Forestal y de Fauna Silvestre (SNIFFS),
#' administered by SERFOR (Servicio Nacional Forestal y de Fauna Silvestre) in Peru.
#'
#' A Local Forest (Bosque Local) constitutes a Forest Management Unit, established through
#' Executive Resolution of SERFOR, intended to enable legal and orderly access for local
#' populations to sustainable utilization for commercial purposes. According to the site
#' category, it can be designated for timber harvesting, non-timber forest products,
#' wildlife, or silvopastoral systems.
#'
#' The function accesses a resource publicly shared by SNIFFS via Google Sheets.
#'
#' @return A **tibble** containing the cleaned Local Forest data.
#'
#' @details
#' The dataset is sourced from a Google Sheets document.
#'
#' @author
#' Paul Efren Santos Andrade
#'
#' @examples
#' \dontrun{
#' # Retrieve the forest concessions dataset:
#' concessions_df <- th_concesiones()
#'
#' # Preview the first few rows
#' head(concessions_df)
#'
#' # Summary statistics
#' summary(concessions_df)
#'
#' # View data
#' View(concessions_df)
#' }
#' @export
th_bosque_local <- function() {
  # Internal function parameters
  # Number of rows to skip when reading the file (set to 0 for new data source)
  skip_rows <- 0

  # Google Sheets URL containing the Local Forest data
  gsheets_url <- "https://docs.google.com/spreadsheets/d/12z78gaCM_aI3ZXfcvUHt_mjHGPS2oPJI/edit?gid=1194117140#gid=1194117140"

  # Extract the Google Sheets file ID from the URL
  # This enables the construction of a direct CSV export URL
  file_id <- sub(".*spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gsheets_url)

  # Extract the gid (sheet ID) from the URL
  gid <- sub(".*gid=([0-9]+).*", "\\1", gsheets_url)

  # Construct the direct CSV export URL for Google Sheets
  download_url <- paste0("https://docs.google.com/spreadsheets/d/", file_id, "/export?format=csv&gid=", gid)

  # Create a temporary file to store the downloaded CSV
  # `tempfile()` generates a unique file name in a temporary directory
  temp_file <- tempfile(fileext = ".csv")

  # Download the file from the Google Sheets URL
  # `tryCatch` is used to handle potential errors during download,
  # such as connection issues or invalid URLs
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    # Stop execution and throw an error message if the download fails
    stop("Error downloading the file: ", e$message)
  })

  # Check the HTTP status code of the response
  # A 200 code indicates a successful download
  if (httr::status_code(response) != 200) {
    # If the status code is not 200, stop execution and throw an error
    stop("Download failed. Status code: ", httr::status_code(response))
  }

  # Read and clean the data from the downloaded CSV file
  # `readr::read_csv()` reads the CSV file, skipping the first `skip_rows`
  # `janitor::clean_names()` standardizes column names to `snake_case`
  # `janitor::remove_empty("cols")` removes any columns that are completely empty
  suppressMessages(data_clean <- readr::read_csv(temp_file,
                                                 skip = skip_rows,
                                                 show_col_types = FALSE) |>
                     janitor::clean_names() |>
                     janitor::remove_empty("cols")
  )

  # Clean up: remove the temporary file
  unlink(temp_file)

  # Return the cleaned data frame
  return(data_clean)
}
