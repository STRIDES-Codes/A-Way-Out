*===============================================================================
*Merge data at State Level======================================================
use "$dataraw/us_state.dta", clear

merge 1:m state_code state_name using "$datatemp/cencus_pop_all"
	drop if _merge == 1
	drop _merge

merge m:m state_code state_name year using "$datatemp/cencus_realpercapinc_state"
	drop if _merge == 2
	drop _merge
	
merge m:m state_code state_name year using "$datatemp/cencus_employment_state"
	drop if _merge == 2
	drop _merge
	
merge m:m state_abbr year using "$datatemp/food_insecurity_state"
	drop if _merge ==2
	drop _merge

*drop *_name
	
keep if year >= 2018

compress
la data "US Population by State (FIPS Code)"
save "$datafinal/data_usa_demo", replace 
export excel using "$datafinal/data_usa_demo.xlsx", replace firstrow(variables)
export delimited using "$datafinal/data_usa_demo.csv", replace nolabel

log using "$datatemp/data_usa_demo.scml", replace
codebook
log close
translate	///
	"$datatemp/data_usa_demo.scml"	///
	"$datafinal/data_usa_demo_CODEBOOK.pdf", translator(smcl2pdf)
*===============================================================================

  
 







*===============================================================================
*Merge data with Race, Origin, Sex==============================================
use "$dataraw/us_state.dta", clear

merge 1:m state_code state_name using "$datatemp/cencus_pop_demo"
	drop if _merge == 1
	drop _merge
	
*drop *_name

keep if year >= 2018

compress
la data "US Population by State, Race, Sex and Origin  (FIPS Code)"
save "$datafinal/data_usa_demo&others", replace 
export excel using "$datafinal/data_usa_demo&others.xlsx", replace firstrow(variables)
export delimited using "$datafinal/data_usa_demo&others.csv", replace nolabel

log using "$datatemp/data_usa_demo&others.scml", replace
codebook
log close
translate	///
	"$datatemp/data_usa_demo&others.scml"	///
	"$datafinal/data_usa_demo&others_CODEBOOK.pdf", translator(smcl2pdf)
*===============================================================================



 