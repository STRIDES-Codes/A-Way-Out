setwd("~/scratch")
library(dplyr)

# create dataset of Hypertension, Obesity, Diabetes for COVID patients 2020

# import CDC data
df_raw <- read.csv("CDC_Conditions_Contributing_to_COVID-19_Deaths__by_State_and_Age.csv", na.strings = c("","NA"))

# select variables
df_of_interest <- df_raw %>% select("Group","Year","State","Condition","Age.Group","COVID.19.Deaths","Number.of.Mentions")

# filter for [Year, 2020, Conditions]
df_filtered <- df_of_interest %>% filter(Year == "2,020", 
                          Condition %in% c("Diabetes","Hypertensive diseases","Obesity"), 
                          Group == "By Year", 
                          State != "United States"
                          )
# convert to numbers
df_filtered$COVID.19.Deaths <- as.numeric(df_filtered$COVID.19.Deaths)
df_filtered$Number.of.Mentions <- as.numeric(df_filtered$Number.of.Mentions)

# remove commas
df_filtered$Year <- as.numeric(gsub(",","",df_filtered$Year))

# spread / pivot
library(tidyr)
df_spread <- df_filtered %>% spread(Condition, COVID.19.Deaths)
df_spread <- df_filtered %>% pivot_wider(
  names_from = c(Condition),
  values_from = c(COVID.19.Deaths, Number.of.Mentions)
)

write.csv(df_spread, "Comorbidities_Mortality_CDC_2020.csv")

# explore
df_spread %>% summary()

# amount of NA's for 0-24
df_spread %>% 
  select(Age.Group
         ,`COVID.19.Deaths_Hypertensive diseases`
         ,COVID.19.Deaths_Diabetes
         ,COVID.19.Deaths_Obesity
         ,`Number.of.Mentions_Hypertensive diseases`
         ,Number.of.Mentions_Diabetes
         ,Number.of.Mentions_Obesity) %>% 
  filter(Age.Group == "0-24") %>% summary()

df_spread_selected <- df_spread %>% 
  select(
         `COVID.19.Deaths_Hypertensive diseases`
         ,COVID.19.Deaths_Diabetes
         ,COVID.19.Deaths_Obesity
         ,`Number.of.Mentions_Hypertensive diseases`
         ,Number.of.Mentions_Diabetes
         ,Number.of.Mentions_Obesity)






# create a template for compare_summary_table
sum1 <- do.call(cbind, lapply(df_spread_selected, summary))
compare_summary_table <- cbind(sum1)

# loop for each one testing
# create list for each
listOfAgeGroups <- unique(df_spread$Age.Group)
listOfAgeGroupsDFs <- paste0("df_",listOfAgeGroups)

# loop
for (i in 1:10) {
  print(i)
  DF <- df_spread %>% 
    filter(Age.Group == listOfAgeGroups[i]) %>%
    select(`COVID.19.Deaths_Hypertensive diseases`
           ,COVID.19.Deaths_Diabetes
           ,COVID.19.Deaths_Obesity
           ,`Number.of.Mentions_Hypertensive diseases`
           ,Number.of.Mentions_Diabetes
           ,Number.of.Mentions_Obesity)
  print(paste0("df_",listOfAgeGroups[i]))
  assign(listOfAgeGroupsDFs[i], do.call(cbind, lapply(DF, summary)))
  print(listOfAgeGroupsDFs[i])
  # use get to call variable from string
  summaryDF <- as.data.frame(get(listOfAgeGroupsDFs[i]))
  names(summaryDF) <- paste(names(summaryDF), listOfAgeGroups[i],sep=".")
  compare_summary_table <- cbind(compare_summary_table,summaryDF)
}

write.csv(compare_summary_table,"compare_summary_table.csv")



# impute
df_spread_selected

install.packages("devtools")
library(devtools)
install_github( "decisionpatterns/tidyimport")
impute(df_spread_selected)


## scratch below

install.packages("mlr")
library(mlr)
install.packages('tidyimpute')

df_spread %>% 
  select(Age.Group
         ,`COVID.19.Deaths_Hypertensive diseases`
         ,COVID.19.Deaths_Diabetes
         ,COVID.19.Deaths_Obesity
         ,`Number.of.Mentions_Hypertensive diseases`
         ,Number.of.Mentions_Diabetes
         ,Number.of.Mentions_Obesity) %>% 
  filter(Age.Group == "0-24") %>% summary()


assign("sum1",do.call(cbind, lapply(df_24, summary)))
sum1 <- as.data.frame(sum1)
names(sum1) <- paste(names(sum1),"0-24",sep=".")


assign("sum2",do.call(cbind, lapply(df_spread, summary)))

sum1 <- do.call(cbind, lapply(df_spread, summary))
compare_summary_table <- cbind(sum1)







# loop each one
listOfAgeGroups <- unique(df_spread$Age.Group)
for (i in listOfAgeGroups) {
  DF <- df_spread %>% 
    select(Age.Group
           ,`COVID.19.Deaths_Hypertensive diseases`
           ,COVID.19.Deaths_Diabetes
           ,COVID.19.Deaths_Obesity
           ,`Number.of.Mentions_Hypertensive diseases`
           ,Number.of.Mentions_Diabetes
           ,Number.of.Mentions_Obesity) %>% 
    filter(Age.Group == i) %>% summary()
  
  assign(paste("",i,sep=""),data.frame(DF=matrix(DF),row.names=names(DF)))
  do.call(cbind, i)
}
typeof(do.call(cbind, lapply(df_spread, summary)))

DF <- data.frame(var=matrix(var),row.names=names(var))
