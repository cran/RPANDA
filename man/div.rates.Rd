\name{div.rates}
\alias{div.rates}

\title{
  Diversification rates through time
}
\description{
  Calculates diversification rates through time from shift.estimates() output.
}
\usage{
  div.rates(phylo, shift.res, combi = 1, part = "backbone",
            time.interval = 1, backbone.option = "crown.shift")
}

\arguments{
  \item{phylo}{
    an object of type 'phylo' (see ape documentation)
  }
  \item{shift.res}{
    the output resulting from shift.estimates.
  }
  \item{combi}{
    numeric. The combination of shifts defined by its rank in the global comparison.
  }
  \item{part}{
    character. Specifies for which parts of the combination diversification rates has to be calculated. Default is "backbone" and provides only the backbone rate. Can be "all" for all the parts of a combination or "subclades" for subclades only.
  }
  \item{backbone.option}{
  type of the backbone analysis (see backbone.option in shift.estimates for more details):
    \itemize{ 
      \item"stem.shift": rates are calculated from the stem age for subclades.
      \item"crown.shift": rates are calculated from the crown age for subclades.
    }
  }
  \item{time.interval}{
  numeric. Define the time interval (in million years) at which diversification rates are calculated. Default is 1 for a value at each million year.
  }
}

\value{
  a list of matrix with two rows (speciation and extinction) and as many columns as million years from the root to the present.
}

\references{
  Mazet, N., Morlon, H., Fabre, P., Condamine, F.L., (2023). Estimating clade‐specific diversification rates and palaeodiversity dynamics from reconstructed phylogenies. \emph{Methods in Ecology and in Evolution} 14, 2575–2591. https://doi.org/10.1111/2041-210X.14195
}

\author{Nathan Mazet}

\seealso{
\code{\link{shift.estimates}}
}
\examples{
# loading data
data("Cetacea")
data("shifts_cetacea")

# with shifts_cetacea the output from shift.estimates()
rates <- div.rates(phylo = Cetacea, shift.res = shifts_cetacea,
                   combi = 1, part = "all")
}