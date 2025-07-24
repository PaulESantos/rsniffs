#' @title Retrieve Data on Certified Participants of the Sports Hunting Course - SERFOR
#'
#' @description
#' Downloads and processes the official dataset listing individuals who have completed
#' the **"CURSO DE EDUCACIÓN, SEGURIDAD Y ÉTICA EN LA CAZA DEPORTIVA"**
#' recorded by the *Servicio Nacional Forestal y de Fauna Silvestre* (SERFOR) through the
#' *Sistema Nacional de Información Forestal y de Fauna Silvestre* (SNIFFS).
#'
#' This function accesses a public Google Sheets resource shared by SERFOR and returns a cleaned dataset
#' containing the names, identification numbers, course identifiers, locations, and certification details of participants.
#'
#' @return A **tibble** with 12 variables and multiple rows, each representing an individual who completed the course.
#' Key fields include:
#' - `ano`: Year of certification
#' - `nombres`, `apellido_paterno`, `apellido_materno`: Full name of participant
#' - `tipo_documento`, `numero_documento`: ID type and number
#' - `curso`: Course identifier
#' - `fecha_inicio_curso`, `fecha_fin_curso`: Start and end dates
#' - `lugar`: Location of course
#' - `modalidad`: Course modality (e.g., presencial, virtual)
#' - `empresa_certificadora`: Certifying company
#'
#' @details
#' The source file is hosted on Google Drive.
#' @author
#' Paul Efren Santos Andrade
#'
#' @examples
#' \dontrun{
#' # Retrieve the sports hunting course dataset:
#' course_df <- fs_curso_caza_deportiva()
#'
#' # Preview the first few rows
#' head(course_df)
#'
#' # Summary of variables
#' summary(course_df)
#'
#' # View in spreadsheet format
#' View(course_df)
#' }
#' @export

fs_curso_caza_deportiva <- function() {
  # Internal function parameters
  # Number of rows to skip when reading the Excel file.
  skip_rows <- 2
  # Public Google Drive URL containing the concessions data.
  # URL del archivo de Google Drive (Google Sheet)
  gdrive_url <- "https://docs.google.com/spreadsheets/d/18UZQG9IKncCcCRCwPLALIzg6PTTFrYQQ/edit?gid=1955182671#gid=1955182671"

  # Extraer el ID del archivo
  file_id <- sub(".*/spreadsheets/d/([a-zA-Z0-9_-]+).*", "\\1", gdrive_url)

  # Construir la URL de descarga directa (esto NO funciona para hojas de cálculo directamente en formato Excel)
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
  data_clean
  # Return the cleaned data frame.
  return(data_clean)
}
