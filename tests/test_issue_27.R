# Regression tests for issue #27 ---------------------------------------------
# Invalid calibration should produce a contextual error before qvalue().

if (requireNamespace("qvalue", quietly = TRUE)) {
  source("R/FST functions.R")
  source("R/Likelihood functions for OutFLANK.R")
  source("R/OutFLANK.R")

  x <- data.frame(
    FSTNoCorr = c(0.1, 0.2),
    He = c(0.2, 0.3),
    OutlierFlag = FALSE,
    qvalues = NA_real_,
    pvalues = NA_real_,
    pvaluesRightTail = NA_real_
  )

  err <- tryCatch(
    pOutlierFinderChiSqNoCorr(x, Fstbar = 0, dfInferred = 10),
    error = identity
  )
  stopifnot(inherits(err, "error"), grepl("invalid neutral calibration", err$message))
}
