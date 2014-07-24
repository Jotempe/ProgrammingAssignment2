## Test procedure for the solution of programming assignment 2

source("cachematrix.R")

message("Create a large matrix")
a <- matrix(0,1000,1000)
for (i in 1:1000) a[i,i] <- 1
for (i in 1:999) a[i,i+1] <- -1
for (i in 1:998) a[i,i+2] <- 1
b <- makeCacheMatrix(a)

message("First call to cacheSolve - do actual inversion")
print(system.time(cacheSolve(b)))

message("Second call to cacheSolve - result from cache")
print(system.time(cacheSolve(b)))

message("Modify the matrix")
a[1,1000] <- 1
b$set(a)

message("Call to cacheSolve on modified matrix - inverse is recalculated")
print(system.time(cacheSolve(b)))
