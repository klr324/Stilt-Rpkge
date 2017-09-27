emul.subset <-
function(emul, run.indices) {

# PRELIMINARIES #!+
# Test if any of the emulator indices are too high #!+
p.par <- emul$p
n.par <- emul$n
if (any(run.indices > p.par)) stop("***ERROR*** Run index/ices out of range")


#Create a vector of good run indices, as well as a corresponding matrix for
#Y.mat and X.mat #!+
runs.all  <- seq(1,p.par)
runs.gind <- !(runs.all %in% run.indices)      #Logical vector for good runs
runs.good <- runs.all[runs.gind]               #Good run indices
gind.mat  <- matrix(0, nrow=p.par, ncol=n.par)
gind.mat[runs.good,] <- 1
# Good indices for matrices (e.g., Y.mat, X.mat, etc.). Logical vector #!+
gind.vec  <- as.logical(as.vector(gind.mat))

#SUBSET EMULATOR  #!+
emul.new             <- emul
emul.new$Theta.mat   <- as.matrix(emul.new$Theta.mat[runs.good,])#!+
emul.new$Y.mat       <- as.matrix(emul.new$Y.mat[gind.vec,])
emul.new$X.mat       <- as.matrix(emul.new$X.mat[gind.vec,])
emul.new$p           <- length(runs.good)
emul.new$vecC        <- as.matrix(emul.new$vecC[gind.vec,])

# NEW SIGMA MATRICES
emul.new$Sigma.mats  <- sep.cov(emul.new$Theta.mat, emul.new$t.vec, emul.new$rho,
                                emul.new$kappa, emul.new$phi.vec, emul.new$zeta)
Sigma.theta.Chol.mat <- chol(emul.new$Sigma.mats$Sigma.theta.mat)
emul.new$Sigma.theta.inv.mat  <- chol2inv(Sigma.theta.Chol.mat)

# OUTPUT #!+
emul.new
}
