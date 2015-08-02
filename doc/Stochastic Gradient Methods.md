# Available Models using Stochastic Gradient Descent and Variants
The interface is standard across the `StochasticGradientStat` types (SGD, Momentum, and Adagrad).  Each takes arguments:

argument | description
---------|------------
`x` | matrix of predictors
`y` | response vector
`wgt` (optional) | Weighting scheme. Defaults to `StochasticWeighting(.51)`
`intercept` (keyword) | Should an intercept be included?  Defaults to `true`
`model` (keyword)     | One of the models below.  Defaults to `L2Regression()`
`penalty` (keyword)   | `NoPenalty` (default), `L1Penalty`, or `L2Penalty`
`start` (keyword)     | starting value for β.  Defaults to zeros.


The model argument specifies both the link function and loss function to be used.  Options are:

- `L1Regression()`
    - Linear model using absolute loss.  This minimizes `vecnorm(y - X*β, 1)` with respect to β.
- `L2Regression()`
    - Ordinary least squares.  This minimizes `vecnorm(y - X*β, 2)` with respect to β.
- `LogisticRegression()`
    - This maximizes the logistic regression loglikelihood.
- `PoissonRegression()`
    - Poisson regression using an L1 loss (since likelihood-based updates are very unstable).
- `QuantileRegression(τ)`
    - Predict the conditional τ-th quantile of `y` given `X`
- `SVMLike()`
    - Fits Perceptron (with `penalty = NoPenalty`) or Support Vector Machine (with `penalty = L2Penalty(λ)`)
- `HuberRegression(δ)`
    - Robust regression using Huber loss.

# Common Interface
Here `o` is a `StochasticGradientStat`

method | details
---------|------------
`state(o)`                | return coefficients and number of observations
`statenames(o)`           | names corresponding to `state`: `[:β, :nobs]`
`StatsBase.coef(o)`       | return coefficients
`StatsBase.predict(o, x)` | `x` can be vector or matrix

## SGD

Examples:
```julia
# 1) Absolute loss with ridge penalty
# 2) Quantile regression (same as absolute loss if τ = 0.5)
# 3) Ordinary least squares with "slow" decay rate (fast learner)
# 4) Logistic regression with "fast" decay rate (slow learner)
# 5) Support vector machine
# 6) Robust regression with Huber loss

o = SGD(x, y, model = L1Regression(), penalty = L2Penalty(.1))

o = SGD(x, y, StochasticWeighting(.7), model = QuantileRegression(0.5))

o = Momentum(x, y, StochasticWeighting(.51), model = L2Regression())

o = Momentum(x, y, StochasticWeighting(.9), model = LogisticRegression())

o = Adagrad(x, y, model = SVMLike(), penalty = L2Penalty(.1))

o = Adagrad(x, y, StochasticWeighting(.7), model = HuberRegression(2.0))
```

## Momentum
`SGD` can be replaced with `Momentum` in the above examples

## Adagrad
`SGD` can be replaced with `Adagrad` in the above examples