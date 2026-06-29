# Granger Causality: Inflation & Interest Rates

**Does inflation drive interest rates — or is it the other way around?**

This project uses monthly U.S. data to test the direction of causality between inflation and the federal funds rate, using Granger causality via Vector Autoregression (VAR) in Stata.

---

## What's inside

| File | Description |
|---|---|
| `Granger Causality.do` | Full Stata script — data cleaning, stationarity tests, VAR, Granger test |

---

## Data

- **Source:** FRED (Federal Reserve Economic Data)
- **Series:** `CPIAUCSL` (Consumer Price Index) and `FEDFUNDS` (Federal Funds Rate)
- **Frequency:** Monthly
- **Coverage:** July 1954 onward

Imported directly into Stata with `import fred`.

---

## Methodology

### 1. Clean & transform
- Drop observations with missing values
- Compute **inflation** as month-over-month % change in CPI:  
  `inflation = ((CPI - CPI_lag) / CPI_lag) × 100`
- Take the **first difference** of the federal funds rate to achieve stationarity

### 2. Test for stationarity
- Augmented Dickey-Fuller (ADF) tests on both series
- Inflation is stationary in levels; interest rates required first-differencing

### 3. Visualize
- Time-series plots of both variables (combined and individual)

### 4. Correlations & regressions
- Pearson correlation between inflation and interest rates
- OLS regressions in both directions (each as dependent variable)
- Note: regression alone can't tell you the *direction* of causality

### 5. Optimal lag selection
- `varsoc` with up to 12 lags — three selection criteria converge on **lag 12**
- This means each month's value is most predictive of the same month one year later

### 6. VAR & Granger causality
- Estimate a VAR(12) model on both variables
- Run `vargranger` to test whether lags of one variable help predict the other

---

## Result

> **Interest rates Granger-cause inflation** (p < 0.001)

The p-value on the inflation equation is essentially zero, meaning past values of interest rates carry statistically significant predictive power for inflation. The reverse direction does not hold at the same level of significance.

This is consistent with standard monetary theory: central banks raise rates to cool prices, and that signal feeds through to inflation with a lag.

**Caveat:** Granger causality is not the same as structural causality. It tells you about predictive precedence, not mechanism. Omitted variables (supply shocks, fiscal policy, global factors) can affect these results.

---

## How to run

1. Open Stata
2. Make sure `freduse` is installed: `ssc install freduse`
3. Run the `.do` file — data imports automatically from FRED

```stata
do "Granger Causality.do"
```

---

## Author

**Elias Nkuansambo**  
Graduate Teaching Assistant, University of North Dakota | Applied Economics  
[LinkedIn](https://www.linkedin.com/in/eliasnkuansambo)
