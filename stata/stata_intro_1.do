sysuse sp500.dta
br
list date close
list date close in 1/10
list date close if close >1200
br date close if date>td(01jun2001)
ren close price
describe
codebook
sum
restore
preserve
keep date price
tsset date, daily
gen returns= 100*(price-L.price)/L.price
br
gen logret=log(price/L.price)
br
gen returns_1= (price-L.price)/L.price
br
drop returns_1
br
tsline price
tsline logret
histogram price
import excel "C:\Users\Mir\data\UKHP.xls", sheet("Monthly") firstrow clear
save "C:\Users\Mir\data\ukhp.dta"
