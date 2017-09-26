make.parvec <-
function(emul, fix.betas) {

# Check whether betas are to be fixed #!+
if (fix.betas) emul$beta.vec=NULL

# Parameter vector #!+
parvec <- c(emul$rho, emul$kappa, emul$zeta, emul$beta.vec, emul$phi.vec)

# Names for the parameter vector #!+
names(parvec) <- c("rho", "kappa", "zeta", rep(c("beta", "phi"),
   c(length(emul$beta.vec), length(emul$phi.vec))))

# Output #!+
parvec
}
