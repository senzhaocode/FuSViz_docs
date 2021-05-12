## Installation

### Prerequisites

FuSViz is a shiny app and requires R working environment:

__R (>=4.0.0)__: https://www.r-project.org/; [RStudio](https://rstudio.com/products/rstudio/download/#download) is recommended. 
For windows users, if an earlier version of R (< 4.0) is present in the system, please uninstall it firstly and make sure only R >=4.0 is available.

### Install and launch FuSViz

	if (! require(‘devtools’)) install.packages(‘devtools’)
	devtools::install_github(‘senzhao_code/FuSViz’)

	source(file.path(system.file("app", package = "FuSViz"), "global.R"), local = TRUE, chdir = TRUE)
	FuSViz_app()

We recommend user’s laptop or PC has >= 2 cores and >= 4GB memory for running FuSViz locally.

**NOTE**: the following browsers have been tested and are supported well

* Safari (version >= 14.0)
* Mozilla Firefox (version >= 83.0)
* Google Chrome (version >= 87.0.4280.67 official build x86_64)
* Windows IE (version >= 10) may work, but does not guarantee

#### Host on a single server

Users could host FuSViz Shiny application at server end (only linux OS distributions are supported) using Shiny Server.
Please follow the installation and adminstration of [Shiny Server](https://www.rstudio.com/products/shiny/download-server/)

### Online availability

FuSViz shiny app is free available at XXXXXXXXXXXXXX

