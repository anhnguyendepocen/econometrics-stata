# Stata for researchers: Do files

标签（空格分隔）： econometrics stata

---

##Writing a Do File
Do files are simply text files whose names end with `.do` and which contain Stata commands exactly the way you'd type them into the command window.

Start the Do File Editor by clicking on the button that looks like a pencil writing in a notebook or by typing `doedit`.

##Setting Up
Almost every do file should start with the following commands (or something very much like them):
```
clear all
capture log close
set more off
```
The first command clears the memory so you don't have to worry about what might have happened before your do file was run. The second closes any open log files. The third tells Stata not to pause whenever the screen fills and wait for you to press a key (while saying --more-- at the bottom).

##Starting a Log
A research do file should have a corresponding log file which records all the commands the do file ran and their results. To start logging, the command is:
```
log using filename.log, replace
```
where `filename` is the name of the file you want Stata to use as a log. Give the log file the same name as the do file it records, so it's obvious which log file goes with which do file. The `replace` option tells Stata that if a log file with that name already exists, usually from a previous attempt to run the do file, it should be replaced by the current log.

##Loading Data
Next you will usually load a data set:
```
use dataset
```
If the dataset is in the current working directory, you don't need to specify its location.

##Do Your Work
At this point you'll be ready to do your work.

###Save your Data
If this do file is for data preparation, you'll need to save your work at the end:
```
save newDataset, replace
```
The `replace` option again allows Stata to overwrite the output from previous attempts to run the do file.

##Close your log
The last line of the do file will normally be:
```
log close
```
If you don't close the do file's log, any commands you run after the do file finishes will be logged as if they were part of the do file.

##Running a Do File
The easiest way to run a do file is to press `Ctrl-d` in the Do File Editor.

You can also tell Stata to run a do file with the do command:
```
do myDoFile
```
This means do files can run other do files. For complicated projects it can be very helpful to have a master do file that runs all the other do files in the proper sequence.

