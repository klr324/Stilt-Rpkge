\name{Data.AR1Korea.par}
\alias{Data.AR1Korea.par}
\docType{data}
\title{
Korean temperature variability parameters
}
\description{
Korean summer mean maximum temperature 1973-2005 interannual variability parameters (innovation standard deviation and autocorrelation) for 29 CMIP5 GCMs. 
}
\usage{data(Data.AR1Korea.par)}
\format{
  The format is a list containing three variables
  \describe{
      \item{$par}{Variability settings for 29 CMIP5 GCMs. [1:2, 1:29]
	matrix. Rows are: sigma (innovation std) and rho (autocorrelation).
	The columns of $par correspond to columns of $out in
	Data.AR1Korea.model. }
      \item{$parnames}{Parameter names for rows of $par}
      \item{$parunits}{Parameter units for rows of $par}
   }
}

\details{
The CMIP5 GCM output was analysed by Jong-Soo Shin and Roman Olson at
Yonsei University. The variability properties were found by maximum likelihood.
}
\examples{
# Fit an emulator to the CMIP5 GCM Korean temperature variability and change
# data with innovation standard deviation and time as covariates
data(Data.AR1Korea.model)
data(Data.AR1Korea.par)
emulator(Data.AR1Korea.par, Data.AR1Korea.model, c(TRUE, FALSE), TRUE, 3, 3)
}
\keyword{datasets}
