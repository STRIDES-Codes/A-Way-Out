setwd("~/scratch")
library(dplyr)

df_raw <- read_csv("2017_BRFSS_HTN_OBESITY_DIABETES.csv")

df_raw %>% names()

df_selected <- df_raw %>% select(Year,Locationabbr,Locationdesc,Class,Topic,Question,Response,Break_Out_Category,Break_Out, Sample_Size,Data_value,Data_value_unit,Confidence_limit_Low,Confidence_limit_High)

# Diabetes
df_diabetes <- df_selected %>% filter(Topic == "Diabetes")
df_diabetes_final <- df_diabetes %>% 
  filter(Response == "Yes") %>% 
  arrange(Locationabbr,Class,Topic,Break_Out,Break_Out_Category)

write.csv(df_diabetes_final,"comorbidities_diabetes_BRFSS_2017.csv",row.names = FALSE)

# Obesity
df_obesity <- df_selected %>% filter(Class == "Overweight and Obesity (BMI)")
df_obesity_final <- df_obesity %>% 
  filter(Response == "Obese (bmi 30.0 - 99.8)") %>%
  arrange(Locationabbr,Class,Topic,Break_Out,Break_Out_Category)

write.csv(df_obesity_final,"comorbidities_obesity_BRFSS_2017.csv",row.names = FALSE)

# Hypertension
df_HTN <- df_selected %>% 
  filter(Topic =="High Blood Pressure")

df_HTN_final <- df_HTN %>% 
  filter(Topic =="High Blood Pressure") %>%
  arrange(Locationabbr,Class,Topic,Break_Out,Break_Out_Category)

write.csv(df_HTN_final,"comorbidities_hypertension_BRFSS_2017.csv",row.names = FALSE)










# scratch below
# # Diabetes
# df_diabetes <- df_selected %>% filter(Topic == "Diabetes")
# df_diabetes_final <- df_diabetes %>%
#   filter(Response == c("Yes", "No", "No, pre-diabetes or borderline diabetes")) %>%
#   mutate(Response = replace(Response, Response == "No, pre-diabetes or borderline diabetes", "No")) %>%
#   arrange(Locationabbr,Class,Topic,Break_Out,Break_Out_Category)