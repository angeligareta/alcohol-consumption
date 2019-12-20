library(ggplot2)
library(tidyr)
if (!require(hexbin)) {
  install.packages("hexbin")
  library(hexbin) # cuberoot transformation
}

library(GGally)
library(randomForest)
library(caTools)
library(e1071)
library(caret)

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

income_dataset <-
  DataCombine::DropNA(dataset, Var = "MonthlyFamilyIncome")
cor(
  income_dataset$MonthlyFamilyIncome,
  income_dataset$AlcoholAmountAvgPerMonth,
  method = "pearson"
) #use = "complete.obs" to ingore nulls
#0.102 - low

cor(
  income_dataset$MonthlyFamilyIncome,
  income_dataset$AlcoholAmountAvgPerMonth,
  method = "spearman"
)
#0.16

cor(
  income_dataset$FamilyPovertyIndex,
  income_dataset$AlcoholAmountAvgPerMonth,
  method = "spearman"
)
#0.19

cor(
  income_dataset$PlayVideoGamesLast30d,
  income_dataset$AlcoholAmountAvgPerMonth,
  method = "spearman"
)

#Correlation matrix
dataset[] <- lapply(dataset, as.integer)
cor(dataset)

##########################################################

### Does Marital Status affect alcohol amount per month
dataset %>% ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonth)) + geom_bar(aes(fill = MaritalStatus), stat =
                                                                                      "identity")

## Add new variable with a ponderated mean per Marital Status category
dataset_with_alcohol_mean_marital_status <-
  dataset %>% group_by(MaritalStatus) %>% summarise(
    AlcoholAmountAvgPerMonthMean = mean(AlcoholAmountAvgPerMonth),
    NumberOfPeopleInMaritalStatus = length(AlcoholAmountAvgPerMonth),
    AlcoholAmountAvgPerMonthPonderatedMean = AlcoholAmountAvgPerMonthMean / NumberOfPeopleInMaritalStatus
  )
## Show mean per marital status group
dataset_with_alcohol_mean_marital_status %>%
  ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonthMean)) +
  geom_bar(aes(fill = MaritalStatus), stat = "identity") +
  geom_text(aes(label = "Nº People"), vjust = 2) +
  geom_text(aes(label = NumberOfPeopleInMaritalStatus),
            vjust = 4,
            color = "white")

## Show ponderated mean per marital status group
#dataset_with_alcohol_mean_marital_status %>%
#  ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonthPonderatedMean)) +
#  geom_bar(aes(fill = MaritalStatus), stat = "identity") +
#  geom_text(aes(label = NumberOfPeopleInMaritalStatus), vjust=2) +
#  geom_text(aes(label = format(round(AlcoholAmountAvgPerMonthMean, 2), nsmall = 2)), vjust=4, color="white")

## See Marital Status and SpendTimeBar7d
dataset %>%
  ggplot(aes(x = factor(1), y = ..count.., fill = MaritalStatus)) +
  geom_bar(stat = "count", position = "fill") +
  ggtitle("Spend Time In Bar in the last 7 days?") +
  theme(
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_blank()
  ) +
  coord_polar("y") +
  facet_wrap( ~ SpendTimeBar7d)

## Alcohol and Sex ----
## TODO: Handle NA values


# Relation beween mental situation, mental illnesses, economic situation and alcohol consumption ----

# Exploratory analisys.
ggplot(dataset,
       aes(x = ProblemsRememberingThingsLast30d, y = AlcoholAmountAvgPerMonth)) + geom_boxplot()

ggplot(
  dataset,
  aes(x = ProblemsRememberingThingsLast30d, y = AlcoholAmountAvgPerMonthCubeRoot)
) + geom_boxplot()

ggplot(dataset,
       aes(x = FeelDownDepressedLast2W, y = AlcoholAmountAvgPerMonth)) + geom_boxplot()

ggplot(dataset,
       aes(x = FeelDownDepressedLast2W, y = AlcoholAmountAvgPerMonthCubeRoot)) + geom_boxplot()

ggplot(dataset,
       aes(x = ProblemsConcentratingLast2w, y = AlcoholAmountAvgPerMonth)) + geom_boxplot()

ggplot(dataset,
       aes(x = ProblemsConcentratingLast2w, y = AlcoholAmountAvgPerMonthCubeRoot)) + geom_boxplot()

ggplot(dataset,
       aes(x = ThoughtSuicideLast2w, y = AlcoholAmountAvgPerMonth)) + geom_boxplot()

ggplot(dataset,
       aes(x = ThoughtSuicideLast2w, y = AlcoholAmountAvgPerMonthCubeRoot)) + geom_boxplot()

ggplot(dataset,
       aes(x = GreaterEqual35HoursWorkPerWeek, y = AlcoholAmountAvgPerMonth)) + geom_boxplot()

ggplot(
  dataset,
  aes(x = GreaterEqual35HoursWorkPerWeek, y = AlcoholAmountAvgPerMonthCubeRoot)
) + geom_boxplot()

ggplot(dataset,
       aes(x = SleepHoursWorkdays, y = AlcoholAmountAvgPerMonth)) + geom_point()

ggplot(dataset,
       aes(x = SleepHoursWorkdays, y = AlcoholAmountAvgPerMonthCubeRoot)) + geom_point()


ggplot(dataset,
       aes(x = SleepHoursWorkdays, y = AlcoholAmountAvgPerMonthCubeRoot)) + geom_point()

