emul.lik <-
function(parvec, Y.mat, X.mat, t.vec, Theta.mat, n.par, p.par, fix.betas,
                     limits.lower=NULL, limits.upper=NULL, beta.vec=NULL) {


# PRELIMINARIES #!+
if ((fix.betas) && (is.null(beta.vec))) {
  stop("***ERROR*** Betas are fixed, yet the beta vector was not provided!\n")
}
if ( (!fix.betas) && (!is.null(beta.vec))) {
  warning('beta.vec argument is ignored')
}

# IMMEDIATELY EXIT AND RETURN INFINITI IF OUTSIDE LIMITS #!+
if (!is.null(limits.lower)) {
  if (any(parvec < limits.lower)) {
    llik <- -Inf
    return(llik)
  }
}
if (!is.null(limits.upper)) {
  if (any(parvec > limits.upper)) {
    llik <- -Inf
    return(llik)
  }
}

# EXTRACT PARAMETERS #!+
rho       <- parvec[1]
kappa     <- parvec[2]
zeta      <- parvec[3]
if (!fix.betas) {
   beta.ind  <- names(parvec) == "beta"
   beta.vec  <- parvec[beta.ind]
}
phi.ind   <- names(parvec) == "phi"
phi.vec   <- parvec[phi.ind]

# SOME CHECKS #!+
if (kappa == 0 && zeta == 0) stop("***ERROR*** Kappa and zeta can't be both 0!\n")

# SET-UP MATRICES #!+
Sigma.mats          <- sep.cov(Theta.mat, t.vec, rho, kappa, phi.vec, zeta)

Sigma.theta.Chol.mat <- chol(Sigma.mats$Sigma.theta.mat)
Sigma.theta.inv.mat  <- chol2inv(Sigma.theta.Chol.mat)
Sigma.t.Chol.mat     <- chol(Sigma.mats$Sigma.t.mat)
Sigma.t.inv.mat      <- chol2inv(Sigma.t.Chol.mat)
mu.vec               <- X.mat%*%as.matrix(beta.vec)
vec.C                <- Y.mat - mu.vec
C.mat                <- matrix(as.vector(vec.C), nrow=p.par, ncol=n.par)

# CALCULATE LIKELIHOOD #!+
# Determinants are calculated from the diagonal elements of the Cholesky factors
T1.mat              <- Sigma.theta.inv.mat%*%C.mat%*%Sigma.t.inv.mat
T2.mat              <- C.mat*T1.mat
Term1               <- -0.5*sum(T2.mat)
# Det10, Det20: ln(det)
Det10               <- 2*(sum(log(diag(Sigma.t.Chol.mat))))
Det1                <- p.par*Det10
Det20               <- 2*(sum(log(diag(Sigma.theta.Chol.mat))))
Det2                <- n.par*Det20
Term2               <- -0.5*(Det1+Det2)
Term3               <- -0.5*n.par*p.par*log(2*pi)
llik                 <- Term1 + Term2 + Term3

#!+
llik
}
