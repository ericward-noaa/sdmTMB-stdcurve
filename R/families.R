# modified from glmmTMB
# extra stuff for Effects package, class, etc.
add_to_family <- function(x) {
  # x <- c(x, list(link = link), make.link(link))
  # Effect.default/glm.fit
  if (is.null(x$aic)) {
    x <- c(x, list(aic = function(...) NA_real_))
  }
  if (is.null(x$initialize)) {
    x <- c(x, list(initialize = expression({
      mustart <- y + 0.1
    })))
  }
  if (is.null(x$dev.resids)) {
    # can't return NA, glm.fit is unhappy
    x <- c(x, list(dev.resids = function(y, mu, wt) {
      rep(0, length(y))
    }))
  }
  class(x) <- "family"
  x
}

#' Additional families
#'
#' Additional families compatible with [sdmTMB()].
#'
#' @param link Link.
#' @export
#' @rdname families
#' @name Families
#'
#' @return
#' A list with elements common to standard R family objects including `family`,
#' `link`, `linkfun`, and `linkinv`. Delta/hurdle model families also have
#' elements `delta` (logical) and `type` (standard vs. Poisson-link).
#'
#' @details
#' `delta_poisson_link_gamma()` and `delta_poisson_link_lognormal()` have been
#' deprecated in favour of `delta_gamma(type = "poisson-link")` and
#' `delta_lognormal(type = "poisson-link")`.
#'
#' @examples
#' Beta(link = "logit")
Beta <- function(link = "logit") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("logit")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)
  x <- c(list(family = "Beta", link = linktemp), stats)
  add_to_family(x)
}

#' @export
#' @rdname families
#' @examples
#' lognormal(link = "log")
lognormal <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("identity", "log", "inverse")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)
  x <- c(list(family = "lognormal", link = linktemp), stats)
  add_to_family(x)
}

#' @details The families ending in `_mix()` are 2-component mixtures where each
#'   distribution has its own mean but a shared scale parameter.
#'   (Thorson et al. 2011). See the model-description vignette for details.
#'   The parameter `plogis(log_p_mix)` is the probability of the extreme (larger)
#'   mean and `exp(log_ratio_mix) + 1` is the ratio of the larger extreme
#'   mean to the "regular" mean. You can see these parameters in
#'   `model$sd_report`.
#' @references
#'
#' *Families ending in `_mix()`*:
#'
#' Thorson, J.T., Stewart, I.J., and Punt, A.E. 2011. Accounting for fish shoals
#' in single- and multi-species survey data using mixture distribution models.
#' Can. J. Fish. Aquat. Sci. 68(9): 1681–1693. \doi{10.1139/f2011-086}.

#' @export
#' @rdname families
#' @examples
#' gamma_mix(link = "log")
gamma_mix <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("identity", "log", "inverse")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)
  x <- c(list(family = "gamma_mix", link = linktemp), stats)
  add_to_family(x)
}

#' @export
#' @rdname families
#' @examples
#' lognormal_mix(link = "log")
lognormal_mix <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("identity", "log", "inverse")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)
  x <- c(list(family = "lognormal_mix", link = linktemp), stats)
  add_to_family(x)
}

#' @export
#' @rdname families
#' @examples
#' nbinom2_mix(link = "log")
nbinom2_mix <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("identity", "log", "inverse")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)
  x <- c(list(family = "nbinom2_mix", link = linktemp), stats)
  add_to_family(x)
}

#' @details
#' The `nbinom2` negative binomial parameterization is the NB2 where the
#' variance grows quadratically with the mean (Hilbe 2011).
#' @references
#'
#' *Negative binomial families*:
#'
#' Hilbe, J. M. 2011. Negative binomial regression. Cambridge University Press.
#' @export
#' @examples
#' nbinom2(link = "log")
#' @rdname families
nbinom2 <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("log")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)

  v <- function(mu, theta) {

  }
  x <- c(list(family = "nbinom2", link = linktemp), stats)
  add_to_family(x)
}

#' @details
#' The `nbinom1` negative binomial parameterization lets the variance grow
#' linearly with the mean (Hilbe 2011).
#' @export
#' @examples
#' nbinom1(link = "log")
#' @rdname families
nbinom1 <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("log")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)
  x <- c(list(family = "nbinom1", link = linktemp), stats)
  add_to_family(x)
}

