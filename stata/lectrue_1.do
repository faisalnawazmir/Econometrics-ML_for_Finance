clear
cls
import excel "C:\Users\Mir\UKHP.xls", sheet("Monthly") firstrow * simply import data to stata, you  may use drop down menu.
browse
describe
codebook
sum
ren AverageHousePrice hp
tsset Month, monthly
gen month=mofd(Month)
format %tm month
tsset month, monthly
gen lagofhp=L.hp
gen hpdouble=hp*2
gen returns=100*(hp-L.hp)/L.hp
gen logreturns=log(hp/L.hp)
gen returns_1=(hp-L.hp)/L.hp
tsline hp
histogram logreturns
