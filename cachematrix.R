## How to make R "object oriented" (kind of)
## create a matrix with ability to cache its inverse

## create an "object" with two properties (the matrix and its inverse) and four methods

makeCacheMatrix <- function(x = matrix()) {

	## This is needed to create cache variable in the current scope
	inv <- NULL
	
	## Method to change the original matrix
	set <- function(y) {
		x <<- y
		## invalidate the cached inverse when matrix changed
		inv <<- NULL
		}
	
	## Metrod to retun the matrix
	get <- function() x
	
	## Now, that is what the assingment required, but making the setinv function public seems
	## not the right way of doing it - anybody can then set the "cached inverse" to whatever
	## they want. IMHO it would make more sense to have getinv do what cacheSolve does, and drop 
	## setinv and cacheSolve completely...
	setinv <- function(y) inv <<- y
	
	## method to return the cached inverse, supposed to be called only by cacheSolve
	getinv <- function() inv
	
	list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}

## Return inverse of a matrix created by makeCacheMatrix, using cached result
## (if it exists). Write result to chache. 
## Now, there seems to be a bit of inconsistency here... The function uses ... syntax to pass extra
## parameters to solve(). The result is, however, cached and returned later regardless of those parameters,
## thus it is possible that the cached result is not what has been actually requested. Forget it for now...

cacheSolve <- function(x, ...) {

	inv <- x$getinv()
	if (!is.null(inv)) {
        ## Return cached inverse
		return(inv)
		}
	## else solve the matrix, cache the result and return it
	inv <- solve(x$get(),...)
	x$setinv(inv)
	inv
}
