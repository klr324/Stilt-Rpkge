\name{Data.UVic.par}
\alias{Data.UVic.par}
\docType{data}
\title{
UVic ESCM climate model ensemble parameter settings
}
\description{
Parameter settings for the UVic ESCM climate model ensemble output in Data.UVic.model
}
\usage{data(Data.UVic.par)}
\format{
  The format is a list containing three variables
  \describe{
      \item{$par}{Parameter settings for the temperature output from the
	UVic ESCM ensemble in Data.UVic.model. [1:3, 1:250]
	matrix. [row, col] = [parameter number, run number]. The columns
	of $par correspond to columns of $out in Data.UVic.model. }
      \item{$parnames}{Parameter names for rows of $par}
      \item{$parunits}{Parameter units for rows of $par}
   }
}

\details{
The ensemble was run by Roman Olson at Penn State University. The
ensemble varies key parameters that affect decadal- and century-scale
climate response to external climate forcings: vertical ocean
diffusivity, climate sensitivity, and anthropogenic sulfate aerosol
scaling factor.
}
\source{
Olson, R., R. Sriver, M. Goes, N. M. Urban, H. D. Matthews, M. Haran and
K. Keller (2012): A climate sensitivity estimate using Bayesian fusion
of instrumental observations and an Earth System model. Journal of
Geosphysical Research - Atmospheres, 117(D04103),
doi:10.1029/2011JD016620
}
\references{
Olson, R., R. Sriver, W. Chang, M. Haran, N. M. Urban and K. Keller
(2013): What is the effect of unresolved internal climate variability on
climate sensitivity estimates? Journal of Geophysical Research -
Atmospheres, 118, doi:10.1002/jgrd.50390
}
\examples{
# Fit an emulator to the UVic ESCM ensemble data using all parameter and
# time covariates
data(Data.UVic.par)
data(Data.UVic.model)
\dontrun{emulator(Data.UVic.par, Data.UVic.model, c(TRUE, TRUE, TRUE), TRUE, 1, 1)}
}
\keyword{datasets}