#' @export
#' @examples
#' truncated_nbinom2(link = "log")
#' @rdname families
truncated_nbinom2 <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("log")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)

  structure(list(family = "truncated_nbinom2", link = linktemp, linkfun = stats$linkfun,
    linkinv = stats$linkinv), class = "family")
}

#' @export
#' @examples
#' truncated_nbinom1(link = "log")
#' @rdname families
truncated_nbinom1 <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("log")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)

  structure(list(family = "truncated_nbinom1", link = linktemp, linkfun = stats$linkfun,
    linkinv = stats$linkinv), class = "family")
}

#' @param df Student-t degrees of freedom fixed value parameter.
#' @export
#' @details
#' For `student()`, the degrees of freedom parameter is currently not estimated and is fixed at `df`.
#' @rdname families
#' @examples
#' student(link = "identity")
student <- function(link = "identity", df = 3) {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("identity", "log", "inverse")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)

  x <- c(list(family = "student", link = linktemp, df = df), stats)
  add_to_family(x)
}

#' @export
#' @rdname families
#' @examples
#' stdcurve(link = "identity")
stdcurve <- function(link = "identity") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("identity")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)

  x <- c(list(family = "stdcurve", link = linktemp), stats)
  add_to_family(x)
}

#' @export
#' @examples
#' tweedie(link = "log")
#' @rdname families
tweedie <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("log", "identity")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)

  x <- c(list(family = "tweedie", link = linktemp), stats)
  add_to_family(x)
}

#' @export
#' @examples
#' censored_poisson(link = "log")
#' @rdname families
censored_poisson <- function(link = "log") {
  linktemp <- substitute(link)
  if (!is.character(linktemp))
    linktemp <- deparse(linktemp)
  okLinks <- c("log")
  if (linktemp %in% okLinks)
    stats <- stats::make.link(linktemp)
  else if (is.character(link))
    stats <- stats::make.link(link)

  structure(list(family = "censored_poisson", link = linktemp, linkfun = stats$linkfun,
    linkinv = stats$linkinv), class = "family")
}

#' @param link1 Link for first part of delta/hurdle model.
#' @param link2 Link for second part of delta/hurdle model.
#' @param type Delta/hurdle family type. `"standard"` for a classic hurdle
#'   model. `"poisson-link"` for a Poisson-link delta model (Thorson 2018).
#' @export
#' @importFrom stats Gamma binomial
#' @examples
#' delta_gamma()
#' @rdname families
#' @references
#' *Poisson-link delta families*:
#'
#' Thorson, J.T. 2018. Three problems with the conventional delta-model for
#' biomass sampling data, and a computationally efficient alternative. Canadian
#' Journal of Fisheries and Aquatic Sciences, 75(9), 1369-1382.
#' \doi{10.1139/cjfas-2017-0266}
delta_gamma <- function(link1 = "logit", link2 = "log", type = c("standard", "poisson-link")) {
  type <- match.arg(type)
  l1 <- substitute(link1)
  if (!is.character(l1)) l1 <- deparse(l1)
  l2 <- substitute(link2)
  if (!is.character(l2)) l2 <- deparse(l2)
  f1 <- binomial(link = l1)
  f2 <- Gamma(link = l2)
  if (type == "poisson-link") {
    .type <- "poisson_link_delta"
    clean_name <- paste0("delta_gamma(link1 = '", l1, "', link2 = '", l2, "', type = 'poisson-link')")
  } else {
    .type <- "standard"
    clean_name <- paste0("delta_gamma(link1 = '", l1, "', link2 = '", l2, "')")
  }
  structure(list(f1, f2, delta = TRUE, link = c("logit", "log"),
    type = .type, family = c("binomial", "Gamma"),
    clean_name = clean_name), class = "family")
}

#' @export
#' @examples
#' delta_gamma_mix()
#' @rdname families
delta_gamma_mix <- function(link1 = "logit", link2 = "log") {
  f1 <- binomial(link = link1)
  f2 <- gamma_mix(link = link2)
  structure(list(f1, f2, delta = TRUE, link = c("logit", "log"),
       family = c("binomial", "gamma_mix"),
       clean_name = "delta_gamma_mix(link1 = 'logit', link2 = 'log')"), class = "family")
}

