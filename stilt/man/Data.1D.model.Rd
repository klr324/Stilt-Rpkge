\name{Data.1D.model}
\alias{Data.1D.model}
\docType{data}
\title{
Synthetic model output for a simple 1-parameter ensemble example
}
\description{
Synthetic model output for a simple 1-parameter ensemble example
}
\usage{data(Data.1D.model)}
\format{
  The format is a list containing five elements
  \describe{
    \item{$ t}{       : 11-element time vector: (0, 1, ..., 10)}
    \item{$ tunits}{  : Time units="Year"}
    \item{$ out}{     : [1:11, 1:21] matrix of model response, [row,col]
      = [time index, parameter index]. The corresponding vector of
      parameters for columns is in the $par component of Data.1D.par.Rd ...}
    \item{$ outname}{ : Output name="Sample Output"}
    \item{$ outunits}{: Output units="Unitless"}
 }
}
\details{Model response \eqn{Y} is a function of time and parameter setting
  \eqn{\Theta} as follows: \eqn{Y=sin(\Theta)(1 + 2t+t^2)}
}
\examples{
# Fit an emulator to the 1-parameter ensemble data
data(Data.1D.model)
data(Data.1D.par)
emulator(Data.1D.par, Data.1D.model, FALSE, FALSE, 1, 1)
}
\keyword{datasets}
