\name{sep.cov}
\alias{sep.cov}
\title{
Construct time and parameter covariance matrices
}
\description{
Construct time and parameter covariance matrices. The time matrix
follows standard AR(1) covariance. The parameter covariance is squared
exponential, separable between the parameters, with an extra nugget term. While
not directly related to other functions in this
package, this function can be re-used if someone wants to build a
new/different Gaussian Process emulator code.
}
\usage{
sep.cov(Theta.mat, t.vec, rho, kappa, phi.vec, zeta)
}
\arguments{
  \item{Theta.mat}{
Parameter matrix of the ensemble. [row, col] = [run number, parameter
number]. See References for more information on this and other arguments.
}
  \item{t.vec}{
Evenly spaced vector of times for model output (can also be a coordinate
vector for a regularly spaced spatial transect)
}
  \item{rho}{
Lag-1 time autocorrelation parameter \eqn{\rho}
}
  \item{kappa}{
Parameter covariance scaling factor \eqn{\kappa}
}
  \item{phi.vec}{
Vector of range parameters. Must have the same length as
number of columns in \code{Theta.mat}. All elements should be positive.
}
  \item{zeta}{
Nugget \eqn{\zeta}. Should be positive.
}
}
\details{
The time covariance is an n*n matrix (where n is the length of time
dimension). Its (j,k) element is specified by \eqn{\varsigma_{t,jk} =
  \frac{\rho^{|t_j-t_k|}}{1-\rho^2}}{\Sigma_t,jk = [\rho^|t_j -
  t_k|]/(1-\rho^2)}. The parameter covariance is a p*p matrix (where p
is the number of runs in the model ensemble). Specifically,
\eqn{\Sigma_{\theta,ij} = \kappa*exp(-A) + \zeta*1(i=j)} where
\eqn{A=\sum\limits_{k=1}^{m}{\frac{(\theta_{k,i} -
      \theta_{k,j})^2}{\phi_k^2}}}{A = sum(k=1:m)([\theta_k,i -
  \theta_k,j]^2/[(\phi_k)^2])}. Here \eqn{k} refers to parameter index.
  For more details on the time and parameter covariance matrices produced by
this function, see References.
}
\value{
List with components
\item{$Sigma.t.mat}{ Time covariance matrix}
\item{$Sigma.theta.mat}{Parameter covariance matrix}
}
\references{
      R. Olson and W. Chang (2013): Mathematical framework for a separable
Gaussian Process Emulator. Tech. Rep., available from \cr
\href{http://www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf}{www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf}.
}
\seealso{
\code{\link{predict.emul}}
}
\examples{
# Construct time AR(1) and square exponential separable parameter
# covariance matrix for a simple 1D parameter ensemble output example
data(Data.1D.par)
data(Data.1D.model)

Theta.mat.1D <- t(Data.1D.par$par)
t.vec.1D     <- Data.1D.model$t

# Use lag-1 time autocorrelation of 0.9, nugget and parameter covariance
# scaling factor of 100, and range of 3.
cov <- sep.cov(Theta.mat.1D, t.vec.1D, 0.9, 100, 3, 100)

# Find the covariance between second parameter setting (Theta=1) and
# ninth parameter setting (Theta=8)
cov.2.9 <- cov$Sigma.theta.mat[2,9]
cat("Covariance between Theta=1 and Theta=8 is:", cov.2.9, "\n")

# Plot the time covariance matrix [for fun]
# Note how covariance is high between similar years, but is low for markedly
# different years. Produces a pretty plot.
filled.contour(t.vec.1D, t.vec.1D, cov$Sigma.t.mat, xlab="Year", ylab="Year")
}
