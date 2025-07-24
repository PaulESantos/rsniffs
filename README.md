
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rsniffs

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![CRAN
status](https://www.r-pkg.org/badges/version/rsniffs)](https://CRAN.R-project.org/package=rsniffs)
[![](http://cranlogs.r-pkg.org/badges/grand-total/rsniffs?color=green)](https://cran.r-project.org/package=rsniffs)
[![](http://cranlogs.r-pkg.org/badges/last-week/rsniffs?color=green)](https://cran.r-project.org/package=rsniffs)
[![Codecov test
coverage](https://codecov.io/gh/PaulESantos/rsniffs/branch/main/graph/badge.svg)](https://app.codecov.io/gh/PaulESantos/rsniffs?branch=main)
[![R-CMD-check](https://github.com/PaulESantos/rsniffs/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PaulESantos/rsniffs/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Overview

**`rsniffs`** is an R package that provides programmatic access to
selected statistical datasets from the [National Forest and Wildlife
Information System
(SNIFFS)](https://sniffs.serfor.gob.pe/estadistica/es), managed by
SERFOR (Servicio Nacional Forestal y de Fauna Silvestre) in Peru.

SNIFFS is a national platform designed to support decision-making in the
forest and wildlife sector. Among its various components, this package
focuses **exclusively** on the **Statistical Component**, providing
structured and cleaned access to publicly available datasets.

> 🔗 For more information about SNIFFS, visit:
> [sniffs.serfor.gob.pe](https://sniffs.serfor.gob.pe)

------------------------------------------------------------------------

## Features

This package allows users to access cleaned and up-to-date data from the
following developed elements within the Statistical Component of SNIFFS:

| COMPONENT | Dataset Element | Status |
|----|----|----|
| TÍTULOS HABILITANTES | CONCESIONES | Desarrollada |
| TÍTULOS HABILITANTES | AUTORIZACIONES | Desarrollada como data set |
| TÍTULOS HABILITANTES | PERMISOS |  |
| TÍTULOS HABILITANTES | BOSQUES LOCALES | Desarrollada |
| TÍTULOS HABILITANTES | CESIÓN EN USO EN SISTEMA AGROFORESTAL |  |
| REGISTROS NACIONALES | REGENTES FORESTALES Y DE FAUNA SILVESTRE |  |
| REGISTROS NACIONALES | PLANTACIONES FORESTALES |  |
| REGISTROS NACIONALES | ESPECIALISTAS |  |
| REGISTROS NACIONALES | REGISTRO NACIONAL DE INFRACTORES |  |
| FAUNA SILVESTRE | CURSO DE EDUCACIÓN, SEGURIDAD Y ÉTICA EN LA CAZA DEPORTIVA | Desarrollada |
| FAUNA SILVESTRE | REGISTRO DE EMPRESAS AUTORIZADAS | Desarrollada |
| FAUNA SILVESTRE | CENTRO DE MANEJO/CRÍA DE FAUNA SILVESTRE |  |
| AUTORIZACIONES | DESBOSQUE |  |
| AUTORIZACIONES | CAMBIO DE USO |  |
| PRODUCCIÓN, INDUSTRIA Y COMERCIO | PRODUCCIÓN FORESTAL |  |
| PRODUCCIÓN, INDUSTRIA Y COMERCIO | DEPÓSITOS Y ESTABLECIMIENTOS | Desarrollada |
| PRODUCCIÓN, INDUSTRIA Y COMERCIO | CENTROS DE TRANSFORMACIÓN |  |
| PRODUCCIÓN, INDUSTRIA Y COMERCIO | PRECIOS FORESTALES |  |
| PRODUCCIÓN, INDUSTRIA Y COMERCIO | BAMBÚ A NIVEL NACIONAL | Desarrollada |
| CAMÉLIDOS SUDAMERICANOS SILVESTRES | CAMÉLIDOS SUDAMERICANOS |  |
| CAMÉLIDOS SUDAMERICANOS SILVESTRES | DECLARACIONES DE MANEJO |  |
| COMERCIO EXTERIOR | EXPORTACIONES |  |
| COMERCIO EXTERIOR | PERMISOS DE EXPORTACIÓN | Desarrollada |
| CONTROL DE PRODUCTORES | PRODUCTOS TRANSFERIDOS |  |
| CONTROL DE PRODUCTORES | SEDES Y PUESTOS DE CONTROL | Desarrollada |
| CONTROL DE PRODUCTORES | PRODUCTORES FORESTALES CLASIFICADOS PARA SER TRANSFERIDOS |  |
| INVESTIGACIÓN CIENTÍFICA Y RECURSOS GENÉTICOS | AUTORIZACIONES DE INVESTIGACIÓN CIENTÍFICA |  |
| INVESTIGACIÓN CIENTÍFICA Y RECURSOS GENÉTICOS | REGISTRO DE ACCESO A RECURSOS GENÉTICOS |  |
| INVESTIGACIÓN CIENTÍFICA Y RECURSOS GENÉTICOS | INSTITUCIONES CIENTÍFICAS NACIONALES DEPOSITARIAS DE MATERIAL BIOLÓGICO | Desarrollada |

Each function downloads the data directly from official SERFOR Google
Drive spreadsheets, processes and cleans the information.

------------------------------------------------------------------------

## Installation

You can install the development version of `rsniffs` from GitHub using
[`pak`](https://pak.r-lib.org/) or
[`remotes`](https://github.com/r-lib/remotes):

``` r
# Using pak
pak::pak("PaulESantos/rsniffs")

# Or using remotes
remotes::install_github("PaulESantos/rsniffs")
```

## Usage

``` r
library(rsniffs)
#> Welcome to rsniffs (0.0.0.1)
#> This package provides tools to access and query data from the SNIFFS statistics platform:
#>   https://sniffs.serfor.gob.pe/estadistica/es
#> Type ?rsniffs to get started or visit the documentation for examples and guidance.

# Example: Get bamboo  data
pic_plantaciones_bambu()
#> # A tibble: 1,681 × 23
#>    ano_de_otorgamiento arffs       sede  numero_certificado titular departamento
#>                  <dbl> <chr>       <chr> <chr>              <chr>   <chr>       
#>  1                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-00… DELGAD… AMAZONAS    
#>  2                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… SANCHE… AMAZONAS    
#>  3                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… CHUQUI… AMAZONAS    
#>  4                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… CULQUI… AMAZONAS    
#>  5                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… CULQUI… AMAZONAS    
#>  6                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… CUIPAL… AMAZONAS    
#>  7                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… TAFUR … AMAZONAS    
#>  8                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… TAFUR … AMAZONAS    
#>  9                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… CORTEG… AMAZONAS    
#> 10                2018 GORE Amazo… CHAC… 01-AMA/REG-PLT-20… HERNAN… AMAZONAS    
#> # ℹ 1,671 more rows
#> # ℹ 17 more variables: provincia <chr>, distrito <chr>, zona <chr>,
#> #   sistema_plantacion <chr>, finalidad <chr>, ano_plantacion <dbl>,
#> #   mes_plantacion <chr>, generos_de_bambu <chr>,
#> #   especie_nombre_cientifico <chr>, especie_nombre_comun <chr>,
#> #   superficie_ha <dbl>, tipo_plantacion <chr>, produccion_estimada <dbl>,
#> #   unidad_medida <chr>, sistema_coordenada_id <dbl>, …
pic_movilizacion_bambu()
#> # A tibble: 230 × 11
#>    org_dep org_prov    org_distr dest_dep dest_prov dest_distr
#>    <chr>   <chr>       <chr>     <chr>    <chr>     <chr>     
#>  1 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#>  2 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#>  3 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#>  4 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#>  5 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#>  6 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#>  7 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#>  8 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#>  9 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#> 10 JUNIN   CHANCHAMAYO VITOC     TACNA    TACNA     TACNA     
#> # ℹ 220 more rows
#> # ℹ 5 more variables: especie_nombre_cientifico <chr>,
#> #   especie_nombre_comun <chr>, producto <chr>, volumen <dbl>,
#> #   unidad_medida <chr>
```

## Available Functions

| Function | Description |
|----|----|
| `th_concesiones()` | Get registry of forest concessions |
| `th_autorizaciones` | Internal dataset on authorizations |
| `th_bosques_locales()` | Get registry of local forests |
| `fs_curso_caza_deportiva()` | Get registry of authorized hunting courses |
| `fs_empresas_autorizadas()` | Get registry of authorized wildlife companies |
| `pi_depositos()` | Get registry of deposits and establishments |
| `pi_bambu_nacional()` | Get bamboo-related data at the national level |
| `ce_permisos_exportacion()` | Get registry of issued export permits |
| `cp_sede_puestos_control()` | Get list of forest and wildlife control offices |
| `icrg_inst_depositarias()` | Get list of national scientific institutions storing biological samples |

## Data Sources

All data is sourced from official SERFOR datasets published through the
SNIFFS statistical portal. These datasets are public, periodically
updated, and hosted on Google Drive.

## Notes

📶 An active internet connection is required to retrieve the data.

⚠️ All datasets are read from Google Sheets hosted by SERFOR and may
change structure without prior notice.

## Contributing

If you’d like to contribute or suggest improvements, feel free to open
an issue or submit a pull request on GitHub.

## Citation

If you use rsniffs in your work, please cite it as follows:

``` r
Santos Andrade, Paul E. (2025). rsniffs: Access Statistical Data from the National Forest and Wildlife Information System (SNIFFS), Peru.
```
