
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

This package allows users to access cleaned and up-to-date data from
selected datasets published under the Statistical Component of SNIFFS.
Each function connects to SERFOR’s official cloud resources, retrieves
structured data, and returns it as a tidy `data.frame` ready for
analysis.

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

# Example: Get bamboo-related data
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

| Component | Element | Function Name | Status |
|----|----|----|----|
| TÍTULOS HABILITANTES | CONCESIONES | `th_concesiones()` | Desarrollada |
| TÍTULOS HABILITANTES | AUTORIZACIONES | `th_autorizaciones()` | Dataset |
| TÍTULOS HABILITANTES | BOSQUES LOCALES | `th_bosque_local()` | Desarrollada |
| FAUNA SILVESTRE | CURSO DE EDUCACIÓN, SEGURIDAD Y ÉTICA EN LA CAZA DEPORTIVA | `fs_curso_caza_deportiva()` | Desarrollada |
| FAUNA SILVESTRE | REGISTRO DE EMPRESAS AUTORIZADAS | `fs_reg_empresas_autorizadas()` | Desarrollada |
| PRODUCCIÓN, INDUSTRIA Y COMERCIO | DEPÓSITOS Y ESTABLECIMIENTOS | `pic_depositos_establecimientos()` | Desarrollada |
| PRODUCCIÓN, INDUSTRIA Y COMERCIO | BAMBÚ A NIVEL NACIONAL | `pic_plantaciones_bambu()` | Desarrollada |
| PRODUCCIÓN, INDUSTRIA Y COMERCIO | BAMBÚ A NIVEL NACIONAL | `pic_movilizacion_bambu()` | Desarrollada |
| CAMÉLIDOS SUDAMERICANOS SILVESTRES | DECLARACIONES DE MANEJO | `css_declaraciones_manejo()` | Desarrollada |
| COMERCIO EXTERIOR | PERMISOS DE EXPORTACIÓN | `ce_permisos_exportacion()` | Desarrollada |
| CONTROL DE PRODUCTORES | SEDES Y PUESTOS DE CONTROL | `cp_sede_puestos_control()` | Desarrollada |
| INVESTIGACIÓN CIENTÍFICA Y RECURSOS GENÉTICOS | REGISTRO DE ACCESO A RECURSOS GENÉTICOS | `icrg_acceso_recursos_geneticos()` | Desarrollada |
| INVESTIGACIÓN CIENTÍFICA Y RECURSOS GENÉTICOS | INSTITUCIONES CIENTÍFICAS NACIONALES DEPOSITARIAS | `icrg_inst_depositarias()` | Desarrollada |

> ℹ️ The elements not listed here are still under development or
> integration and will be included in future versions of the package.

## Data Sources

All data is retrieved directly from official SERFOR spreadsheets
published through the SNIFFS Statistical portal, ensuring transparency
and reproducibility.

## Notes

📶 Internet connection required to download datasets.

⚠️ Data structure may change without prior notice if SERFOR updates its
public datasets.

## Contributing

Contributions and suggestions are welcome! Feel free to submit an issue
or a pull request via GitHub.
