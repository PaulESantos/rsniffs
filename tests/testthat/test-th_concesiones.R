# Tests para th_concesiones
test_that("th_concesiones returns correct data structure", {
  skip_on_cran()
  skip_if_offline()

  result <- th_concesiones()

  # Verificar que retorna un tibble
  expect_s3_class(result, "tbl_df")
  expect_s3_class(result, "data.frame")

  # Verificar dimensiones esperadas
  expect_gt(nrow(result), 2000)  # Al menos 2000 filas
  expect_equal(ncol(result), 11)  # Exactamente 11 columnas
})

test_that("th_concesiones has correct column names and types", {
  skip_on_cran()
  skip_if_offline()

  result <- th_concesiones()

  # Verificar nombres de columnas esperados
  expected_cols <- c("ano", "contrato", "titular", "arffs", "departamento",
                     "provincia", "distrito", "superficie_ha", "fecha_inicio",
                     "fecha_fin_vigencia", "tipo_de_concesion")

  expect_equal(names(result), expected_cols)

  # Verificar tipos de columnas
  expect_type(result$ano, "double")
  expect_type(result$contrato, "character")
  expect_type(result$titular, "character")
  expect_type(result$arffs, "character")
  expect_type(result$departamento, "character")
  expect_type(result$provincia, "character")
  expect_type(result$distrito, "character")
  expect_type(result$superficie_ha, "double")
  expect_type(result$fecha_inicio, "double")
  expect_type(result$fecha_fin_vigencia, "double")
  expect_type(result$tipo_de_concesion, "character")
})

test_that("th_concesiones data contains expected values", {
  skip_on_cran()
  skip_if_offline()

  result <- th_concesiones()

  # Verificar que no hay columnas completamente vacías
  expect_true(all(sapply(result, function(x) sum(!is.na(x)) > 0)))

  # Verificar rangos de valores lógicos
  expect_true(all(result$ano >= 2000 & result$ano <= as.numeric(format(Sys.Date(), "%Y"))))
  expect_true(all(result$superficie_ha > 0, na.rm = TRUE))

  # Verificar que hay departamentos conocidos del Perú
  peru_departments <- c("CUSCO", "PIURA", "PASCO", "JUNIN", "LORETO", "UCAYALI")
  expect_true(any(result$departamento %in% peru_departments))

  # Verificar que ARFFS contiene valores esperados
  expect_true(any(grepl("ATFF", result$arffs)))
})


test_that("th_concesiones is reproducible", {
  skip_on_cran()
  skip_if_offline()

  # Ejecutar la función dos veces
  result1 <- th_concesiones()
  Sys.sleep(1)  # Pequeña pausa
  result2 <- th_concesiones()

  # Los resultados deben ser idénticos (mismo archivo fuente)
  expect_equal(nrow(result1), nrow(result2))
  expect_equal(ncol(result1), ncol(result2))
  expect_equal(names(result1), names(result2))
})

test_that("th_concesiones cleans data properly", {
  skip_on_cran()
  skip_if_offline()

  result <- th_concesiones()

  # Verificar que los nombres están en snake_case
  expect_true(all(grepl("^[a-z][a-z0-9_]*$", names(result))))

  # Verificar que no hay columnas completamente vacías
  empty_cols <- sapply(result, function(x) all(is.na(x)))
  expect_false(any(empty_cols))

  # Verificar que no hay filas completamente vacías
  empty_rows <- apply(result, 1, function(x) all(is.na(x)))
  expect_false(any(empty_rows))
})

test_that("th_concesiones performance is acceptable", {
  skip_on_cran()
  skip_if_offline()

  # La función debería ejecutarse en menos de 30 segundos
  start_time <- Sys.time()
  result <- th_concesiones()
  end_time <- Sys.time()

  execution_time <- as.numeric(difftime(end_time, start_time, units = "secs"))
  expect_lt(execution_time, 30)
})

# Test de integración
test_that("th_concesiones works with dplyr operations", {
  skip_on_cran()
  skip_if_offline()

  result <- th_concesiones()

  # Verificar que funciona con operaciones típicas de dplyr
  expect_no_error({
    filtered <- result |>
      dplyr::filter(departamento == "CUSCO") |>
      dplyr::select(ano, titular, superficie_ha) |>
      dplyr::arrange(desc(superficie_ha))
  })

  expect_s3_class(filtered, "tbl_df")
})

# Test para verificar integridad de datos específicos
test_that("th_concesiones contains expected sample data", {
  skip_on_cran()
  skip_if_offline()

  result <- th_concesiones()

  # Verificar que contiene algunos registros específicos conocidos
  # (basado en la muestra que proporcionaste)
  cusco_records <- result |> dplyr::filter(departamento == "CUSCO")
  expect_gt(nrow(cusco_records), 0)

  # Verificar que hay contratos del tipo esperado
  expect_true(any(grepl("CUS", result$contrato)))

  # Verificar rangos de superficie
  expect_true(any(result$superficie_ha > 1000, na.rm = TRUE))
  expect_true(any(result$superficie_ha < 100, na.rm = TRUE))
})