#' @export
#' @examples
#' delta_lognormal()
#' @rdname families
delta_lognormal <- function(link1 = "logit", link2 = "log", type = c("standard", "poisson-link")) {
  type <- match.arg(type)
  l1 <- substitute(link1)
  if (!is.character(l1)) l1 <- deparse(l1)
  l2 <- substitute(link2)
  if (!is.character(l2)) l2 <- deparse(l2)
  f1 <- binomial(link = l1)
  f2 <- lognormal(link = l2)
  if (type == "poisson-link") {
    .type <- "poisson_link_delta"
    clean_name <- paste0("delta_lognormal(link1 = '", l1, "', link2 = '", l2, "', type = 'poisson-link')")
  } else {
    .type <- "standard"
    clean_name <- paste0("delta_lognormal(link1 = '", l1, "', link2 = '", l2, "')")
  }
  structure(list(f1, f2, delta = TRUE, link = c("logit", "log"),
    family = c("binomial", "lognormal"), type = .type,
    clean_name = clean_name), class = "family")
}

#' @export
#' @examples
#' delta_lognormal_mix()
#' @rdname families
delta_lognormal_mix <- function(link1 = "logit", link2 = "log") {
  f1 <- binomial(link = link1)
  f2 <- lognormal(link = link2)
  structure(list(f1, f2, delta = TRUE, link = c("logit", "log"),
       family = c("binomial", "lognormal_mix"),
       clean_name = "delta_lognormal_mix(link1 = 'logit', link2 = 'log')"), class = "family")
}

#' @export
#' @examples
#' delta_truncated_nbinom2()
#' @rdname families
delta_truncated_nbinom2 <- function(link1 = "logit", link2 = "log") {
  f1 <- binomial(link = link1)
  f2 <- truncated_nbinom2(link = link2)
  structure(list(f1, f2, delta = TRUE, link = c("logit", "log"),
    family = c("binomial", "truncated_nbinom2"),
    clean_name = "delta_truncated_nbinom2(link1 = 'logit', link2 = 'log')"), class = "family")
}

#' @export
#' @examples
#' delta_truncated_nbinom1()
#' @rdname families
delta_truncated_nbinom1 <- function(link1 = "logit", link2 = "log") {
  f1 <- binomial(link = link1)
  f2 <- truncated_nbinom1(link = link2)
  structure(list(f1, f2, delta = TRUE, link = c("logit", "log"),
    family = c("binomial", "truncated_nbinom1"),
    clean_name = "delta_truncated_nbinom1(link1 = 'logit', link2 = 'log')"), class = "family")
}

#' @rdname families
#' @export
#' @keywords internal
delta_poisson_link_gamma <- function(link1 = "log", link2 = "log") {
  assert_that(link1 == "log")
  assert_that(link2 == "log")
  lifecycle::deprecate_warn("0.4.2.9000", "delta_poisson_link_gamma()", "delta_gamma(type)")
  delta_gamma(link1 = "logit", link2 = "log", type = "poisson-link")
}

#' @rdname families
#' @export
#' @keywords internal
delta_poisson_link_lognormal <- function(link1 = "log", link2 = "log") {
  assert_that(link1 == "log")
  assert_that(link2 == "log")
  lifecycle::deprecate_warn("0.4.2.9000", "delta_poisson_link_lognormal()", "delta_lognormal(type)")
  delta_lognormal(link1 = "logit", link2 = "log", type = "poisson-link")
}

#' @export
#' @examples
#' delta_beta()
#' @rdname families
delta_beta <- function(link1 = "logit", link2 = "logit") {
  f1 <- binomial(link = link1)
  f2 <- Beta(link = link2)
  structure(list(f1, f2, delta = TRUE, link = c("logit", "logit"),
       family = c("binomial", "Beta"),
       clean_name = "delta_beta(link1 = 'logit', link2 = 'logit')"), class = "family")
}

#' @export
#' @examples
#' delta_gaussian()
#' @rdname families
delta_gaussian <- function(link1 = "logit", link2 = "identity") {
  link1 <- match.arg(link1)
  link2 <- match.arg(link2)
  f1 <- binomial(link = "logit")
  f2 <- gaussian(link = "identity")
  structure(list(f1, f2, delta = TRUE, link = c("logit", "identity"),
                 family = c("binomial", "gaussian"),
                 clean_name = "delta_gaussian(link1 = 'logit', link2 = 'identity')"), class = "family")
}
