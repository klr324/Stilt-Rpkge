emulator <-
function(mpars, moutput, par.reg, time.reg, kappa0, zeta0,
                  myrel.tol=NULL, twice=FALSE, fix.betas=TRUE)  {

    # PRELIMINARIES #!+
    #===========================================================================
    # Check that par.reg has the correct number of elements #!+
    m.par      <- dim(mpars$par)[1] #!+
    if (length(par.reg) != m.par) {
       stop("***ERROR***: par.reg has wrong number of elements")
    }


    # INITIALIZE EMULATOR #!+
    #===============================================================================
    message("Initializing the emulator...")
    # Initialize emulator. Initial emulator beta parameters ($beta.vec) are estimated
    # using multiple linear regression.
    init.emul <- initialize.emul(mpars, moutput, par.reg, time.reg, kappa0, zeta0) #!+
    beta.vec.fm <- paste(format(init.emul$beta.vec, digits=6, trim=TRUE,
                         scientific=FALSE), sep="", collapse=" ")
    message("\nInitial regression parameters:\n", beta.vec.fm,"\n")

    # Evaluate initial emulator likelihood #!+
    init.pars <- make.parvec(init.emul, fix.betas) #!+

    n.par     <- length(init.emul$t.vec)
    p.par     <- dim(init.emul$Theta.mat)[1]
    if (fix.betas) { #!+
      beta.vec <- init.emul$beta.vec
    } else {
      beta.vec <- NULL
    }

    init.lik  <- emul.lik(init.pars, init.emul$Y.mat, init.emul$X.mat, init.emul$t.vec,
                          init.emul$Theta.mat, n.par, p.par, fix.betas, NULL, NULL,
                          beta.vec) #!+
    message("Initial emulator likelihood is: ", format(init.lik), "\n")


    # OPTIMIZE EMULATOR #!+
    #===============================================================================
    final.emul <- optimize.emul(init.emul, fix.betas, twice, myrel.tol ) #!+
    class(final.emul) <- append(class(final.emul),"emul") # set emul class

    # OUTPUT #!+
    #=========
    final.emul
}