ggplot(dataset,
       aes(x = FamilyPovertyIndex, y = AlcoholAmountAvgPerMonth)) + geom_point()
ggplot(dataset, aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonth)) + geom_boxplot()

## Create and train the models.

train_dataset <- dataset %>% select(
  AlcoholAmountAvgPerMonth,
  ## Demographic variables.
  HighestEducationLevel,
  CountryBorn,
  NoPeopleFamily,
  MaritalStatus,
  Gender,
  Age,
  # Mental variables.
  DifficultyConcentrating,
  ProblemsRememberingThingsLast30d,
  FeelDownDepressedLast2W,
  ProblemsConcentratingLast2w,
  ThoughtSuicideLast2w,
  GreaterEqual35HoursWorkPerWeek
)

# treat na in independent variables.
train_dataset <- na.omit(train_dataset)

cvControl <- caret::trainControl(method = "cv", number = 10)
dtGrid <- expand.grid(cp = seq(0, 0.4, 0.01))

fit_dt_grid <- caret::train(
  x = train_dataset %>% select(-AlcoholAmountAvgPerMonth),
  y = train_dataset$AlcoholAmountAvgPerMonth,
  method = "rpart",
  trControl = cvControl,
  tuneGrid = dtGrid
)

# summarize the fit
summary(fit_dt_grid)

## ??? ----

# STEFANO
# Looking for correlation between alcohol and drugs

# Exploratory analisys.
dataset %>% ggplot(aes(x = SmokedCigsLast30d,
                       y = AlcoholAmountAvgPerMonth)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

dataset %>% ggplot(aes(x = MarijuanaLast30d,
                       y = AlcoholAmountAvgPerMonth)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

dataset %>% ggplot(aes(x = CocaineLast30d,
                       y = AlcoholAmountAvgPerMonth)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

dataset %>% ggplot(aes(x = HeroineLast30d,
                       y = AlcoholAmountAvgPerMonth)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

# See if people that uses any kind of drugs also drink more than those that doesn't
# Creating small dataset with alcohol and drugs
dataset_drug <- dataset %>% select("AlcoholAmountAvgPerMonth", "SmokedCigsLast30d", "MarijuanaLast30d", "CocaineLast30d", "HeroineLast30d")

# turning drugs from range of values to True and False
vars.to.replace <- 
  c("MarijuanaLast30d", 
    "CocaineLast30d", 
    "HeroineLast30d", 
    "SmokedCigsLast30d")
df2 <- dataset_drug[vars.to.replace]
df2[!is.na(df2)] <- TRUE
df2[is.na(df2)] <- FALSE
dataset_drug[vars.to.replace] <- df2

# Add a general column: people have used any kind of drugs in the last 30d
dataset_drug$DrugLast30d <- 
  (
    dataset_drug$MarijuanaLast30d | 
      dataset_drug$CocaineLast30d | dataset_drug$HeroineLast30d
  )

# Same as before but it takes into account also Cigarettes
dataset_drug$Drug_CigsLast30d <- 
  (
    dataset_drug$MarijuanaLast30d | 
      dataset_drug$CocaineLast30d | 
      dataset_drug$HeroineLast30d | dataset_drug$SmokedCigsLast30d)

# Mean of average alcohol consumption per month of the people who do and don't do drug
meanAlcoholAmountAvgPerMonth_dodrugs <- 
  dataset_drug %>% 
  filter(DrugLast30d == T) %>% 
  summarize(mean(AlcoholAmountAvgPerMonth))

meanAlcoholAmountAvgPerMonth_dontdrugs <- 
  dataset_drug %>% 
  filter(DrugLast30d == F) %>% 
  summarize(mean(AlcoholAmountAvgPerMonth))

# Mean of average alcohol consumption per month of the people who do and don't do drug including cigarettes
meanAlcoholAmountAvgPerMonth_dodrugs_cig <- 
  dataset_drug %>% 
  filter(Drug_CigsLast30d == T) %>% 
  summarize(mean(AlcoholAmountAvgPerMonth))

meanAlcoholAmountAvgPerMonth_dontdrugs_cig <- 
  dataset_drug %>% 
  filter(Drug_CigsLast30d == F) %>% 
  summarize(mean(AlcoholAmountAvgPerMonth))

# Alcohol consumption of people who do drugs vs those who don't 
df <- data.frame(DrugLast30d = c("DoDrugs", "DontDoDrugs"), 
                 MeanAlcoholAmountAvgPerMonth = c(meanAlcoholAmountAvgPerMonth_dodrugs[[1]], 
                                                  meanAlcoholAmountAvgPerMonth_dontdrugs_cig[[1]]))

ggplot(df, aes(x = DrugLast30d, y = MeanAlcoholAmountAvgPerMonth)) + 
  geom_col() + labs(x = "Drug usage", y = "Average monthly alcohol consumption")

# Alcohol consumption of people who do drugs including cigarettes vs those who don't 
df_cigs <- data.frame(DrugLast30d = c("DoDrugs", "DontDoDrugs"), 
                      MeanAlcoholAmountAvgPerMonth = c(meanAlcoholAmountAvgPerMonth_dodrugs_cig[[1]], 
                                                       meanAlcoholAmountAvgPerMonth_dontdrugs_cig[[1]]))

ggplot(df_cigs, aes(x = DrugLast30d, y = MeanAlcoholAmountAvgPerMonth)) + 
  geom_col() + labs(x = "Drug usage", y = "Average monthly alcohol consumption")
