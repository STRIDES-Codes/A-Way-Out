clear all

global project "C:\Users\NXDin\GitHub\STRIDES-Codes\A-Way-Out\DataProcess\DinhNguyen"

global dataraw "$project/DATARAW"
global datatemp "$project/DATATEMP"
global datafinal "$project/DATAFINAL"


pro pro_lab
	la def lab_sex 0 "Total" 1 "Male" 2 "Female"
	la def lab_origin 0 "Total" 1 "Not Hispanic" 2 "Hispanic"
	la def lab_race	///
		1 "White Alone"	///
		2 "Black or African American Alone"	///
		3 "American Indian or Alaska Native Alone"	///
		4 "Asian Alone"	///
		5 "Native Hawaiian and Other Pacific Islander Alone"	///
		6 "Two or more races"	///
		7 "Hispanic"
end

pro pro_lab_age_group
	la def lab_age_group	///
		1 "0-24"	///
		2 "25-34"	///
		3 "35-44"	///
		4 "45-54"	///
		5 "55-64"	///
		6 "65-74"	///
		7 "75-84"	///
		7 "85+"
end








