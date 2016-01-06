\name{Data.1D.par}
\alias{Data.1D.par}
\docType{data}
\title{
Parameter settings for 1-parameter ensemble model output in Data.1D.model
}
\description{
Parameter settings for 1-parameter ensemble model output in Data.1D.model

}
\usage{data(Data.1D.par)}
\format{
  The format is list containing three elements:
  \describe{
     \item{$par}{ [1, 1:21] matrix of parameter settings. The columns
       correspond to columns of $out in Data.1D.model. The parameter settings
       are (0, 1, ..., 20)}
     \item{$parnames}{ Parameter name = "Parameter 1"}
     \item{$parunits}{ Parameter units = "Unitless"}
 }
}
\examples{
# Fit an emulator to the 1-parameter ensemble data
data(Data.1D.model)
data(Data.1D.par)
emulator(Data.1D.par, Data.1D.model, FALSE, FALSE, 1, 1)

}
\keyword{datasets}
