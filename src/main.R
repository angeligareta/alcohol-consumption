library(ggplot2)
library(tidyr)

library(hexbin)
library(GGally)

source("./preprocessing/preprocess.R")

# Show summary of preprocessed dataset
summary(preprocessed_dataset)

# Use preprocessed dataset as main one
dataset <- preprocessed_dataset

# Start with researches related with alcohol

###############################################################
###############################################################

##Checking some distributions
dataset %>% ggplot(aes(x = HighestEducationLevel))  + geom_histogram() #ok
dataset %>% ggplot(aes(x = MaritalStatus))  + geom_histogram()
barplot(sort(table(dataset$Gender))) #good
dataset %>% ggplot(aes(x = DifficultyConcentrating))  + geom_histogram()
dataset %>% ggplot(aes(x = ThoughtSuicideLast2w))  + geom_histogram()
dataset %>% ggplot(aes(x = MonthlyFamilyIncome))  + geom_histogram() #ok
dataset %>% ggplot(aes(x = FamilyPovertyIndex))  + geom_histogram()
dataset %>% ggplot(aes(x = SmokedCigsLast30d))  + geom_histogram()
dataset %>% ggplot(aes(x = Age))  + geom_histogram()
dataset %>% ggplot(aes(x = AlcoholAmountAvg))  + geom_histogram()



###############################################################
###############################################################

## Alcohol and Sex ----
## TODO: Handle NA values
dataset %>% ggplot(aes(x = Age, y = AlcoholAmountAvgPerMonthCubeRoot))  + geom_boxplot(aes(color = MaritalStatus))


# Relation beween mental situation, mental illnesses, economic situation and alcohol consumption ----

## ??? ----

# STEFANO
# alcohol related variable: SpendTimeBar7d, AlcoholDrink5Last30d, AlcoholAmountAvgPerMonth, AlcoholAmountAvgPerMonth
# Looking for correlation between alcohol and drugs

dataset %>% ggplot(aes(x = SmokedCigsLast30d,

                       y = AlcoholDrink5Last30d)) +
  geom_hex()

dataset %>% ggplot(aes(x = MarijuanaLast30d,
                       y = AlcoholDrink5Last30d)) +
  geom_hex() +
  geom_smooth(method = lm, se = FALSE)

dataset %>% ggplot(aes(x = CocaineLast30d,
                       y = AlcoholDrink5Last30d)) +
  geom_hex() +
  geom_smooth(method = lm, se = FALSE)

# useless
dataset %>% ggplot(aes(x = HeroineLast30d,
                       y = AlcoholDrink5Last30d)) +
  geom_point()

# See if people that drinks uses also some kind of drugs

# creating a dataset turning drug usage from a range of value to True and False
dataset_drug <- dataset
vars.to.replace <- c("MarijuanaLast30d", "CocaineLast30d", "HeroineLast30d", "SmokedCigsLast30d")
df2 <- dataset_drug[vars.to.replace]
df2[!is.na(df2)] <- TRUE
df2[is.na(df2)] <- FALSE
dataset_drug[vars.to.replace] <- df2

# View(dataset_drug)

# Add a general column: people have used any kind of drugs in the last 30d
dataset_drug$DrugLast30d <- (dataset_drug$MarijuanaLast30d | dataset_drug$CocaineLast30d | dataset_drug$HeroineLast30d)

# Same as before but it takes into account also Cigarettes
dataset_drug$Drug_CigsLast30d <- (dataset_drug$MarijuanaLast30d | dataset_drug$CocaineLast30d | dataset_drug$HeroineLast30d | dataset_drug$SmokedCigsLast30d)

ggplot(data = dataset_drug, aes(x = DrugLast30d, y = AlcoholDrink5Last30d)) +
  geom_bar(stat = "identity", width = 0.5)

ggplot(data = dataset_drug, aes(x = Drug_CigsLast30d, y = AlcoholDrink5Last30d)) +
  geom_bar(stat = "identity", width = 0.5)

# Looking for correlations between drugs
df <- dataset %>% select('AlcoholDrink5Last30d', 'SmokedCigsLast30d', 'MarijuanaLast30d', 'CocaineLast30d', 'HeroineLast30d')
ggpairs(df)

# Looking for correlation between income and alcohol consumption
df_2 <- dataset %>% select('AlcoholDrink5Last30d', 'MonthlyFamilyIncome', 'FamilyPovertyIndex')
ggpairs(df_2)

# Looking if income affects Alcohol consumption
ggplot(data = dataset) +
  geom_hex(mapping = aes(x = MonthlyFamilyIncome, y = AlcoholDrink5Last30d))

ggplot(data = dataset) +
  geom_hex(mapping = aes(x = MonthlyFamilyIncome, y = AlcoholAmountAvgPerMonth))
