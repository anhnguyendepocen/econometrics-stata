# Stata for researchers: Statistics

---

## Summary Statistics
`summarize (sum)` gives you summary statistics. If you just type:
```
sum
```
you will get basic summary statistics for all the variables in your data set.

If you want summary statistics for just the foreign cars, add an if condition:
```
sum mpg if foreign
```
If you want summary statistics of mpg for both foreign and domestic cars, calculated separately, use by:
```
by foreign: sum mpg
```
The `detail (d)` option will give more information. Try:
```
sum mpg, d
```
Can get information about "variance", "skewness" and "kurtosis".

## Frequencies
`tabulate (tab)` will create tables of frequencies. If you give it a varlist with one variable it will give you a one-way table, while if you give it two variables it will give you a two-way table (i.e. crosstabs). To get an idea of what tab does, try:
```
tab rep78
tab rep78 foreign
```
There's also a chi2 option that runs a chi-squared test on a two-way table:
```
tab rep78 foreign, chi2
```

## Correlations
`correlate (cor)` calculates correlations:
```
cor weight length mpg
```
If you need covariances instead, add the `cov` option:
```
cor weight length mpg, cov
```

## Hypothesis Tests of Means
`ttest` tests hypotheses about means. To test whether the mean of a variable is equal to a given number, type ttest var==number:
```
ttest mpg==20
```
To test whether two variables have the same mean, type ttest var1==var2:
```
ttest mpg==weight
```
To test whether two subsamples of your data have the same mean for a given variable, use the `by()` option:
```
ttest mpg, by(foreign)
```

## Returned Results
Most statistical commands also save their results so that you can use them in subsequent commands. You can see what is saved with the return list command. To see a typical example, try:
```
sum mpg
return list
```
These saved results are often referred to as the r vector.

Suppose you want to center mpg around zero, by subtracting the mean value from all observations. Running sum mpg puts the mean of mpg in the r vector, and then you can create a centered version of mpg with:
```
gen mpgCentered=mpg-r(mean)
```

## Regression
### Linear Regression
The `regress (reg)` command does linear regression. It always needs a varlist, and it uses it in a particular way: the first variable is the dependent variable, and it is regressed on all the others in the list plus a constant (unless you add the noconstant option).

Let's estimate how much consumers were willing to pay for good gas mileage in 1978 using a naive "hedonic pricing" model (i.e., we'll presume the price depends on the characteristics of the car). Whether a car is foreign or domestic seems to be important, so throw that in as a covariate too. Type:
```
regress price mpg foreign
```
This regresses price on mpg and foreign.

