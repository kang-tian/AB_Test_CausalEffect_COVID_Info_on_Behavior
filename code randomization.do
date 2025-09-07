
clear
cd "C:\Users\Jinky\Desktop\ECON 664\"
use "dataclean_group3.dta" 

*create treatment group
egen rsum_index = rsum(a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 b1 b2 b3 b4 b5 b6 c1 c2 c3 c4)
xtile halved=rsum_index, nq(2)
tab halved
sum rsum_index if halved==1
sum rsum_index if halved==2

set seed 13845656
gen number=uniform()
centile(number) if rsum_index<=81, centile(50)
gen treatment=1 if rsum_index<=81&number>=`r(c_1)'

centile(number) if rsum_index>=84, centile(50)
replace treatment=1 if rsum_index>=84&number>=`r(c_1)'
replace treatment=0 if treatment==.

tab treatment

*balance test
ssc install ietoolkit
iebaltab gender international test relative_test rsum_index, grpvar(treatment) save(balance_V1.xls)
//https://dimewiki.worldbank.org/Iebaltab

