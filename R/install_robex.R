#' Install ROBEX tools

#' @param ... arguments to pass to \code{\link{system.file}}

#' @importFrom utils download.file unzip untar
#' @export
#' @return Logical of success/failure
#' @examples
#' install_robex()
install_robex = function(...){
  robex = robex_cmd(...)

  if (!file.exists(robex)) {
    url = robex_url()
    os_type = .Platform$OS.type
    suff = switch(os_type,
                  unix = ".tar.gz",
                  windows = ".zip")
    destfile = tempfile(fileext = suff)

    dl = download.file(url, destfile = destfile)
    if (dl != 0) {
      warning("Download may not have worked correctly")
    }

    exdir = system.file(package = "robex", ...)
    if (os_type == "unix") {
      files = utils::untar(tarfile = destfile, exdir = exdir, list = TRUE)
      result = utils::untar(tarfile = destfile, exdir = exdir)
      if (result != 0) {
        warning("Untar may not have worked correctly")
      }
    }
    if (os_type == "windows") {
      files = unzip(
        destfile,
        exdir = exdir)
    }
  }
  robex = robex_cmd(...)
  if (file.exists(robex)) {
    system(sprintf("chmod +x %s", robex))
  }
  return(file.exists(robex))
}
