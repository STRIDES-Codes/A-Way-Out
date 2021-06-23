use "$datafinal/data_usa_demo&others", clear


 
egen popestimate_total = sum(popestimate), by(state_code   year age)
gen popestimate_percent = popestimate/popestimate_total*100

set scheme s1color
graph bar popestimate_percent if race!= 1, 	///
	over(race, sort(1) label(labs(small) angle(45)))	///
	over(year, label(labs(small) alt))	///
	over(age_group)	///
	legend(size(small))	///
	ytitle("Percent of total population")
graph export "$datafinal/graph_pop_minorities.png", as(png)



*===============================================================================
*Map for United States of America===============================================
use "$datafinal/data_usa_demo&others", clear
 
 keep if year == 2019
 
 
 collapse (sum) popestimate, by(state_name race)
 
 keep state_name popestimate race 
 
 sort race  state 
 
 
egen popestimate_total = sum(popestimate), by(state_name)
gen popestimate_percent = popestimate/popestimate_total*100

format popestimate_percent %12.1f
browse state_name race popestimate_percent