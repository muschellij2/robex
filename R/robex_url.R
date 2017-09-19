#' @title ROBEX URL for binaries
#' @description Returns a URL for the ROBEX executable
#'
#' @return Character vector of URL
#' @export
robex_url = function() {
  url = "http://johnmuschelli.com/robex/"
  ver = robex_version()
  ver = gsub("[.]", "", ver)
  # os =  switch(.Platform$OS.type,
  #              unix = "linux64.tar.gz",
  #              windows = "win.zip")
  os = "source.all_platforms.zip"
  stub = paste0("ROBEXv", ver, ".", os)
  full_url = paste0(url, stub)
  return(full_url)
}

