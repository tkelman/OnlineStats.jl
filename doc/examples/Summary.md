
# Summary


````julia
using OnlineStats
using Distributions
````





### Create fit with the first batch
````julia
x = rand(Normal(10, 5), 100)
obj = Summary(x)
````





### Update model with many batches
````julia
for i = 1:10000
    x = rand(Normal(10, 5), 100)
    update!(obj, x)
end
````





### Check summary statistics
````julia
julia> state(obj)
6x2 Array{Any,2}:
 :mean     10.0059  
 :var      25.0038  
 :max      34.0041  
 :min     -13.7301  
 :n         1.0001e6
 :nb    10001.0     

````

