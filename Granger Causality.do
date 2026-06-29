*Granger Causality Study
* import fred CPIAUCSL FEDFUNDS, aggregate(monthly,eop) clear

// Clean out the data
drop if missing(FEDFUNDS)|missing(CPIAUCSL)
gen time = tm(1954m7)+_n-1
format time %tm
tsset time

//test for stationarity
dfuller inflation
dfuller FEDFUNDS

// Define the varibales. Note that these are monthly datasets, not yearly ones
gen inflation = ((CPIAUCSL-L.CPIAUCSL)/(L.CPIAUCSL))*100
gen interest_rate = D.FEDFUNDS
dfuller interest_rate


//Get a summary of the data
sum inflation interest_rate

// Plots
tsline inflation interest_rate, saving(g1, replace)
tsline inflation, saving(g2, replace)
tsline interest_rate, saving(g3, replace)
graph combine g1.gph g2.gph g3.gph

// Let's see some correlations
correl inflation interest_rate
correlate inflation interest_rate, covariance // bonus

// Regressions
reg inflation interest_rate
reg interest_rate inflation

//Optimal lag selection
varsoc inflation interest_rate, maxlag(12)
// we found that lag 12 is the ideal. This means, values are the best when they are reffered to their counterparts from other years. Ex: January of 2024 is correlated with January of 2023 and so forth.
var interest_rate inflation, lags(1/12)
vargranger
