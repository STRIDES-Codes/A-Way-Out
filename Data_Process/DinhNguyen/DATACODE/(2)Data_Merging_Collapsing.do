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
	
merge m:m state_abbr using "$datatemp/food_insecurity_state"
	drop if _merge ==2
	drop _merge

merge m:m state_abbr using "$datatemp/poverty_state"
	drop if _merge ==2
	drop _merge
	 

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

merge 1:m state_code state_name using "$datatemp/data_usa_demo"
	drop if _merge == 1 
	drop _merge 
	
merge m:m state_code state_name year using "$datatemp/cencus_pop_demo_collapsed_age_race"
	drop if _merge == 1 // Puerto Rico
	drop _merge
	

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

merge 1:m state_code state_name using "$datatemp/data_usa_demo"
	drop if _merge == 1 // Guam, Marian Islands, Virgin
	drop _merge 
	
merge m:m state_code state_name year using "$datatemp/cencus_pop_demo_collapsed_age"
	drop if _merge == 1  // Puerto Rico
	drop _merge
	
merge m:m year state_name age_group using "$datatemp/comorbidities_obesity_BRFSS_age"
	*drop if _merge == 1 // New Jersy
	drop _merge
merge m:m year state_name age_group using "$datatemp/comorbidities_highblood_BRFSS_age"
	*drop if _merge == 1 // No 2018 data
	drop _merge 
merge m:m year state_name age_group using "$datatemp/comorbidities_diabetes_BRFSS_age"
	*drop if _merge == 1 // No 2018 data
	drop _merge 

order region_code region_name division_code division_name state_abbr state_code state_name year age	///
	povrate15 childpovrate15 obese_pct highbloodpress_pct diabetes_pct
	 
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

merge 1:m state_code state_name using "$datatemp/data_usa_demo"
	drop if _merge == 1
	drop _merge 
	
merge m:m state_code state_name year using "$datatemp/cencus_pop_demo_collapsed_race"
	drop if _merge == 1 // Guam, Northern Mariana Islands, Virgin Islands of the U.S.
	drop _merge
	
merge m:m year state_name race using "$datatemp/comorbidities_obesity_BRFSS_race"
	*drop if _merge == 1 // New Jersy
	drop _merge
merge m:m year state_name race using "$datatemp/comorbidities_highblood_BRFSS_race"
	*drop if _merge == 1
	drop _merge
merge m:m year state_name race using "$datatemp/comorbidities_diabetes_BRFSS_race"
	*drop if _merge == 1
	drop _merge
	 
order region_code region_name division_code division_name state_abbr state_code state_name year race	///
	povrate15 childpovrate15 obese_pct highbloodpress_pct diabetes_pct
	 
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


















import delimited using "$dataraw/CRDT Data - CRDT.csv", clear

loc i = 1
foreach X of varlist cases_* deaths_* hosp_* tests_* {
	ren `X' `X'_`i'
	loc i = `i' + 1
	if `i' == 14 {
		loc i = 1
	}
}
*

ren cases_*_* cases_*[2]
ren deaths_*_* deaths_*[2]
ren hosp_*_* hosp_*[2]
ren tests_*_* tests_*[2]

 
reshape long cases_ deaths_ hosp_ tests_, i(date state) j(race)

drop if race == 1
drop if race == 12
drop if race == 13
drop if race == 9
drop if race == 4
drop if race == 10

recode race	///
	(2 = 1) (3 = 2) (5 = 4) (6 = 3) (7 = 5) (8 = 6) (11 = 7)

	pro_lab
la val race lab_race
	
*1 Total
2 White
3 Black
4 Latinx
5 Asian
6 AIAN
7 NHPI
8 Multiracial
*9 Other
10 Unknown
11 Hispanic
*12 Non Hispanic
*13 Unknown

1 "White Alone"	///
2 "Black or African American Alone"	///
3 "American Indian or Alaska Native Alone"	///
4 "Asian Alone"	///
5 "Native Hawaiian and Other Pacific Islander Alone"	///
6 "Two or more races"	///
7 "Hispanic"