use "C:\Users\Mir\OneDrive - Higher Education Commission\Documents\macro.dta" 
regress ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm
#drop resid
predict resid, residuals
twoway (tsline resid)
estat hettest, rhs
estat hettest, iid rhs
estat hettest, fstat rhs
# White' method
regress ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm, vce(robust)
#The Newey–West Procedure for Estimating Standard Errors
newey ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm, lag(6)
#Autocorrelation and Dynamic Models
regress ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm
estat dwatson
estat bgodfrey, lag(10)
# Testing for Non-Normality
sktest resid
histogram resid
#test for normality means H0= no normal
# if significant then normal
br
drop APR00DUM DEC00DUM
generate byte APR00DUM = Date==tm(2000m4)
generate byte DEC00DUM = Date==tm(2000m12)
regress ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm APR00DUM DEC00DUM
 predict new_resid, residuals
#10.7  Multicollinearity
correlate ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm
#The RESET Test for Functional Form
estat ovtest
# we cannot reject the null hypothesis that the model
#has no omitted variables. In other words, we do not find strong evidence that the chosen linear functional
#form of the model is incorrect.*/
# Stability Test
regress ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm APR00DUM DEC00DUM
estat sbknown, break(tm(1996m1))
# H0: no structural break
#we can reject the null hypothesis that the parameters are constant across the two subsamples at the 10% level.
regress ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm
estat sbsingle
# second way rolling windows method for sb
rolling _b _se, window(11) recursive saving(C:\Users\Mir\OneDrive - Higher Education Commission\A_myDatalit\Faisal Docs\Econometrics\ChrisBrookEco\stata_do_eco\rolling_wind_estimates.dta, replace) : regress ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm
use "C:\Users\Mir\OneDrive - Higher Education Commission\A_myDatalit\Faisal Docs\Econometrics\ChrisBrookEco\stata_do_eco\rolling_wind_estimates.dta", clear
 generate _b_ersandp_plus2SE = _b_ersandp + 2*  _se_ersandp
 generate _b_ersandp_minus2SE = _b_ersandp - 2*  _se_ersandp
tsset end
twoway (tsline _b_ersandp, lcolor(blue))
tsset end
twoway (tsline _b_ersandp, lcolor(blue)) (tsline _b_ersandp_plus2SE, lcolor(red) lpattern(dash)) (tsline _b_ersandp_minus2SE, lcolor(red) lpattern(dash))
use "C:\Users\Mir\OneDrive - Higher Education Commission\Documents\macro.dta", clear
regress ermsoft ersandp dprod dcredit dinflation dmoney dspread rterm
# estat sbcusum, level(95) or recursiv is also an option
