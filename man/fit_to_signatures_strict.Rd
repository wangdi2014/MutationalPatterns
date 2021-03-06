% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit_to_signatures_strict.R
\name{fit_to_signatures_strict}
\alias{fit_to_signatures_strict}
\title{Fit mutational signatures to a mutation matrix with less overfitting}
\usage{
fit_to_signatures_strict(mut_matrix, signatures, max_delta = 0.05)
}
\arguments{
\item{mut_matrix}{mutation count matrix (dimensions: x mutation types
X n samples)}

\item{signatures}{Signature matrix (dimensions: x mutation types
X n signatures)}

\item{max_delta}{The maximum difference in original vs reconstructed cosine similarity between two iterations.}
}
\value{
A list containing a fit_res object, similar to `fit_to_signatures` and a list of ggplot graphs
that for each sample shows in what order the signatures were removed and how this affected the cosine similarity.
}
\description{
Refitting signatures with this function suffers less from overfitting.
The strictness of the refitting is dependent on 'max_delta'.
A downside of this method is that it might increase signature misattribution.
Different signatures might be attributed to similar samples.
You can use 'fit_to_signatures_bootstrapped()', to see if this is happening.
Using less signatures for the refitting will decrease this issue. Fitting
less strictly will also decrease this issue.
}
\details{
Find a linear non-negative combination of mutation signatures that
reconstructs the mutation matrix. First an optimal reconstruction is achieved via `fit_to_signatures`.
However, this is prone to overfitting.
To solve this the signature with the lowest contribution is removed and refitting is repeated.
This is done in an iterative fashion.
Each time the cosine similarity between the original and reconstructed profile is calculated.
Iterations are stopped when the difference between two iterations becomes more than `max_delta`.
The second-last set of signatures is then used for a final refit.
}
\examples{
## See the 'mut_matrix()' example for how we obtained the mutation matrix:
mut_mat <- readRDS(system.file("states/mut_mat_data.rds",
  package = "MutationalPatterns"
))

## Get signatures
signatures <- get_known_signatures()

## Fit to signatures strict
strict_refit <- fit_to_signatures_strict(mut_mat, signatures, max_delta = 0.05)

## fit_res similar to 'fit_to_signatures()'
fit_res <- strict_refit$fit_res

## list of ggplots that shows how the cosine similarity was reduced during the iterations
fig_l <- strict_refit$sim_decay_fig

}
\seealso{
\code{\link{mut_matrix}},
\code{\link{fit_to_signatures}},
\code{\link{fit_to_signatures_bootstrapped}}
}
