#' Executes Robust Brain Extraction
#' @param infile Input filename
#' @param outfile Output skull-stripped file
#' @param verbose print diagnostic messages
#' @param ... arguments to be passed to \code{\link{system}}
#' @return List of result of \code{system} command,
#' names of input and output file
#' @export
#' @examples
#' result = robex(infile = "", outfile = "")
#'
#' if (requireNamespace("kirby21.t1")) {
#'    infile = kirby21.t1::get_t1_filenames(id = "113", visit = 1)
#'    if (is.null(infile)) {
#'    infile = ""
#'    }
#'    if (!file.exists(infile)) {
#'       outdir = tempdir()
#'       try({kirby21.t1::download_t1_data(outdir = outdir)})
#'      infile = kirby21.t1::get_t1_filenames(
#'      id = "113", visit = 1,
#'      outdir = outdir)
#'    }
#'    if (!is.null(infile)) {
#'      if (file.exists(infile)) {
#'        result = robex(infile = infile)
#'        stopifnot(file.exists(result$outfile))
#'      }
#'    }
#' }
#' @importFrom neurobase checkimg
#' @import ITKR
robex = function(
  infile,
  outfile = tempfile(fileext = ".nii.gz"),
  verbose = TRUE,
  ...){


  infile = neurobase::checkimg(infile)
  xinfile = infile
  infile = shQuote(infile)
  xoutfile = outfile
  if (.Platform$OS.type == "windows") {
    outfile = gsub("\\", "/", outfile, fixed = TRUE)
    outfile = gsub("/+", "/", outfile)
    outfile = gsub("/", "\\\\", outfile)
  }
  outfile = shQuote(outfile)

  # install_robex()

  cmd = robex_cmd()

  # need this for the ref_vols and such
  owd = getwd()
  on.exit({
    setwd(owd)
  })
  dn = dirname(cmd)
  setwd(dn)
  # we can just use this because may have weird things in library for windows
  cmd = file.path(".", basename(cmd))

  cmd = paste0(cmd, " ", infile, " ", outfile)
  if (verbose) {
    message(cmd)
  }
  res = system(cmd, ...)
  if (res != 0) {
    warning("ROBEX result indicated an error!  Please check resutls.")
  }
  if (!file.exists(xoutfile)) {
    warning("ROBEX result image not found!  Please check resutls.")
  }
  return(
    list(result = res,
         infile = xinfile,
         outfile = xoutfile)
  )
} ## end robex
