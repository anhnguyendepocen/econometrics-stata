# Stata for researchers: Usage and syntax

标签（空格分隔）： econometrics stata

---

源文档：http://www.ssc.wisc.edu/sscc/pubs/sfr-syntax.htm
笔记如下

##Stata missing values
Most general one: `.`.
There are 26 others you can use: `.a` through `.z`. Stata treats them all the same, but you can assign meanings to them. For example, if you were working with a survey you might decide to code "the question did not apply" as `.a` and "the respondent refused to answer" as `.b`.

##Browse data set
```stata
browse
```
`browse` opens Stata's Data Editor, which shows you your data set in a spreadsheet-like form. You can also invoke the Data Editor by typing `edit` or clicking the fifth button from the right, and then it will allow you to make changes. Since you should **never** change your data interactively, get in the habit of using browse so you don't make changes by accident.

##Value labels
```
describe
```
(or just `d`). This will give you information about all the variables in your data set, including a column that tells you which ones have value labels.

You can see what the labels are by typing:
```
label list
```



