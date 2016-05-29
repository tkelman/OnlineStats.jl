module PlotTest

using OnlineStats, TestSetup, FactCheck, Plots
plotly()

facts(@title "Plots") do
    o = LinReg(10)
    coefplot(o)

    tr = TracePlot(o)
    fit!(tr, randn(100, 10), randn(100))
    plot(tr)
    @fact nobs(tr) --> 100
    value(tr)

    o.β[2] = 0.0
    coefplot(o)

    o1 = LinReg(10)
    o2 = LinReg(10, ExponentialWeight(.1))
    tr = CompareTracePlot(OnlineStat[o1, o2], x -> maxabs(coef(x)))
    fit!(tr, randn(100,10), randn(100))
    plot(tr)
end

end # module