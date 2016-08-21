
setClass(
  Class="Trajectories",
  representation = representation(
    times = "numeric",
    traj  = "matrix"
  ),
  prototype = prototype(
  	times = 1,
  	traj = matrix(0)
  ),
  validity = function(object) {
  	cat("~~~ Trajectories: inspector ~~~\n")
  	if (length(object@times) != ncol(object@traj)) {
  		stop("[Trajectories: validation] the number of temporal measurements is not correct")
  	}
  	return(TRUE)
  }
)

setMethod(
  f="plot",
  signature = "Trajectories",
  definition = function(x, y, ...) {
    matplot(x@times,t(x@traj),xaxt="n",type="l",ylab= "",xlab="", pch=1) 
    axis(1,at=x@times)
  }
)

setMethod("print",
          "Trajectories",
          function(x,...) {
            cat("*** Class Trajectories, method Print *** \n")
            cat("* Times ="); print (x@times)
            cat("* Traj = \n"); print (x@traj)
            cat("******* End Print (trajectories) ******* \n")
          }
)

setMethod("show", 
		  "Trajectories",
		  function(object) {
			cat("*** Class Trajectories, method Show *** \n")
			cat("* Times ="); print(object@times)
			nrowShow <- min(10,nrow(object@traj))
			ncolShow <- min(10,ncol(object@traj))
			cat("* Traj (limited to a matrix 10x10) = \n")
			if(length(object@traj)!=0){
				print(formatC(object@traj[1:nrowShow,1:ncolShow]),quote=FALSE)
			} else {}
			cat("******* End Show (trajectories) ******* \n")
		  }
)

setGeneric(
	name = "countMissing",
	def=function(object) { standardGeneric("countMissing") }
)

setMethod(
	f="countMissing",
	signature="Trajectories",
	definition=function(object){
		return(sum(is.na(object@traj)))
	}
)

setMethod(
  f="initialize",
  signature = "Trajectories",
  definition = function(.Object, times, traj) {
    cat("~~~ Trajectories: initialize ~~~")
    rownames(traj) <- paste("I", 1:nrow(traj), sep="")
    .Object@traj <- traj
    .Object@times <- times
    validObject(.Object)
    return(.Object)
  }
)

trajectories <- function(times, traj) {
  cat("~~~~~ Trajectories: constructor ~~~~~\n")
  new(Class="Trajectories", times=times, traj=traj)
}


# accessors

setGeneric("getTimes", 
	function(object){ standardGeneric("getTimes") }
)

setMethod("getTimes", 
	      "Trajectories",
	function(object) {
		return(object@times)
	}
)

setGeneric("getTraj", 
	function(object){ standardGeneric("getTraj") }
)

setMethod("getTraj", 
	      "Trajectories",
	function(object) {
		return(object@traj)
	}
)

setGeneric("getTrajInclusion", 
	function(object){ standardGeneric("getTrajInclusion") }
)

setMethod("getTrajInclusion", 
	      "Trajectories",
	function(object) {
		return(object@traj[,1])
	}
)

setGeneric("setTimes<-", function(object, value) { standardGeneric("setTimes<-") })
setReplaceMethod(
	f="setTimes",
	signature="Trajectories",
	definition=function(object, value) {
		object@times <- value
		validObject(object)
		return(object)
	}
)

setMethod(
  f="[",
  signature = "Trajectories",
  definition=function(x,i,j,drop) {
    if(i=="times") {return(x@times)} else {}
    if(j=="traj") { return(x@traj)} else {}
  }
)

setReplaceMethod(
  f="[",
  signature="Trajectories",
  definition=function(x,i,j,value){
    if(i=="times") {x@times <- value} else {}
    if(j=="traj") { x@traj <- value} else {}
    validObject(x)
    return(x)
  }
)
# tests
trajCochin <- new(
  Class = "Trajectories",
  times = c(1,3,4,5),
  traj = rbind(
    c(15, 15.1, 15.2, 15.2),
    c(16, 15.9, 16, 16.4),
    c(15.2, NA, 15.3, 15.3),
    c(15.7, 15.6, 15.8, 16)
  )
)

trajStAnne <- new(
  Class="Trajectories",
  times = c(1:10, (6:16)*2),
  traj=rbind(
    matrix (seq (16,19, length=21), ncol=21, nrow=50, byrow=TRUE),
    matrix (seq (15.8, 18, length=21), ncol=21, nrow=30, byrow=TRUE) 
    )+  rnorm (21*80,0,0.2)
)

countMissing(trajCochin)

new(Class="Trajectories",times=c(1,2,4,8),traj=matrix(1:8,nrow=2))
trajCochin
trajCochin["times"]

