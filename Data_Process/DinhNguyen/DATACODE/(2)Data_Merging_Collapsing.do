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
	
keep if year >= 2017

order state_abbr state_code state_name year foodinsec_15_17

compress
la data "US Population by State (FIPS Code)"
save "$datatemp/data_usa_demo", replace 
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

*Race and Age=====================
use "$dataraw/us_state.dta", clear

merge 1:m state_code state_name using "$datatemp/cencus_pop_demo_collapsed_age_race"
	drop if _merge == 1
	drop _merge
	
*drop *_name
 

compress
la data "US Population by State, Race, Sex and Origin  (FIPS Code)"
save "$datatemp/data_usa_demo&age_race", replace 
export delimited using "$datafinal/data_usa_demo&age_race.csv", replace nolabel

log using "$datatemp/data_usa_demo&age_race.scml", replace
codebook
log close
translate	///
	"$datatemp/data_usa_demo&age_race.scml"	///
	"$datafinal/data_usa_demo&age_race_CODEBOOK.pdf", translator(smcl2pdf)
	
	
	
	
	

*Age only=========================
use "$dataraw/us_state.dta", clear

merge 1:m state_code state_name using "$datatemp/cencus_pop_demo_collapsed_age"
	drop if _merge == 1
	drop _merge
	
merge m:m year state_name age_group using "$datatemp/comorbidities_obesity_BRFSS_2017_age"
	drop if _merge == 1
	drop _merge
merge m:m year state_name age_group using "$datatemp/comorbidities_highblood_BRFSS_2017_age"
	drop if _merge == 1
	drop _merge 

compress
la data "US Population by State, Race, Sex and Origin  (FIPS Code)"
save "$datatemp/data_usa_demo&others", replace 
export delimited using "$datafinal/data_usa_demo&age.csv", replace nolabel

log using "$datatemp/data_usa_demo&age.scml", replace
codebook
log close
translate	///
	"$datatemp/data_usa_demo&age.scml"	///
	"$datafinal/data_usa_demo&age_CODEBOOK.pdf", translator(smcl2pdf)




*Race only
use "$dataraw/us_state.dta", clear

merge 1:m state_code state_name using "$datatemp/cencus_pop_demo_collapsed_race"
	drop if _merge == 1
	drop _merge
	
merge m:m year state_name race using "$datatemp/comorbidities_obesity_BRFSS_2017_race"
	drop if _merge == 1
	drop _merge
merge m:m year state_name race using "$datatemp/comorbidities_highblood_BRFSS_2017_race"
	drop if _merge == 1
	drop _merge
	 
compress
la data "US Population by State, Race, Sex and Origin  (FIPS Code)"
save "$datatemp/data_usa_demo&race", replace 
export delimited using "$datafinal/data_usa_demo&race.csv", replace nolabel

log using "$datatemp/data_usa_demo&race.scml", replace
codebook
log close
translate	///
	"$datatemp/data_usa_demo&race.scml"	///
	"$datafinal/data_usa_demo&race_CODEBOOK.pdf", translator(smcl2pdf)
*===============================================================================



 