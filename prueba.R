center <- function(x) {
  x - me(x)
}

rescale <- function(x) {
  x/sd(x)
}

standardize <- function(x) {
  rescale(center(x))
}

standardize(1:10)

