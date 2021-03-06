% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/points_cal.R
\name{points_cal}
\alias{points_cal}
\title{Calculate Total Points}
\usage{
points_cal(formula, rd, lp, digits = 6)
}
\arguments{
\item{formula}{the formula of total points with raw data or linear predictors}

\item{rd}{raw data, which cannot have missing values}

\item{lp}{linear predictors}

\item{digits}{default is 6}
}
\value{
total Points
}
\description{
Calculate total points.
}
\examples{
library(rms)  # needed for nomogram
set.seed(2018)
n <-2019
age <- rnorm(n,60,20)
sex <- factor(sample(c('female','male'),n,TRUE))
sex <- as.numeric(sex)
weight <- sample(50:100,n,replace = TRUE)
time <- sample(50:800,n,replace = TRUE)
units(time)="day"
death <- sample(c(1,0,0),n,replace = TRUE)
df <- data.frame(time,death,age,sex,weight)
ddist <- datadist(df)
oldoption <- options(datadist='ddist')
f <- cph(formula(Surv(time,death)~sex+age+weight),data=df,
         x=TRUE,y=TRUE,surv=TRUE,time.inc=3)
surv <- Survival(f)
nomo <- nomogram(f,
                 lp=TRUE,
                 fun=list(function(x) surv(365,x),
                          function(x) surv(365*2,x)),
                 funlabel=c("1-Year Survival Prob",
                            "2-Year Survival Prob"))
options(oldoption)
#get the formula by the best power using formula_lp
results <- formula_lp(nomo)
points_cal(formula = results$formula,lp=f$linear.predictors)

#get the formula by the best power using formula_rd
results <- formula_rd(nomogram = nomo)
points_cal(formula = results$formula,rd=df)
}
