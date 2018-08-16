mymessage <-
function(optresult) {

# Determine if optimization was successful and print a message #!+
    if (optresult$convergence == 0) {
    myparnames <- paste(names(optresult$par), sep=" ", collapse=" ")
    mypars     <- paste(format(optresult$par, digits=6, trim=TRUE,
                               scientific=FALSE), sep="", collapse=" ")
    message("Optimization SUCCESSFUL! Optimization message below:\n\n",
            optresult$message, '\n\n',
            "Final parameters\n", myparnames, '\n', mypars, '\n\n',
            optresult$iterations, " iterations were performed\n",
            "Final likelihood = ", format(-optresult$objective), '\n')
  } else {
    message("***ERROR*** Optimization FAILED. Optimization message below:\n\n",
            optresult$message, '\n\n',
            "If you see a \"Singular Convergence\" message, this indicates that there are probably too\n",
            "many parameters. A \"False convergence\" message may mean that the objective\n",
            "function gradient was computed incorrectly, or relative tolerance is too\n",
            "low, or that either the objective function or its gradient are discontinuous\n",
    "near the current iterate of the parameters. For more information on the\n",
    "optimization message see PORT documentation: Gay (1990), \"Usage summary for\n",
    "selected optimization routines\", available online at\n",
    "www.netlib.bell-labs.com/cm/cs/cstr/153.pdf\n")
  }

}
