\name{rsurface.plot}
\alias{rsurface.plot}
\title{
To produce a response surface plot of the emulator
}
\description{
To produce a response surface plot of the emulator
}
\usage{
rsurface.plot(emul, parind, parvals, tind, n1, n2, zlim = NULL)
}
\arguments{
  \item{emul}{
    A standard emulator object, as output, for example, by the
    'emulator' function
}
  \item{parind}{
Vector of parameter indices (x and y) (columns of \code{emul$Theta.mat}) for
which the response surface is desired. Should contain only two
elements. \code{parind[2]} can be less or more than \code{parind[1]}.
}
  \item{parvals}{
A vector of parameter values to use for the rest of the
parameters (that are kept at constant values). Must be the same length as
the number of columns in \code{emul$Theta.mat}. The columns corresponding
to \code{parind} should be NA.
}
  \item{tind}{
Time index at which to predict
}
  \item{n1}{
X direction grid size
}
  \item{n2}{
Y direction grid size
}
  \item{zlim}{
Vector of z-limits for the filled.contour function. Default is the range
of data plotted.
}
}
\details{
Produces a response surface plot of the emulator as a function of
selected parameters, while the rest of the parameters are fixed at
their values set by \code{parvals}. Use \code{n1} and \code{n2} to
specify X and Y grid size. Optionally, plot limits can be specified
through \code{zlim}. The code relies on the filled.contour function.
}
\section{Note}{
Evaluation of this function (especially for large datasets and grid
sizes) might take a long time. This is because in current specification, 
the 'predict.emul' function predicts the entire time-series (or space 
transect) at once.
}
\value{
None
}
\references{
    R. Olson and W. Chang (2013): Mathematical framework for a separable
Gaussian Process Emulator. Tech. Rep., available from \cr
\href{http://www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf}{www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf}.
}
\seealso{
\code{\link{emulator}}, \code{\link{predict.emul}}
}
\examples{
# Plot the SICOPOLIS ice mass loss in year 2500 as a function of Snow
# PDD Factor and Ice PDD Factor, at mid-range values of other parameters
data(emul.Sicopolis)
\dontrun{
  rsurface.plot(emul=emul.Sicopolis, parind=c(4,5), parvals=c(3, 10, 50, NA, NA),
      tind=661, n1=5, n2=5)
  }
}
