x <- dust(head(mtcars))

# Functional Requirement 1 ------------------------------------------

test_that(
  "Correctly reassigns the appropriate elements of rotate_degree
   columns in the table part",
  {
    expect_equal(
      sprinkle_rotate_degree(x, cols = 2, rotate_degree = 3)[["body"]][["rotate_degree"]],
      rep(c("", 3, ""), times = c(6, 6, 6*9))
    )
  }
)

test_that(
  "Succeeds when called on a dust_list object",
  {
    expect_silent(
      dplyr::group_by(mtcars, am, vs) %>%
        dust(ungroup = FALSE) %>%
        sprinkle_rotate_degree(rotate_degree = 90)
    )
  }
)

# Functional Requirement 2 ------------------------------------------

test_that(
  "Cast an error if x is not a dust object",
  {
    expect_error(sprinkle_rotate_degree(mtcars))
  }
)

# Functional Requirement 3 ------------------------------------------

test_that(
  "Cast an error if rotate_degree is not a numeric(1)",
  {
    expect_error(sprinkle_rotate_degree(x, rotate_degree = "3"))
  }
)

test_that(
  "Cast an error if rotate_degree is not a numeric(1)",
  {
    expect_error(sprinkle_rotate_degree(x, rotate_degree = c(2, 3)))
  }
)

# Functional Requirement 4 ------------------------------------------

test_that(
  "Casts an error if part is not one of body, head, foot, or interfoot",
  {
    expect_error(
      sprinkle_rotate_degree(x, rotate_degree = 20, part = "not a part")
    )
  }
)

# Functional Requirement 6 ------------------------------------------

test_that(
  "Casts an error if fixed is not logical(1)",
  {
    expect_error(sprinkle_rotate_degree(x, rotate_degree = 20, fixed = "FALSE"))
  }
)

test_that(
  "Casts an error if fixed is not logical(1)",
  {
    expect_error(sprinkle_rotate_degree(x, rotate_degree = 20, fixed = c(TRUE, FALSE)))
  }
)

# Functional Requirement 7 ------------------------------------------

test_that(
  "Casts an error if recycle is not one of none, rows, or cols",
  {
    expect_error(sprinkle_rotate_degree(x, recycle = "not an option"))
  }
)

# Functional Requirement 8 -----------------------------------------

test_that(
  "Casts an error if recycle = 'none' and rotate_degree does not have length 1.",
  {
    expect_error(sprinkle_rotate_degree(x, rotate_degree = 1:3, recycle = "none"))
  }
)

test_that(
  "Passes when recycle != 'none' and rotate_degree does has length > 1.",
  {
    expect_silent(sprinkle_rotate_degree(x, rotate_degree = 1:3, recycle = "rows"))
  }
)