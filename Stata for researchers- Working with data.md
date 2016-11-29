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
##Egen
The `egen` command, short for extended generate, gives you access to another library of functions—type `help egen` for a full list.
```
help egen
```
Suppose you wanted to find the mean value of mpg and store it in a variable. egen has a mean function which will give you exactly what you want:
```
egen meanMPG=mean(mpg)
```
The `mean()` function finds the mean of a column. To find the mean of a row, or, more likely, part of a row, use `rowmean()`:
```
egen rm=rowmean(mpg rep78)
```
For each car, `rm` will contain the mean of that car's mpg and rep78, not that that's likely to be a useful quantity. A more typical use of `rowmean()` is to construct a respondent's mean response to a group of questions.

Here are a few of the most commonly used functions in the egen library:

| Name        | Description   |  
| --------   | -----:  | 
| min()    | Minimum value | 
| max()        |   Maximum value  | 
| mean()       |    Mean   | 
|median()|	Median|
|sd()|	Standard Deviation|
|total()	|Total|

All of these functions act across observations. The parentheses will usually contain a single variable for the function to act on, but can contain a mathematical expression instead. These functions also have row equivalents (`rowmin`, `rowmax`, etc.) that do the same thing but across variables on a single row. There are plenty of other useful egen functions, such as `std` (create a standardized version of a variable), `group` (create a group identifier based on the values of one or more categorical variables), or even `mtr` (marginal tax rate for a married couple in the US with a given amount of income in a given year).

##Drop and Keep
The `drop` command allows you to remove either variables or observations from your data set. If you give it a varlist, it will remove those variables:
```
drop rep3b
```
removes the variable `rep3b` from your data set.

If you give it an `if` condition, `drop` will remove all observations where that condition is true:
```
drop if gasGuzzler
```
The `keep` command works in the same way, but in the opposite sense. `keep rep3b` would remove all variables except `rep3b`, while `keep if gasGuzzler` would remove all observations that are not gas guzzlers.

##Rename
You can rename a variable by typing:
```
rename oldName newName
```
##Labels
Labels allow you to convey more information about your data.

The syntax to set a variable label is:
```
label variable var "label"
```
So type:
```
label variable foreign "Car Origin"
```
Look at the Variables window again to see the results.

Next let's explore value labels by labeling the values of the `repairRecord` (formerly known as `rep3`, the new variable we recoded to collapse `rep78` from a five point scale to a three point scale). Value labels are a mapping from a set of integers to a set of descriptions, so the first step is to create the map. To do so, use the label define command:
```
label define mapName value1 "label1" value2 "label2"...
```
Thus:
```
label define rep 1 "Bad" 2"Average" 3"Good"
```
Then tell Stata to label the values of the `repairRecord` variable using the rep mapping you just defined. The syntax is:
```
label values variable map
```
And thus:
```
label values repairRecord rep
```
To see the results, add:
```
list repairRecord
```
Once a map is defined you can apply it to any number of variables: just replace the single variable in the label values command above with a list of variables. Suppose you're working with survey data and your variables include the gender of the respondent, the gender of the respondent's spouse, and the genders of all the respondent's children. You could define just one map called gender and then use it to label the values of all the gender variables.

Two final commands for value labels: `label dir` gives you a list of all the defined labels, and `label list` tells you what they mean.

##Variable
The type of a variable is set when it is created. To create a variable that is not a float, put the desired type right after `gen` or `egen` and before the variable name:
```
gen byte highMPG=(mpg>25)
```
If you declare that a variable is an integer (byte, int or long) but the expression you set it equal to contains fractions, the fractional part will be truncated, not rounded. There is also a `round()` function if you need it.

##Strings
You can recognize a string because it will have quotes around it:
```
gen x1="123"
```
makes x1 a string, and is completely different from
```
gen x2=123
```
###Changing the Type of a Variable

Suppose you needed to do some math with the numbers contained in `x1`. Right now you can't, because `x1` is a string. Here's how you can change that:
```
gen temp=real(x1)
drop x1
rename temp x1
```
The `real()` function takes one argument, a string, and returns that string converted to a number. If the string contains anything but numbers `real()` will return missing. Having stored the numbers in x1 as temp, you then drop x1 and make temp the new x1. x1 is now a numeric variable. You can turn numeric variables into strings using the same process—just replace the `real()` function with the `string()` function.