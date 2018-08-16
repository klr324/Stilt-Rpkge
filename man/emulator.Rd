\name{emulator}
\alias{emulator}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to fit an emulator to ensemble model output
}
\description{
Fits a Gaussian Process emulator to regularly spaced time-series (or 1D spatial)
model output. This emulator can later be used to interpolate the model
output across model parameter settings. The emulator is fit by
maximizing the emulator likelihood using a PORT local optimization
routine. The emulator has a flexible structure which can be chosen by
the user (see Details). 
}
\usage{
emulator(mpars, moutput, par.reg, time.reg, kappa0, zeta0, myrel.tol =
NULL, twice = FALSE, fix.betas = TRUE)
}
\arguments{
  \item{mpars}{
    Model ensemble parameter settings. A list with components:
    \describe{
      \item{$par}{Matrix of ensemble parameter settings. [row, column] =
	[parameter index, run index]. Columns should correspond to
	columns of the model output matrix \code{moutput$out}.}
      \item{$parnames}{Parameter names for rows of $par (character vector)}
      \item{$parunits}{Units for parameters in rows of $par (character vector)}
     } 
}
  \item{moutput}{
    Model output. A list with components:
    \describe{
      \item{$t}{ Time vector for rows of $out (vector)}
      \item{$tunits}{Time units (character)}
      \item{$out}{ Model output matrix [row, col] = [time, run
	index]. The run indices should match with the \code{mpars$par} argument.} 
      \item{$outname}{ name (character)}
      \item{$outunits}{ units (character}
   }
}
  \item{par.reg}{ Logical vector specifying which parameters to include into the
regression matrix. Elements refer to rows of \code{mpars$par}.
Note that if nothing is included into the regression matrix, the mean is
still optimized.
}
  \item{time.reg}{Logical specifying whether to include time into the
    regression matrix.
}
  \item{kappa0}{ Initial guess for the parameter covariance scaling factor. Larger values
lead to higher parameter covariance.
}
  \item{zeta0}{Initial guess for the nugget.
}
  \item{myrel.tol}{Relative tolerance for optimization. If you want to
    use the defaults, assign it to NULL. The optimization stops if it thinks the true likelihood is
	    within this fraction of current likelihood. The higher the
	    number the sooner the optimization stops, but the emulator
	    is 'worse'.
}
  \item{twice}{
 Logical. If \code{TRUE}, the optimization is done twice with different
initial parameter values, and then the best of the two is chosen as
final emulator. Default is \code{FALSE}.
}
  \item{fix.betas}{
Logical. If \code{TRUE}, beta regression coefficients are fixed, and if \code{FALSE},
they are estimated. Default is \code{TRUE}.
}
}
\details{
The emulator parameters are optimized using a local optimization
method, to within the specified relative tolerance. The optimization maximizes
emulator likelihood. Optionally, if \code{twice=TRUE}, the optimization is done twice with
different initial parameter settings, and the emulator with the highest
likelihood is selected. Depending on the value of \code{fix.betas}, the regression
beta parameters can either be fixed at their multiple linear regression
estimates, or estimated together with other
emulator parameters. Mean structure is flexible, and user can choose which
parameter and time dimensions to use as regressors via the
\code{time.reg} and \code{par.reg} parameters
}
\section{Note}{
  Evaluation of this function (especially for large datasets and many parameters) might take a long time.
  }
\section{Limitations and Caveats}{
  \enumerate{
    \item The emulator will not work well for 'jagged' model response
    surfaces (high nugget)
    \item The emulator is restricted to output at regular intervals in
    time and space
    \item The code has not been tested under conditions of extreme high
    / extreme low input parameter range, output time(space) coordinates
    range, and output range (an example would be model output ranging
    from -1E20 to 1E20, etc.). In such cases it is recommended to
    re-scale the time(space) coordinates vector, the input parameters,
    and/or the model output.
    \item The emulator will not work on scalar model output -- it
    requires multivariate data
    \item The emulator assumes a separable covariance function, and
    stationarity of the covariance part of the Gaussian process.
    \item The optimization of the emulator parameters degrades
    dramatically (and increases in time) as a function of number of
    free parameters. Hence, the emulator might be of limited use for
    large parameter ensembles
    \item The emulator authors are not responsible for any code errors
    and/or bugs
    }
}
\value{
Emulator returns an object of \code{\link{class}} "emul" and is a list with components 
(see also Reference in the References Section).
\item{$Theta.mat}{Theta matrix. [row, col] = [run number, parameter
  number]}
\item{$t.vec}{Time vector}
\item{$Y.mat}{Data matrix Y}
\item{$X.mat}{Regression matrix}
\item{$beta.vec}{A vector of regression parameters}
\item{$kappa}{ Parameter covariance scaling factor}
\item{$phi.vec}{A vector of range parameters phi}
\item{$zeta}{Nugget}
\item{$n}{Length of time dimension}
\item{$rho}{Time AR(1) parameter}
\item{$p}{Number of model runs in the ensemble}
\item{$vecC}{Data matrix Y minus the mean vector}
\item{$par.reg}{ Logical vector specifying which parameters to include
  in the regression matrix}
\item{$time.reg}{Logical, specifies whether to include time into the
  regression matrix}
\item{$Sigma.mats}{List of two precomputed matrices that may be useful:
  \code{$Sigma.t.mat} and \code{$Sigma.theta.mat} (see References)}
\item{$Sigma.theta.inv.mat}{Inverse of \code{$Sigma.mats$Sigma.theta.mat}}
}
\references{
R. Olson and W. Chang (2013): Mathematical framework for a separable
Gaussian Process Emulator. Tech. Rep., available from \cr
\href{http://www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf}{www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf}.
}
\note{
If the final emulator performs poorly, try adjusting the
settings, especially the initial \code{kappa0} and \code{zeta0} values.
}
\seealso{
\code{\link{emul.lik}}, \code{\link{optimize.emul}}
}
\examples{
# Fit an emulator to the example 1D parameter ensemble data
# Do not use any covariates, use standard settings
data(Data.1D.model)
data(Data.1D.par)
emul.1D <- emulator(Data.1D.par, Data.1D.model, FALSE, FALSE, 1, 1)

# Take a look at the range and regression parameters
cat("Range parameters are:", emul.1D$phi.vec, "\n")
cat("Regression parameters are:", emul.1D$beta.vec, "\n")

# Predict using the emulator at Theta*=3
pred.1D <- predict(emul.1D, 3)

# Plot the prediction
plot(emul.1D$t.vec, pred.1D$mean, xlab="Year", ylab="Sample Output")


\dontrun{
    # Fit an emulator to the UVic ESCM 3-parameter ensemble temperature
    # output Use time and aerosol scaling covariates (parameter 3), run
    # the optimization twice with relative tolerance of 0.1, keep
    # regression parameters at their multiple linear regression
    # estimates data(Data.UVic.model) data(Data.UVic.par) UVic.emul <-
    # emulator(mpars=Data.UVic.par, moutput=Data.UVic.model,
    # par.reg=c(FALSE, FALSE, TRUE), time.reg=TRUE, kappa0=1, zeta0=1,
    # myrel.tol=0.1, twice=TRUE, fix.betas=TRUE)
   }
}
