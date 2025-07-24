#' @title Retrieve Forest Concessions Data from SNIFFS - SERFOR
#'
#' @description
#' Downloads and processes the most recent dataset of forest concessions (Títulos Habilitantes)
#' from the statistical component of the Sistema Nacional de Información Forestal y de Fauna Silvestre (SNIFFS),
#' administered by SERFOR (Servicio Nacional Forestal y de Fauna Silvestre) in Peru.
#'
#' The function accesses a resource publicly shared by SNIFFS.
#'
#' @return A **tibble** containing the cleaned forest concessions data,
#' including relevant fields such as concession type, location, area, and other metadata.
#'
#' @details
#' The dataset is sourced from a static link to a public file hosted on Google Drive.
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
th_concesiones <- function() {
  # Internal function parameters
  # Number of rows to skip when reading the Excel file.
  skip_rows <- 2
  # Public Google Drive URL containing the concessions data.
  gdrive_url <- "https://drive.google.com/file/d/17BN0LGospM4M3x90OX83a1mBRN4-d_6I/view"

  # Extract the Google Drive file ID from the URL.
  # This enables the construction of a direct download URL.
  file_id <- sub(".*file/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)
  # Construct the direct download URL.
  download_url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

  # Create a temporary file to store the downloaded Excel.
  # `tempfile()` generates a unique file name in a temporary directory.
  temp_file <- tempfile(fileext = ".xlsx")

  # Download the file from the Google Drive URL.
  # `tryCatch` is used to handle potential errors during download,
  # such as connection issues or invalid URLs.
  response <- tryCatch({
    httr::GET(download_url, httr::write_disk(temp_file, overwrite = TRUE))
  }, error = function(e) {
    # Stop execution and throw an error message if the download fails.
    stop("Error downloading the file: ", e$message)
  })

  # Check the HTTP status code of the response.
  # A 200 code indicates a successful download.
  if (httr::status_code(response) != 200) {
    # If the status code is not 200, stop execution and throw an error.
    stop("Download failed. Status code: ", httr::status_code(response))
  }

  # Read and clean the data from the downloaded Excel file.
  # `readxl::read_excel()` reads the file, skipping the first `skip_rows`.
  # `janitor::clean_names()` standardizes column names to `snake_case`.
  # `janitor::remove_empty("cols")` removes any columns that are completely empty.
  suppressMessages(data_clean <- readxl::read_excel(temp_file,
                                   skip = skip_rows) |>
    janitor::clean_names() |>
    janitor::remove_empty("cols")
)
  # Return the cleaned data frame.
  return(data_clean)
}
