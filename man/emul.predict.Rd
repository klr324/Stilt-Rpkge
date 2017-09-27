\name{emul.predict}
\alias{emul.predict}
\title{
To predict using an emulator
}
\description{
To predict using an emulator
}
\usage{
emul.predict(emul, theta.star)
}
\arguments{
  \item{emul}{
Standard emulator object, as output, for example, by the 'emulator'
function.
}
  \item{theta.star}{
Parameter setting at which to predict. Must have the same number of
elements as there are columns in the \code{emul$Theta.mat}. Vector (or,
for a 1 parameter ensemble, a single numeric value).
}
}
\details{
Emulator prediction follows standard formulation in Gaussian Process
theory. For more details, see References.
}
\value{
Prediction at the parameter setting \code{theta.star} for all times
specified by \code{emul$t.vec}. List with components
\item{mean}{Posterior mean. n*1 matrix. Rows correspond to the times of \code{emul$t.vec}.}
\item{covariance}{ Posterior covariance matrix. n*n matrix. Diagonal
  elements represent variances at each time in \code{emul$t.vec}.}
}
\references{
  R. Olson and W. Chang (2013): Mathematical framework for a separable
Gaussian Process Emulator. Tech. Rep., available from \cr
\href{http://www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf}{www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf}.
}
\note{
Prediction outside the emulator range ("extrapolation") is currently not allowed.
}
\seealso{
  \code{\link{rsurface.plot}}, \code{\link{test.csv}}
}
\examples{
# Predict using the SICOPOLIS model at a mid-range parameter setting, and plot
# the prediction and associated uncertainty
data(emul.Sicopolis)
pred <- emul.predict(emul.Sicopolis, c(3, 10, 50, 3, 12.5))
plot.default(NA, xlim=range(emul.Sicopolis$t.vec),
     ylim=range(pred$mean), xlab="Year",
     ylab="Ice Mass Loss relative to year 2003")
lines(emul.Sicopolis$t.vec, pred$mean, col="brown", lwd=3)
std <- sqrt(diag(pred$covariance))
lines(emul.Sicopolis$t.vec, pred$mean + std, col="brown", lty=2)
lines(emul.Sicopolis$t.vec, pred$mean - std, col="brown", lty=2)


# Fit an emulator to the 1-parameter test ensemble data, predict at
# Theta*=8, and plot the prediction
data(Data.1D.par)
data(Data.1D.model)
emul.1D <- emulator(Data.1D.par, Data.1D.model, TRUE, TRUE, 100, 0.1)
pred.1D <- emul.predict(emul.1D, 8)
plot(emul.1D$t.vec, pred.1D$mean, xlab="Year",
     ylab="Sample Model Output at Theta*=8")
}
