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

recode rep78 (1 2=1) (3=2) (4/5=3), gen(rep3b)
assert rep3==rep3b

gen gasGuzzler=(mpg<20) if mpg<.

save autoVersion2,replace 
log close
