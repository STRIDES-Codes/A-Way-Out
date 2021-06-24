<h1 style="color:blue;"> <b>A Way Out</b>: Pandemic preparedness in context of health disparities to limit disproportionate morbidity and mortality</h1>

##### Authors: Lead: Udana Torian - SysAdmin: Shreya Shah - Writers: Ashley Bamfo, Dinh Nguyen, Vincent La

## Why pandemic preparedness?
Since the beginning of the COVID-19 pandemic, the disproportionate impact on BIPOC (Black and Indigenous People of Color) communities has been catastrophic. Generations of health disparities manifest in wide-spread co-morbidities such as hypertension, obesity, and diabetes(1) have made these communities extremely vulnerable. Compounding the problem is the often lack of adequate medical resources within the community. All of these factors have created a preparedness vacuum leaving the most vulnerable of society exposed, infected, and dead.

## Our approach
In an effort to address these health disparities in pandemic preparedness, we aim to assist in deciding where and how to distribute resources equitably by constructing a composite impact score to assess which communities may be more vulnerable to the impacts of the COVID pandemic.

## Methods:
In building an index to predict community vulnerability, this project will integrate demographic, comorbidity, population density and social determinants of health data from various data sources. A linear regression model was utilized on this integrated dataset to determine the most <predictive / impactful> features of the data: <variable 1 and variable 2, etc>. After testing the data on a validation set and evaluating the model's accuracy, we constructed an index ____ to describe a community’s vulnerability. 

### Data Sources:
Demographics
+ <a href="https://www.census.gov/topics/population/age-and-sex/data/tables.html">USA Population by State, Sex, Age and Race by U.S. Census Bureau, Population Division</a>

Comorbidities
+ <a href="https://chronicdata.cdc.gov/Behavioral-Risk-Factors/Behavioral-Risk-Factor-Surveillance-System-BRFSS-P/dttw-5yxu/data">Behavioral Risk Factors Surveillance System (BRFSS) from CDC</a>

Social Determinants of Health
+ <a href="https://apps.bea.gov/regional/downloadzip.cfm">Real Personal Income by state from U.S. Department of Commerce</a>
+ <a href="https://apps.bea.gov/regional/downloadzip.cfm">Employment by state and sector from U.S. Department of Commerce</a>

### Outcome
Mortality and morbidity of minority populations in the U.S. (cases and deaths).

### Study variables
These variables included comorbidities of a presence of hypertension, obesity, or diabetes diagnosis. 

### Technologies:
Programming
+ Jupyter Notebook
+ Python
+ Pandas
+ NumPy
+ Matplotlib
+ Seaborn 
+ Copy
+ Json
+ RStudio
+ dplyr
+ STATA

## Workflow
![A Way Out Flow Diagram](https://user-images.githubusercontent.com/40073377/123298954-e462da80-d4cd-11eb-91c8-a8fc8415f5d9.png)


## Output:
_____IMAGE OF SCORE / MAGNITUDE OF CORRELATION_____

## Planned Features
1. Build a UI for streamlining data input.
2. Develop more granularity for county/district-level vulnerabilty information.
3. Integration of more study variables.

## Limitations
State-level data has it's limitations in helping decision-making at the national level. Data sources such as BRFSS are limited to participants who are able to respond via landline or cellphone line due to the nature of the data collection methods.

## References and Resources
<ol>1.  Arasteh K. (2020). Prevalence of Comorbidities and Risks Associated with COVID-19 Among Black and Hispanic Populations in New York City: an Examination of the 2018 New York City Community Health Survey. Journal of racial and ethnic health disparities, 1–7. Advance online publication. https://doi.org/10.1007/s40615-020-00844-1</ol>
