# stilt

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/stilt)](https://cran.r-project.org/web/packages/stilt/index.html)

**stilt** is an open-source R library for Separable Gaussian Process Interpolation, a type of statistical emulation.

The package, which is available on [CRAN](https://cran.r-project.org/web/packages/stilt/index.html), comprises a set of R functions to build and use an interpolator (emulator) for time series or 1D regularly spaced data in multidimensional space. The standard usage is for interpolating time-resolved computer model output between model parameter settings. It can also be used for interpolating multivariate data (e.g., oceanographic time-series data, etc.) in space. There are functions to test the emulator using cross-validation, and to produce contour plots over 2D slices in model input parameter (or physical) space.

## Installation

To install the stable version from CRAN, simply run the following R code:

```R
install.packages("stilt")
library(stilt)
```

To install the latest development version directly from Github, run **devtools**:

```R
install.packages("devtools") ##if not already installed
library(devtools)
devtools::install_github("scrim-network/Stilt-Rpkge")
library(stilt)
```

## Getting Started

To learn more we highly recommend you check out the [reference manual](https://cran.r-project.org/web/packages/stilt/stilt.pdf). The reference manual explains each stilt function/dataset in-depth and includes annotated examples.

Additionally we recommend you check out the technical report. This report describes the statistical background and equations for the separable emulator.  
[R. Olson and W. Chang (2013):_Mathematical framework for a separable Gaussian Process Emulator, Technical Report](http://www.scrimhub.org/resources/stilt/Olson_and_Chang_2013_Stilt_Emulator_Technical_Report.pdf)

## Development notes

**stilt** depends on R(≥2.15.1), fields

## Authors

Roman Olson, Won Chang, Klaus Keller, and Murali Haran

## Maintainer and Contact

Kelsey Ruckert: <datamgmt@scrim.psu.edu>

## License

**stilt** is licensed under the GNU General Public License, version 3 or later.

_This work was supported by the National Science Foundation through the Network for Sustainable Climate Risk Management (SCRiM) under NSF cooperative agreement GEO-1240507._
