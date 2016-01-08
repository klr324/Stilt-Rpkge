\name{emul.1D}
\alias{emul.1D}
\docType{data}
\title{
Emulator of model for the 1-parameter example
}
\description{
Gaussian Process emulator object fitted to the 1-parameter example given
in Data.1D.par and Data.1D.model
}
\usage{data(emul.1D)}
\format{
  This is a standard emulator list object, containing standard emulator
  components as described in 'emulator' function
}
\details{
The emulator was fit with both the parameter and time covariates,
with a relative tolerance of 1E-9, with two optimization attempts. The
regression coefficients were estimated during the optimization process.
}
\examples{
# Cross-validate the 1-parameter model emulator and plot the results at
# time index 5
data(emul.1D)
test.all(emul.1D, 5)
}
\keyword{datasets}
