library(ggplot2)
library(tidyr)
if(!require(hexbin)){
  install.packages("hexbin")
  library(hexbin) # cuberoot transformation
}

library(GGally)

source("./preprocessing/preprocess.R")

# Show summary of preprocessed dataset
summary(preprocessed_dataset)
head(preprocessed_dataset)

# Use preprocessed dataset as main one
dataset <- preprocessed_dataset

# Start with researches related with alcohol

## Some general plots
### Age distribution
dataset %>% ggplot(aes(x = Age))  + geom_histogram()

### AlcoholAmountAvgPerMonth distribution
dataset %>% ggplot(aes(x = AlcoholAmountAvgPerMonth))  + geom_histogram()

### MonthlyFamilyIncome distribution
dataset %>% ggplot(aes(x = MonthlyFamilyIncome))  + geom_histogram()

#########################################################
##Some correlation coefficients
age_dataset <- DataCombine::DropNA(dataset, Var = "Age")
#datatypes
sapply(dataset, class)

cor(dataset$Age, dataset$AlcoholAmountAvgPerMonth, method = "pearson")
#0.049 - low

cor(dataset$Age, dataset$AlcoholAmountAvgPerMonth, method = "spearman")
#-0.145

income_dataset <- DataCombine::DropNA(dataset, Var = "MonthlyFamilyIncome")
cor(income_dataset$MonthlyFamilyIncome, income_dataset$AlcoholAmountAvgPerMonth, method = "pearson") #use = "complete.obs" to ingore nulls
#0.102 - low

cor(income_dataset$MonthlyFamilyIncome, income_dataset$AlcoholAmountAvgPerMonth, method = "spearman")
#0.16

cor(income_dataset$FamilyPovertyIndex, income_dataset$AlcoholAmountAvgPerMonth, method = "spearman")
#0.19

cor(income_dataset$PlayVideoGamesLast30d, income_dataset$AlcoholAmountAvgPerMonth, method = "spearman")

#Correlation matrix
dataset[] <- lapply(dataset,as.integer)
cor(dataset)

##########################################################

### Does Marital Status affect alcohol amount per month
dataset %>% ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonth)) + geom_bar(aes(fill = MaritalStatus), stat="identity")

## Add new variable with a ponderated mean per Marital Status category 
dataset_with_alcohol_mean_marital_status = dataset %>% group_by(MaritalStatus) %>% summarise(
  AlcoholAmountAvgPerMonthMean = mean(AlcoholAmountAvgPerMonth),
  NumberOfPeopleInMaritalStatus = length(AlcoholAmountAvgPerMonth),
  AlcoholAmountAvgPerMonthPonderatedMean = AlcoholAmountAvgPerMonthMean / NumberOfPeopleInMaritalStatus
)
## Show mean per marital status group
dataset_with_alcohol_mean_marital_status %>% 
  ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonthMean)) + 
  geom_bar(aes(fill = MaritalStatus), stat = "identity") + 
  geom_text(aes(label = "Nº People"), vjust=2) +
  geom_text(aes(label = NumberOfPeopleInMaritalStatus), vjust=4, color = "white")

## Show ponderated mean per marital status group
#dataset_with_alcohol_mean_marital_status %>% 
#  ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonthPonderatedMean)) + 
#  geom_bar(aes(fill = MaritalStatus), stat = "identity") + 
#  geom_text(aes(label = NumberOfPeopleInMaritalStatus), vjust=2) +
#  geom_text(aes(label = format(round(AlcoholAmountAvgPerMonthMean, 2), nsmall = 2)), vjust=4, color="white")

## See Marital Status and SpendTimeBar7d
dataset %>% 
  ggplot(aes(x = factor(1), y = ..count.., fill = MaritalStatus)) + 
  geom_bar(stat="count", position = "fill") +
  ggtitle("Spend Time In Bar in the last 7 days?") +
  theme(axis.text.x=element_blank(),
        axis.ticks=element_blank(),
        axis.title.y=element_blank(),
        axis.title.x=element_blank()) + 
  coord_polar("y") +
  facet_wrap(~SpendTimeBar7d)

## Alcohol and Sex ----
## TODO: Handle NA values


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
  geom_point(mapping = aes(x = MonthlyFamilyIncome, y = AlcoholAmountAvgPerMonth))
