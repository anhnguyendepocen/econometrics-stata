# Stata for researchers: Working with data

标签（空格分隔）： econometrics stata

---

##Generate and Replace
The basic commands for creating and changing variables are `generate` (usually abbreviated `gen`) and `replace` (which, like other commands that can destroy information, has no abbreviation). gen creates new variables; replace changes the values of existing variables. Their core syntax is identical:
```
gen variable=expression
```
or
```
replace variable=expression
```


