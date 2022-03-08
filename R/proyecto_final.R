#' Crear proyecto final del Taller II
#'
#' @param path Nombre del directorio en el que se creará el proyecto.
#'     Será usado como nombre del proyecto.
#' @param open Boolean. Abrir el proyecto creado?
#' @param with_git Boolean. Iniciar proyecto con repositorio git?
#'
#' @export
#'
#' @return path
crear_proyecto_final <- function(
    path,
    open = TRUE,
    with_git = FALSE
)  {

    cli::cat_rule("Creando proyecto final")

    usethis::create_project(
        path = path,
        open = FALSE
    )

    cli::cat_rule("Copiando esqueleto del paquete")


    # Copiar esqueleto desde inst/
    from <- system.file("proyecto_final_files", package = "ejerciciosT2", mustWork = FALSE)
    fs::dir_copy(path = from, new_path = path, overwrite = TRUE)

    # Iniciar repositorio git
    if (isTRUE(with_git)) {
        cli::cat_rule("Initializing git repository")
        git_output <- system(
            command = paste("git init", path),
            ignore.stdout = TRUE,
            ignore.stderr = TRUE
        )
        if (git_output) {
            cli::cat_bullet("Error iniciando repositorio git", bullet_col = "red")
        } else {
            cli::cat_bullet("Repositorio git iniciado", bullet = "tick", bullet_col = "green")
        }
    }


    # Abrir proyecto o establecer directorio de trabajo
    if (isTRUE(open)) {
        if (rstudioapi::isAvailable() & rstudioapi::hasFun("openProject")) {
            rstudioapi::openProject(path = path)
        } else {
            setwd(path)
        }
    }
}

# crear_proyecto_final(path = "test")
