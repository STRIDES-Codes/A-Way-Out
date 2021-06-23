
*===============================================================================
*USA Population by state========================================================
*Information: NST-EST2019-alldata: Annual Population Estimates, Estimated Components of Resident Population Change, and Rates of the Components of Resident Population Change for the United States, States, and Puerto Rico: April 1, 2010 to July 1, 2019
*File: 7/1/2019 National and State Population Estimates
*Source: U.S. Census Bureau, Population Division
*Release Date: December 2019

import delimited using "$dataraw/nst-est2019-alldata.csv", clear

drop if name == "Puerto Rico"
destring region division, replace

drop census2010pop estimatesbase2010

reshape long popestimate npopchg_ births deaths naturalinc internationalmig domesticmig  netmig residual rbirth rdeath rnaturalinc rinternationalmig rdomesticmig rnetmig,	///
 i(sumlev region division state) j(year)

ren npopchg_ npopchg
 
la var popestimate "Resident total population estimate"
la var npopchg "Change in resident total population"
la var births "Births"
la var deaths "Deaths"
la var naturalinc "Natural increase"
la var internationalmig "Net international migration"
la var domesticmig  "Net domestic migration"
la var netmig "Net migration"
la var residual "Residual"
la var rbirth "Birth rate"
la var rdeath "Death rate"
la var rnaturalinc "Natural increase rate"
la var rinternationalmig "Net international migration rate"
la var rdomesticmig "Net domestic migration rate"
la var rnetmig "Net migration rate"

la var year "Year"

ren name state_name
ren state state_code

drop sumlev region division

drop if state_code == 0

save "$datatemp/cencus_pop_all", replace
*===============================================================================





*===============================================================================
*USA Population by state, sex, age and race=====================================
*Information: SC-EST2019-ALLDATA6: Annual State Resident Population Estimates for 6 Race Groups (5 Race Alone Groups and Two or More Races) by Age, Sex, and Hispanic Origin: April 1, 2010 to July 1, 2019
*File: 7/1/2019 State Characteristics Population Estimates
*Source: U.S. Census Bureau, Population Division
*Release Date: June 2020

import delimited using "$dataraw/sc-est2019-alldata6.csv", clear

drop if name == "Puerto Rico"
destring region division, replace

drop census2010pop estimatesbase2010

reshape long popestimate,	///
 i(sumlev region division state sex origin race age) j(year)

la var popestimate "Resident total population estimate"
 

la def lab_sex 0 "Total" 1 "Male" 2 "Female"
la def lab_origin 0 "Total" 1 "Not Hispanic" 2 "Hispanic"
la def lab_race 1 "White Alone" 2 "Black or African American Alone" 3 "American Indian or Alaska Native Alone" 4 "Asian Alone" 5 "Native Hawaiian and Other Pacific Islander Alone" 6 "Two or more races"

la val sex lab_sex
la val origin lab_origin
la val race lab_race

la var year "Year"

ren name state_name
ren state state_code

drop sumlev region division

drop if state_code == 0

save "$datatemp/cencus_pop_demo", replace
*===============================================================================
*===============================================================================
*Collapse demographics data=====================================================
use "$datatemp/cencus_pop_demo", clear

*Categorize age
gen age_group = .
la var age_group "Age group"
replace age_group = 1 if inrange(age,0,17)
replace age_group = 2 if inrange(age,18,49)
replace age_group = 3 if inrange(age,50,64)
replace age_group = 4 if inrange(age,65,100)

la def lab_age_group 1 "0-17" 2 "18-49" 3 "50-64" 4 "65+"
la val age_group lab_age_group

*Redefy race group
replace race = 4 if race == 5
la def lab_race 4 "Asian/Pacific Islander", modify

*Collapse data
collapse (sum) popestimate,	///
	by(year state_code state_name race age_group)

la var popestimate "Estimated population"
	
order state_code state_name year  age_group race 
	
compress
save "$datatemp/cencus_pop_demo_collapsed", replace
*===============================================================================





*===============================================================================
*Real Personal Income by state==================================================
*Bureau of Economic Analysis - U.S. Department of Commerce 
*Regional Economic Accounts
*https://apps.bea.gov/regional/downloadzip.cfm

