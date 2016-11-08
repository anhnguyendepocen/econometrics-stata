clear all
capture log close
set more off
log using data.log, replace

use auto

//real work goes here
gen price2015=price*3.57
l make price*

gen rep3=1 if rep78<3
replace rep3=2 if rep78==3
replace rep3=3 if rep78>3 & rep78<.


save autoVersion2,replace 
log close
