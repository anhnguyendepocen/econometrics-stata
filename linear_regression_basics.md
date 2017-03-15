# 3. Linear Regression Basics

> Notes of "Microeconometrics Using Stata, Cameron and Trivedi, Chapter3".

## 3.2 Data and Data Summary
```
use musdata.dta
describe <variable names>
```
summary statistics:
```
summarize <variable names>
```
### Detailed summary for dependent variable
```
summarize totexp, detail
```
We can see from the results that the data is skewed. The skewness of 4.16 indicates considerable right skewness.

The kurtosis statistic's reference value is 3, it is the value for normally distributed data. The much higher value of 26.26 indicates
that **the tails are much thicker than those of a normal distribution**.

So, the distribution of the dependent variable is considerably skewed and has thick tailed.
These complications often arise for commonly studied individual-level economic variables such as expenditure, 
income, wages, and house prices. In practice, much of the variation in the data will be left
 unexplained (R^2<0.3 is common for individual-level data), and skewness and excess kurtosis will remain..
 
Such skewed, thick-tailed data suggest a model with multiplicative errors instead of additive errors.
A standard solution is to transform the dependent variable by taking the natural logarithm.
Here this is complicated by the presence of 109 zero-valued observations. We drop the zero-valued observations. A better approach is 
use two-part or selection models.

### Two-way table of frequencies
```
table female totchr // famale and totchr are two variables
```