import delimited using "$dataraw/SARPI_STATE_2008_2019.csv", clear

drop in 105/108
drop if linecode == 1
drop tablename linecode industryclassification description unit

drop if geoname == "Puerto Rico"
replace geofips = subinstr(geofips, `"""', "", 2)
destring region geofips, replace
replace geofips = geofips/1000

reshape long v, i(region geofips geoname) j(year)
ren v percap_real_inc
replace year = year + 1999

la var percap_real_inc "Real per capita income"

ren geoname state_name
ren geofips state_code

la var year "Year"

drop region

save "$datatemp/cencus_realpercapinc_state", replace
*===============================================================================






*===============================================================================
*Employment by state and sector=================================================
*Bureau of Economic Analysis - U.S. Department of Commerce
*Regional Economic Accounts
*https://apps.bea.gov/regional/downloadzip.cfm

import delimited using "$dataraw/CAEMP25N__ALL_AREAS_2001_2019.csv", clear
 
drop in 105535/105538
drop if linecode == 1
drop tablename   industryclassification unit
 

drop if geoname == "Puerto Rico"
replace geofips = subinstr(geofips, `"""', "", 2)
destring region geofips, replace

drop if geofips/1000 != round(geofips/1000)
drop if geofips>90000
drop if geofips==0
replace geofips = geofips/1000


reshape long v, i(region geofips geoname linecode description) j(year)
ren v employment
replace employment = "" if employment == "(D)"
destring employment, replace
replace year = year + 1992

drop description
ren employment employment_
reshape wide employment_, i(region geofips geoname year) j(linecode)


la var employment_10 "Total employment"
la var employment_20 "Wage and salary employment"
la var employment_40 "Proprietors employment"
la var employment_50 "Farm proprietors employment"
la var employment_60 "Nonfarm proprietors employment"
la var employment_70 "Farm employment"
la var employment_80 "Nonfarm employment"
la var employment_90 "Private nonfarm employment"
la var employment_100 "Forestry, fishing, and related activities"
la var employment_200 "Mining, quarrying, and oil and gas extraction"
la var employment_300 "Utilities"
la var employment_400 "Construction"
la var employment_500 "Manufacturing"
la var employment_600 "Wholesale trade"
la var employment_700 "Retail trade"
la var employment_800 "Transportation and warehousing"
la var employment_900 "Information"
la var employment_1000 "Finance and insurance"
la var employment_1100 "Real estate and rental and leasing"
la var employment_1200 "Professional, scientific, and technical services"
la var employment_1300 "Management of companies and enterprises"
la var employment_1400 "Administrative and support and waste management and remediation services"
la var employment_1500 "Educational services"
la var employment_1600 "Health care and social assistance"
la var employment_1700 "Arts, entertainment, and recreation"
la var employment_1800 "Accommodation and food services"
la var employment_1900 "Other services (except government and government enterprises)"
la var employment_2000 "Government and government enterprises"
la var employment_2001 "Federal civilian"
la var employment_2002 "Military"
la var employment_2010 "State and local"
la var employment_2011 "State government"
la var employment_2012 "Local government"

ren geoname state_name
ren geofips state_code

la var year "Year"

drop region

save "$datatemp/cencus_employment_state", replace
*===============================================================================







*===============================================================================
*
*U.S. Bureau of Labor Statistics - United States Department of Labor
*Local Area Unemployment Statistics
*Expanded State Employment Status Demographic Data
*https://www.bls.gov/lau/ex14tables.htm

forval year =15(1)20 {
	import excel using "$dataraw/table14full`year'.xlsx", clear
		drop in 1/7
		ren *, lower
		drop if b == ""
		
	foreach X in * {
	    destring `X', replace
	}
	*
	if inrange(`year',2015,2016) {
	    drop l m n
	}
	else if inrange(`year',2017,2019) {
	    drop l
	}
	*
		
	compress
	save "$datatemp/table14full`year'", replace
}
*
Civilian non-institutional population
Civilian labor force				
	Total	
	Percent of population
	Employed
		Total
		Percent of population
	Unemployed
		Total
		Rate


