\name{Data.AR1Korea.model}
\alias{Data.AR1Korea.model}
\docType{data}
\title{
Korean modelled temperature variability and future change
}
\description{
Future 2081-2100 RCP8.5 emissions scenario change in summer mean maximum temperature compared to present (1973-2005) over Korea as a function of present-day (1973-2005) variability (innovation standard deviation and autocorrelation from CMIP5 GCMs)
}
\usage{data(Data.AR1Korea.model)}
\format{
  The format is a list containing five elements:
  \describe{
      \item{$t}{Time vector for model output: (2081, 2082, ... 2100)} 
      \item{$tunits}{Time units = "Year"}
      \item{$out}{[1:20, 1:29] matrix of GCM temperature change
	output. [row, col] = [time, model index]. The variability parameters 
	corresponding to columns of $out are in the $par element
	of Data.AR1Korea.par}
      \item{$outname}{ Output name =  "Temp Change 1973-2005 to 2081-2100"}
      \item{$outunits}{ Output units = "K"}
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
