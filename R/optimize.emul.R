optimize.emul <-
function(init.emul, fix.betas, twice=FALSE, myrel.tol=NULL) {

message("Optimizing the emulator...")

#====================================================================
# SET-UP THE OPTIMIZATION #!+
#====================================================================

# Construct parameter vector, etc #!+
init.pars  <- make.parvec(init.emul, fix.betas)
n.par      <- init.emul$n
p.par      <- init.emul$p
num.pars   <- length(init.pars)

# Construct reasonable parameter ranges for optimization #!+
myranges   <- make.ranges(init.emul, fix.betas)

# Construct reasonable scale vector, for optimization #!+
myabsranges<- list(all.lower=abs(myranges$all.lower),
                   all.upper=abs(myranges$all.upper))
myabsmax   <- pmax(myabsranges$all.lower, myabsranges$all.upper)
myscales   <- 1/myabsmax


# Optimization tolerances #!+
# If not given, the relative tolerance is specified depending on the
# number of parameters to be optimized 'numpars'
if (is.null(myrel.tol)) {
     if (num.pars <= 11)                   myrel.tol <- 1E-10
     if (num.pars >= 12 && num.pars <= 13) myrel.tol <- 1E-5
     if (num.pars >= 14)                   myrel.tol <- 0.1
}
message("\nRelative tolerance to be used in optimization: ",
            format(myrel.tol), "\n")


# Check that the initial kappa and zeta are within the ranges #w
if (init.emul$kappa < myranges$all.lower[2]) { #!+
  stop('***ERROR*** Initial kappa is too low, please adjust!')
}
if (init.emul$kappa > myranges$all.upper[2]) { #w
  stop('***ERROR*** Initial kappa is too high, please adjust!')
}
if (init.emul$zeta < myranges$all.lower[3]) { #!+
  stop('***ERROR*** Initial nugget is too low, please adjust!')
}
if (init.emul$zeta > myranges$all.upper[3]) { #w
  stop('***ERROR*** Initial nugget is too high, please adjust!')
}

# Beta vector -- to pass to the optimization #!+
if (fix.betas) {
    beta.vec    <- init.emul$beta.vec
    beta.vec.fm <- paste(format(beta.vec, digits=6, trim=TRUE,
                         scientific=FALSE), sep="", collapse=" ")
    message("Option 'fix.betas': during optimization beta parameters are going to be\n",
    "fixed at the following values:\n", beta.vec.fm)
} else {
  beta.vec <- NULL
}



#===========================================================================
# PERFORM THE OPTIMIZATION, TWICE IF NECESSARY #!+
#===========================================================================

# FIRST OPTIMIZATION #!+
#==================
message('\n------------------------------------\n',
        'Starting parameter optimization...\n',
        '-------------------------------------')

# Perform first optimization #w
# NOTE: the optimization preserves the 'names' attribute
final.out1 <- nlminb(start=init.pars, objective=emul.minus.lik, gradient=NULL,
                     hessian=NULL, Y.mat=init.emul$Y.mat,
                     X.mat=init.emul$X.mat, t.vec=init.emul$t.vec,
                     Theta.mat=init.emul$Theta.mat, n.par=n.par, p.par=p.par,
                     fix.betas=fix.betas, limits.lower=myranges$all.lower,
                     limits.upper=myranges$all.upper, beta.vec=beta.vec,
                     scale=myscales, control=list(trace=TRUE, eval.max=10000000,
                     iter.max=5000000, rel.tol=myrel.tol),
                     lower=myranges$all.lower, upper=myranges$all.upper)

# Provide output message #!+
mymessage(final.out1)




# SECOND OPTIMIZATION #!+
#=========================================
if (twice) {

    # User message #!+
    message('\n------------------------------------\n',
            'Starting second parameter optimization...\n',
            '-------------------------------------')

    # Generate starting vector #!+
    init.pars2 <- vector(length=num.pars)
    for (par.index in 1:num.pars) {
          init.pars2[par.index] <- runif(1, min=myranges$all.lower[par.index],
                      max = myranges$all.upper[par.index])
    }
    names(init.pars2) <- names(init.pars)
    init.pars2.fm     <- paste(format(init.pars2, digits=6, trim=TRUE,
                         scientific=FALSE), sep="", collapse=" ")
    message("Random starting vector for second optimization is\n",
        init.pars2.fm)

    # Perform second optimization #!+
    final.out2 <- nlminb(start=init.pars2, objective=emul.minus.lik, gradient=NULL,
                     hessian=NULL, Y.mat=init.emul$Y.mat,
                     X.mat=init.emul$X.mat, t.vec=init.emul$t.vec,
                     Theta.mat=init.emul$Theta.mat, n.par=n.par, p.par=p.par,
                     fix.betas=fix.betas, limits.lower=myranges$all.lower,
                     limits.upper=myranges$all.upper, beta.vec=beta.vec,
                     scale=myscales, control=list(trace=TRUE, eval.max=10000000,
                     iter.max=5000000, rel.tol=myrel.tol),
                     lower=myranges$all.lower, upper=myranges$all.upper)

    # Provide output message #w
    mymessage(final.out2)


} else {
    # If only one optimization is performed #!+
    message("CAUTION! The optimization might only find a local minimum.")
}



# SELECT THE BEST OPTIMIZATION RESULT #!+
#====================================
# Check how many optimizations were performed #!+
if (!twice) { #If only one optimization #!+

  #!+
  if (final.out1$convergence == 0) {
     best.out <- final.out1
  } else {
     stop("Exiting program. Please adjust program settings and re-try!\n")
  }

} else { #If two optimizations #!+

  #Program exists if any of the optimization codes are not either 0 or 1 #!+
  myconv <- c(final.out1$convergence, final.out2$convergence)
  if (any(myconv <0) || any(myconv >1)) stop("Illegal optimization message!\n")

  #Check how many optimizations were successful and select the best emulator. #!+
  if (sum(myconv) == 2) { #None successfull #!+

    stop("Exiting program. Please adjust program settings and re-try!\n")

  } else if (sum(myconv) == 1) { #Only one successful #!+

    #!+
    if (final.out1$convergence == 0) {
      best.out <- final.out1
    } else {
      best.out <- final.out2
    }

  } else if (sum(myconv) == 0) { #Both successfull #!+

    #Check how different the two optimization results are #!+
    reldiff <- final.out1$par/final.out2$par

    if (any(reldiff < 0.75) || any(reldiff > 1.25)) {
      message("CAUTION!! Considerable differences between the results of two optimizations\n")
    }

    #Select the best emulator #!+

    if (-final.out1$objective > -final.out2$objective) {
      message("Selecting first optimization results for final emulator")
      best.out <- final.out1
    } else {
      message("Selecting second optimization results for final emulator")
      best.out <- final.out2
    }

  } else { #!+
    message("Illegal optimization convergence message. This error should never happen.")
  }#End of the check of how many optimizations were successfull

}#End the check of how many optimizations were performed



#============================================================================
# CONSTRUCT AND OUTPUT THE OPTIMIZED EMULATOR #!+
#============================================================================


# CONSTRUCT EMULATOR FROM FINAL PARAMETERS #!+
#==============================================
final.pars <- best.out$par

final.emul <- make.emulator(final.pars, init.emul$Theta.mat, init.emul$t.vec,
                 init.emul$Y.mat, init.emul$X.mat, init.emul$par.reg,
                 init.emul$time.reg, beta.vec)

#OUTPUT #!+
#==========
final.emul
}
