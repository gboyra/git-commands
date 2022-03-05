#' Reverse
#' 
#' Reverses a vector if it has at least one element
#'
#' @param x 
#'
#' @return a vector
#' @export
#'
#' @examples
#' reverse(1:10)
reverse <- function(x) {
  if (length(x) > 0) x[length(x):1] else x
}