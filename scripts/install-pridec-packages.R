options(timeout = 3600)

remotes::install_bioc("3.22/graph")
remotes::install_bioc("3.22/Rgraphviz")
remotes::install_version("INLA", version = "25.10.19",
                         repos = c(getOption("repos"),
                                   INLA = "https://inla.r-inla-download.org/R/stable"), dep = TRUE)
remotes::install_github("Pivot-Madagascar/PRIDEC-package", ref = "v0.2.1", dependencies = TRUE)
