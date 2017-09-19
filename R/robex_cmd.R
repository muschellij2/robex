#' @title Find ROBEX Executable
#' @description Returns a path for the ROBEX executable
#' @param ... arguments to pass to \code{\link{system.file}}
#'
#' @return Character vector of path
#' @export
robex_cmd = function(...) {
  # suff = switch(.Platform$OS.type,
  #        unix = "",
  #        windows = ".exe")
  # cmd = paste0("ROBEX", suff)

  suff = switch(.Platform$OS.type,
                unix = ".sh",
                windows = ".bat")
  cmd = paste0("runROBEX", suff)
  system.file("ROBEX", cmd, package = "robex", ...)
}
