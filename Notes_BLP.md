# Notes When doing BLP exercise
### Format integer to formated string
```
gen co_new = strofreal( co,"%03.0f")
```
> Output: like 001, 032, 123 etc.

This can also be used in converting integer to string
```
gen ma_str = strofreal(ma)
```
### Conbine several columns together
```
gen id = co_new+ ma_str+ ye_str
```
(first convert them to string)
### Basic multiply and divide
```
gen s_jt = qu/qu_sum
```
### Replace missing data
```
replace qu_sum = qu_sum_1 if missing(qu_sum)
```
### Sum with condition (sum by some attributes)
```
sort brd
by brd: egen qu_brand = sum(qu)
```
(Be sure to sort first)
### Generate dummy variables
```
tabulate brd , generate(brd_dummy)
```
### Generate a column full with 1
```
generate int constant = 1
```
### Delete duplicates
```
duplicates drop id_demo, force
```
### Drop less frequency patterns
```
bysort co : drop if _N<11
```
