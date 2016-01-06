\name{Data.UVic.model}
\alias{Data.UVic.model}
\docType{data}
\title{
UVic ESCM climate model ensemble output
}
\description{
Temperature anomaly output from UVic ESCM climate model ensemble
}
\usage{data(Data.UVic.model)}
\format{
  The format is a list containing five elements:
  \describe{
      \item{$t}{Time vector for model output: (1850, 1851, ... 2009)} 
      \item{$tunits}{Time units = "Year"}
      \item{$out}{[1:160, 1:250] matrix of UVic ESCM temperature
	output. [row, col] = [time, run index]. The parameter settings
	corresponding to runs in columns of $out are in the $par element
	of Data.UVic.par}
      \item{$outname}{ Output name =  "Temperature Anomaly from 1850-1899"}
      \item{$outunits}{ Output units = "[K]"}
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
#time covariates
data(Data.UVic.model)
data(Data.UVic.par)
\dontrun{emulator(Data.UVic.par, Data.UVic.model, c(TRUE, TRUE, TRUE), TRUE, 1, 1)}
}
\keyword{datasets}
