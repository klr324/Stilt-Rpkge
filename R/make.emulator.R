make.emulator <-
function(parvec, Theta.mat, t.vec, Y.mat, X.mat, par.reg, time.reg,
                          beta.vec=NULL) {

# Main matrices #!+
emul           <- list()
emul$Theta.mat <- Theta.mat
emul$t.vec     <- t.vec
emul$Y.mat     <- Y.mat
emul$X.mat     <- X.mat

# Beta parameters #!+
beta.ind        <- names(parvec) == "beta"
if (!is.null(beta.vec)) {
  emul$beta.vec <- unname(beta.vec)
  if (any(beta.ind)) message("CAUTION! Beta parameters in 'parvec' are ignored")
} else {
  emul$beta.vec <- unname(parvec[beta.ind])
}

# Statistical parameters and dimensions #!+
emul$kappa     <- unname(parvec[2])
phi.ind        <- names(parvec) == "phi"
emul$phi.vec   <- unname(parvec[phi.ind])
emul$zeta      <- unname(parvec[3])
emul$n         <- length(t.vec)
emul$rho       <- unname(parvec[1])
emul$p         <- dim(Theta.mat)[1]

# Mean vector and vecC #!+
mu.vec         <- X.mat%*%as.matrix(emul$beta.vec)
emul$vecC      <- Y.mat - mu.vec

# Logicals #!+
emul$par.reg   <- par.reg
emul$time.reg  <- time.reg

# Covariance matrices necessary for prediction
emul$Sigma.mats      <- sep.cov(Theta.mat, t.vec, emul$rho, emul$kappa,
                               emul$phi.vec, emul$zeta)
Sigma.theta.Chol.mat <- chol(emul$Sigma.mats$Sigma.theta.mat)
emul$Sigma.theta.inv.mat  <- chol2inv(Sigma.theta.Chol.mat)

# Output #!+
emul
}
