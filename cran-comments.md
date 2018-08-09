## Test environments
* local system: x86_64, apple-darwin13.4.0 | R 3.3.2
* system: x86_64, redhat-linux-gnu | R 3.5.0 
* system: x86_64, w64-mingw32 | R 3.3.1

## R CMD check results
There were 0 ERRORs, 1 WARNINGs, and 1 NOTEs.

WARNING on Windows:
checking whether package 'stilt' can be installed ... WARNING
Found the following significant warnings:
  Warning: failed to assign RegisteredNativeSymbol for toeplitz to toeplitz since toeplitz is already defined in the 'spam' namespace  

NOTE:
* checking CRAN incoming feasibility ... NOTE
Maintainer: ‘Kelsey Ruckert <datamgmt@scrim.psu.edu>’

## Downstream dependencies
I have run R CMD check on downstream dependencies of stilt (fields version 9.0).

There were 0 ERRORs or WARNINGs found.
