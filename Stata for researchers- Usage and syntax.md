# Stata for researchers: Usage and syntax

标签（空格分隔）： econometrics stata

---

源文档：http://www.ssc.wisc.edu/sscc/pubs/sfr-syntax.htm
笔记如下
##Introduction
###Stata missing values
Most general one: `.`.
There are 26 others you can use: `.a` through `.z`. Stata treats them all the same, but you can assign meanings to them. For example, if you were working with a survey you might decide to code "the question did not apply" as `.a` and "the respondent refused to answer" as `.b`.

###Browse data set
```stata
browse
```
`browse` opens Stata's Data Editor, which shows you your data set in a spreadsheet-like form. You can also invoke the Data Editor by typing `edit` or clicking the fifth button from the right, and then it will allow you to make changes. Since you should **never** change your data interactively, get in the habit of using browse so you don't make changes by accident.

###Value labels
```
describe
```
(or just `d`). This will give you information about all the variables in your data set, including a column that tells you which ones have value labels.

You can see what the labels are by typing:
```
label list
```
##Syntax elements
Almost all Stata commands rely on the same set of syntax elements.

We'll discuss four elements:
- varlists
- if
- options
- by

These elements always go in the same order:
```
[by varlist:] command [varlist] [if condition] [, options]
```
In order to see these elements in action, we'll use a very simple command:
```
list
```
(`list` can also be abbreviated as just `l`.)

###Varlists
Varlists allows you to control which **variables (columns)** a command will act on. A varlist is simply a list of variables separated by spaces, and it goes right after the command itself. Type:
```
list make price mpg
```
This lists just the make,price and mpg of each car rather than all the variables.

If you put a dash between two variables, all the variables between them (as defined by the order they're listed in the Variables window) will be included in the variable list. Thus:
```
list make-mpg
```
You can also use wildcard characters. A `*` matches any number of characters, so
```
list m*
```
gives you both make and mpg. It would also include a variable just called m if there were one in the data set. A `?` matches any one character, but it must be **exactly one**. Thus:
```
list x?
```
would list (if our data set had such variables) x1, x2, and x3, but not x, x10 or xenophobia.

You can mix shortcut types:
```
list m* weight-displacement *n // start with m, w-d, end with n
```
###If
If conditions allow you to control which **observations (rows)** a command acts on.
```
list make mpg if mpg==25
```
This gives you a list containing the make and mpg of just those cars which get exactly 25 miles per gallon.
```
list make mpg if !(mpg>25)
```
"Not" can be thought of as reversing the condition that follows it: changing false to true and true to false.

You can combine two conditions with "logical and" (`&`) or "logical or" (`|`)
```
list make price mpg if mpg>25 & price<5000
```

Internally, Stata stores the missing values `.`, `.a`, `.b` ... `.z` as the 27 **largest possible numbers** of each variable type, and in that order. It's very important to keep this in mind when dealing with inequalities: think of missing values as essentially "positive infinity."

Consider making a list of cars with "good" repair records, defined as rep78 greater than three:
```
l make rep78 if rep78>3
```
Cars with a missing value for rep78 are included.

Veteran Stata programmers will use:
```
l make rep78 if rep78>3 & rep78<.
```
The generic `.` is the smallest of the missing values, so `rep78<.` will be true for all valid values and false for all missing values.

An alternative that's longer to type but easier to read is:
```
l make rep78 if rep78>3 & !missing(rep78)
```
The `missing` function takes a variable name as input, and returns true if that variable is missing and false if it is not.
```
misstable sum
```
This is an example of a command with a **subcommand**. The `misstable` command can do many things, so the second word (or in this case abbreviation since sum is short for summarize) tells Stata you want it to give you a summary of the variables that have missing values.

```
help [function] //occur manual page for the function
```
If you will be working with many data sets or data sets that do change, you can build a test for missing values right into your do files. The `assert` command checks to see whether a given condition is true or not for all observations. For example:
```
assert mpg<.
```
checks to see if mpg is always non-missing. Since it is, nothing happens. However, try:
```
assert rep78<.
```
Now you get an error message (along with information about how often the condition is violated).

This is good: if your code was written on the assumption that `rep78` is never missing, it's far better for that code to crash than to continue running and give you wrong answers.

##Options
Options control how a command runs. They go at the end of the command after a comma. There can be any number of options (all following a single comma) and they can go in any order.
```
list make foreign, nolabel
```
The `nolabel` option can be used with many commands. It tells the command to ignore value labels and show the actual values of the variable. Other options may only be used by a single command.

##By
By is used to run a command separately across groups. For example, list the domestic cars and the foreign cars separately by typing:
```
by foreign: l make foreign
```
Note how the list is broken into two parts. The first one says `foreign=Domestic` at the top, the second says `foreign=Foreign`.

Since by takes a varlist, you can work by more than one variable at a time. Try:
```
by foreign rep78: l make
```
You'll get the message
```
not sorted
r(5);
```
Stata can only use by if the data set is sorted in the order of the by variables. This data set started out sorted by foreign, but not by rep78. Type:
```
sort foreign rep78
```
and Stata will sort the data and allow you to execute:
```
by foreign rep78: l make
```
successfully.

Users got tired of forgetting to sort before using by, so Stata added `bysort`:
```
bysort foreign rep78: l make
```
This will first sort the data by foreign and rep78, then carry out the rest of the command.

> A caution about sorting: Stata's default sort algorithm is not stable, meaning that it may change the order of the observations even if it doesn't have to. If the order is important, add the `stable` option to the sort command (e.g. `sort household, stable`) and Stata will switch to a slower algorithm that is stable.