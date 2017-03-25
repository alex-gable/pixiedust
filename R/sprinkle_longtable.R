#' @name sprinkle_longtable
#' @title Change the Longtable Property in a Dust Table
#' 
#' @description The LaTeX \code{longtable} package allows for long tables
#' to be broken into multiple parts to be displayed on separate pages. 
#' \code{pixiedust} will mimic this behavior for other output types.
#'   
#' @param x An object of class \code{dust}
#' @param longtable Either a \code{logical(1)} or an \code{numeric(1)} 
#'   integer-like value.  See Details.
#' @param ... Additional arguments to pass to other methods. Currently ignored.
#'
#' @details When \code{longtable = TRUE}, LaTeX tables will be divided 
#'   according to the LaTeX document settings.  In other table outputs, the 
#'   default is to use 25 rows per table.
#'   
#'   When \code{longtable} is an integer (or integer-like) value, the table 
#'   is divided into that many rows per section. This applies to all output.
#'   
#' @author Benjamin Nutter
#' 
#' @seealso \code{\link{dust}}, \code{\link{sprinkle}}
#' 
#' @section Functional Requirements:
#' \enumerate{
#'  \item Change the \code{longtable} attribute of the \code{dust} object.
#'  \item Cast an error if \code{x} is not a \code{dust} object.
#'  \item Cast an error if \code{longtable} is logical and has length not equal 
#'    to 1.
#'  \item when \code{longtable} is not logical, cast an error if 
#'    it is not-integerish and has length not equal to 1.
#' }
#' 
#' @export

sprinkle_longtable <- function(x, 
                               longtable = getOption("pixie_longtable", FALSE), 
                               ...)
{
  UseMethod("sprinkle_longtable")
}

#' @rdname sprinkle_longtable
#' @export

sprinkle_longtable.default <- function(x, 
                                       longtable = getOption("pixie_longtable", FALSE), 
                                       ...)
{
  coll <- checkmate::makeAssertCollection()
  
  checkmate::assert_class(x = x,
                          classes = "dust",
                          add = coll)
  
  if (is.logical(longtable))
  {
    checkmate::assert_logical(x = longtable,
                              len = 1,
                              add = coll)
  }
  else
  {
    checkmate::assert_integerish(x = longtable,
                                 len = 1, 
                                 add = coll)
  }
  
  checkmate::reportAssertions(coll)
  
  x[["longtable"]] <- longtable
  
  x
}

#' @rdname sprinkle_longtable
#' @export

sprinkle_longtable.dust_list <- function(x, 
                                         longtable = getOption("pixie_longtable", FALSE),
                                         ...)
{
  lapply(x,
         sprinkle_longtable.default,
         longtable)
}