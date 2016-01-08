\name{test.all}
\alias{test.all}
\title{
To test an emulator using leave-one-out cross-validation
}
\description{
To test an emulator using the leave-one-out cross validation analysis, whereby
each ensemble run is first excluded from an emulator, and the emulator is then used to predict at
the parameter settings of the excluded run. The process is repeated for
all runs within the ensemble. The function also makes a plot of emulator
predictions vs. actual model output, and a plot
of normalized prediction errors for each excluded run.
}
\usage{
test.all(final.emul, t.plot)
}
\arguments{
  \item{final.emul}{
Standard emulator object, that can be generated, for example, by
'emulator' function
}
  \item{t.plot}{
Time index of the emulator to analyze
}
}
\details{
For a perfect emulator, emulator
predictions vs. actual model output will fall exactly on a 1:1 line.
If a withheld run is at the corner of parameter space, prediction gives
a warning. Such runs are omitted from the plot.
}

\seealso{
\code{\link{test.csv}}
}
\examples{
# Cross-validate the 1D-parameter ensemble emulator at the first time index
data(emul.1D)
test.all(emul.1D, 1)
}
