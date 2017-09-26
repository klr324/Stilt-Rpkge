test.csv <-
function(final.emul, num.test, plot.std, theseed=NULL, test.runind=NULL,
                     make.plot=TRUE) {


# PRELIMINARIES #!+
#===============

#!+
if (plot.std && !make.plot) warning("'plot.std' argument is ignored") #!+
if (any(diff(test.runind) <= 0)) { #!+
  stop("***ERROR*** test.runind needs to have monotonically increasing elements\n")
}

# SET SEED #!+
#==========
if (!is.null(theseed)) {
   set.seed(theseed) #!+
   if (!is.null(test.runind)) { #!+
     warning("'theseed' argument is ignored as test runs are specified")
   }
}

# LOAD EMULATOR #!+
#==============
n.par     <- final.emul$n
p.par     <- final.emul$p
t.vec     <- final.emul$t.vec
#!+
if (num.test > 0.5*p.par) stop("***ERROR*** Number of excluded runs is too high\n")
if (num.test < 1) stop("***ERROR*** Number of excluded runs needs to be 1 or more\n")

#SPECIFY RUN NUMBERS TO WITHHOLD #!+
#=================================
# If no test.runind is provided
if (is.null(test.runind)) {
   seq.samp    <- seq(1, p.par)  #!+
   test.runind <- sort(sample(seq.samp, num.test)) #!+
} else { #If test.runind is provided
   #!+
   if (any(test.runind < 1) || any(test.runind > p.par)) {
     stop("***ERROR***: Illegal run numbers")
   }
   stopifnot(length(test.runind) == num.test) #!+
}


# WITHHOLD TEST RUNS FROM THE EMULATOR AND THE MODEL #!+
#=====================================
# Withhold runs from the emulator #!+
mysub.emul     <- emul.subset(final.emul, test.runind)


# Withhold runs from model, and from the parameter matrix #!+
# Full model output matrix [row, col] = [run index, time index]
# Corresponding times for cols is final.out$t.vec
# This command stacks the matrix by columns
model.out      <- matrix(as.vector(final.emul$Y.mat), nrow=p.par, ncol=n.par) #!+
# model.out.test => Model output at test parameter settings [row,col] =
# [test run index, time index]
# Theta.mat.sub  => Matrix of prediction parameter settings
# #!+
if (num.test == 1) {
   model.out.test <- t(as.matrix(model.out[test.runind,]))
   Theta.mat.sub  <- t(as.matrix(final.emul$Theta.mat[test.runind,]))
} else {
   model.out.test <- model.out[test.runind,]
   Theta.mat.sub  <- as.matrix(final.emul$Theta.mat[test.runind,]) #!+
}


# PREDICT AT TEST POINTS #!+
#=======================
# PRELIMINARIES #!+
# Modeled emulator predictions and standard deviations [row,col]
# = [prediction run index, time]. Corresponding time vector for cols is
# t.vec
emul.out.test <- matrix(NA, nrow=num.test, ncol=n.par)
emul.std.test <- matrix(NA, nrow=num.test, ncol=n.par)
predict.ok    <- vector(length=num.test)

# PREDICT AT EACH TEST POINT #!+
for (test.run in 1:num.test) {
   message("Predicting for run number: ", toString(test.runind[test.run]))
   out <- try(emul.predict(mysub.emul, Theta.mat.sub[test.run,]), silent=TRUE)#!+
   # Prediction is OK #!+
   if (is.list(out)) {
     emul.out.test[test.run,] <- out$mean
     emul.std.test[test.run,] <- sqrt(diag(out$covariance))
     predict.ok[test.run]     <- TRUE
   # Prediction gives error #!+
   } else {
     message("  ...Prediction error. Likely because prediction parameters are out of bounds")
     emul.out.test[test.run,] <- NA
     emul.std.test[test.run,] <- NA
     predict.ok[test.run]     <- FALSE
   }
}

#ERROR EXCEPTION #!+
if (any(!predict.ok)) {
  message("NOTE: ", toString(sum(!predict.ok)), " prediction points were omitted\n")
}

# COVERAGE
#===========
emul.upper <- emul.out.test + 1.96*emul.std.test #[row, col] = [test run, time]
emul.lower <- emul.out.test - 1.96*emul.std.test #[row, col] = [test run, time]
# Total data points with finite predictions
totalfinitepoints     <- n.par*sum(predict.ok)
totalinrange <- 0
for (test.run in 1:num.test) {
    if (is.finite(emul.out.test[test.run,1])) {
      inrange <- (model.out.test[test.run,] > emul.lower[test.run,]) &
                 (model.out.test[test.run,] < emul.upper[test.run,])
      totalinrange <- totalinrange + sum(inrange)
    }
}
coverage <- totalinrange/totalfinitepoints

# PLOT EMULATOR AND MODEL OUTPUT, IF NEEDED #!+
#===================================
if (make.plot) {

   # Plot set-up #!+
   plot.default(NA, xlim=c(min(t.vec), max(t.vec)), ylim=c(min(model.out),
             max(model.out)), xlab="Time", ylab="Output", cex.axis=1,
             cex.lab=1)


   # Plot emulator predictions #!+
   all.predict <- seq(1:num.test)
   for (test.run in all.predict[predict.ok]) {
         lines(t.vec, model.out.test[test.run,], col="orange", lwd=3)
         lines(t.vec, emul.out.test[test.run,], col="brown")
         if (plot.std) {
            lines(t.vec, emul.out.test[test.run,] - emul.std.test[test.run,], col="brown",
              lty=2)
            lines(t.vec, emul.out.test[test.run,] + emul.std.test[test.run,], col="brown",
              lty=2)
         }
   }

}

# OUTPUT
#========
test.csv.out <- list(model.out.test=model.out.test, emul.out.test=emul.out.test,
                     emul.std.test=emul.std.test, coverage=coverage)
test.csv.out
}
