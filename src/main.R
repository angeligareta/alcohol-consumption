library(dplyr)
library(tidyverse)
library(tidyr)
if (!require(hexbin)) {
  install.packages("hexbin")
  library(hexbin)
}
if (!require(GGally)) {
  install.packages("GGally")
  library(GGally)
}
if (!require(randomForest)) {
  install.packages("randomForest")
  library(randomForest)
}
if (!require(caTools)) {
  install.packages("caTools")
  library(caTools) 
}
if (!require(e1071)) {
  install.packages("e1071")
  library(e1071)
}
if (!require(caret)) {
  install.packages("caret")
  library(caret)
}
if (!require(ggthemes)){
  install.packages("ggthemes")
  library(ggthemes)
}
library(ggplot2)

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
#transform to be able to do the matrix
dataset[] <- lapply(dataset, as.integer)
cor(dataset)
dataset <- preprocessed_dataset #retransforn
##########################################################

### Does Marital Status affect alcohol amount per month

#Total amount - misleading since the dataset contains more data on married people than the other groups
dataset %>% ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonth)) + geom_bar(aes(fill = MaritalStatus), stat =
                                                                                      "identity")

## Add new variable with a ponderated mean per Marital Status category
dataset_with_alcohol_mean_marital_status <-
  transformed_dataset %>% filter(MaritalStatus != "NA") %>% group_by(MaritalStatus) %>% summarise(
    AlcoholAmountAvgPerMonthMean = mean(AlcoholAmountAvgPerMonth),
    NumberOfPeopleInMaritalStatus = length(AlcoholAmountAvgPerMonth),
    AlcoholAmountAvgPerMonthPonderatedMean = mean(AlcoholAmountAvgPerMonth) / length(AlcoholAmountAvgPerMonth)
  )


## Show alcohol consumption mean per marital status group
dataset_with_alcohol_mean_marital_status %>%
  ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonthMean)) +
  geom_bar(aes(fill = MaritalStatus), stat = "identity") #+
  # geom_text(aes(label = "Nº People"), vjust = 2) +
  # geom_text(aes(label = NumberOfPeopleInMaritalStatus), vjust = 4, color = "white")

## Show alcohol consumption mean per marital status group
dataset_with_alcohol_mean_marital_status %>%
  ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonthMean)) +
  geom_bar(aes(fill = MaritalStatus), stat = "identity")


## Show ponderated mean per marital status group
#The fact that the dataset contains more data on married people affects the results
#dataset_with_alcohol_mean_marital_status %>%
#  ggplot(aes(x = MaritalStatus, y = AlcoholAmountAvgPerMonthPonderatedMean)) +
#  geom_bar(aes(fill = MaritalStatus), stat = "identity") +
#  geom_text(aes(label = NumberOfPeopleInMaritalStatus), vjust=2) +
#  geom_text(aes(label = format(round(AlcoholAmountAvgPerMonthMean, 2), nsmall = 2)), vjust=4, color="white")

## See Marital Status and SpendTimeBar7d (Pie chart)
dataset_without_na_marital_status <- dataset %>% filter(MaritalStatus != "NA")
dataset_without_na_marital_status %>%
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

## See Marital Status and SpendTimeBar7d Per SpendTimeBar7d (Stacked Bar)
dataset_without_na_marital_status %>%
  ggplot(aes(x = factor(1), fill = MaritalStatus)) +
  geom_bar(stat = "count", position = "stack") +
  ggtitle("Spend Time In Bar in the last 7 days?") +
  theme(
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_blank()
  ) +
  facet_wrap( ~ SpendTimeBar7d)

## See Marital Status and SpendTimeBar7d Per Marital Status (Stacked Bar)
dataset_without_na_marital_status %>%
  ggplot(aes(x = factor(1), fill = SpendTimeBar7d)) +
  geom_bar(stat = "count", position = "stack") +
  ggtitle("Spend Time In Bar in the last 7 days?") +
  facet_grid( ~ MaritalStatus, switch="both") +
  theme_minimal() +
  scale_fill_brewer(palette = "Reds") +
  fancy_plot

## See Marital Status and SpendTimeBar7d Per Marital Status (Stacked Bar) ALl 100%
dataset_without_na_marital_status %>%
  ggplot(aes(x = factor(1), fill = SpendTimeBar7d)) +
  geom_bar(stat = "count", position = "fill") +
  ggtitle("Spend Time In Bar in the last 7 days?") +
  facet_wrap( ~ MaritalStatus, switch="both") +
  theme_minimal() +
  scale_fill_brewer(palette = "Reds") +
  fancy_plot

## Alcohol and Sex ----




# Relation beween mental situation, mental illnesses, economic situation and alcohol consumption ----

# Exploratory analisys.
ggplot(dataset,
       aes(x = ProblemsRememberingThingsLast30d, y = AlcoholAmountAvgPerMonth)) + geom_boxplot(outlier.size = 0)

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

dataset %>% 
  filter(ThoughtSuicideLast2w != "NA") %>% 
  ggplot(aes(x = ThoughtSuicideLast2w, y = AlcoholAmountAvgPerMonthCubeRoot, fill = ThoughtSuicideLast2w)) + 
  geom_boxplot() + 
  ggtitle("Alcohol Consumption per month cube Root - Thought about suicide") + 
  theme_minimal() +
  fancy_plot_no_legend

dataset %>% 
  filter(FeelDownDepressedLast2W != "NA") %>% 
  ggplot(aes(x = FeelDownDepressedLast2W, y = AlcoholAmountAvgPerMonthCubeRoot, fill = FeelDownDepressedLast2W)) + 
  geom_boxplot() + 
  ggtitle("Alcohol Consumption per month cube Root - Feel Down or Depressed") + 
  theme_minimal() +
  fancy_plot_no_legend

ggplot(dataset,
       aes(x = ThoughtSuicideLast2w, y = AlcoholAmountAvgPerMonth)) + geom_boxplot()

dataset %% ggplot(aes(x = ThoughtSuicideLast2w, y = AlcoholAmountAvgPerMonthCubeRoot)) + geom_boxplot()

ggplot(dataset,
       aes(x = GreaterEqual35HoursWorkPerWeek, y = AlcoholAmountAvgPerMonth)) + geom_boxplot()

ggplot(
  dataset,
  aes(x = GreaterEqual35HoursWorkPerWeek, y = AlcoholAmountAvgPerMonthCubeRoot)
) + geom_boxplot()

ggplot(dataset,
       aes(x = SleepHoursWorkdays)) + geom_density(fill = "brown", alpha = 0.55)

ggplot(dataset,
       aes(x = SleepHoursWorkdays, y = AlcoholAmountAvgPerMonth)) + geom_point()

ggplot(dataset,
       aes(x = SleepHoursWorkdays, y = AlcoholAmountAvgPerMonthCubeRoot)) + geom_point()

ggplot(dataset,
       aes(x = SleepHoursWorkdays, y = AlcoholAmountAvgPerMonthCubeRoot)) + geom_point()

ggplot(dataset,
       aes(x = FamilyPovertyIndex)) + geom_density()

ggplot(dataset,
       aes(x = FamilyPovertyIndex, y = AlcoholAmountAvgPerMonth)) + geom_point()

ggplot(dataset, aes(x = SpendTimeBar7d)) + geom_histogram(aes(color = FamilyPovertyIndex))

dataset %>%
  ggplot(aes(x = FamilyPovertyIndex, fill = SpendTimeBar7d)) +
  geom_density(alpha= 0.5) + 
  ggtitle("Poverty Index - Time in Bar") + 
  theme_minimal() +
  fancy_plot

dataset %>% 
  ggplot(aes(x = DifficultyConcentrating, y = AlcoholAmountAvgPerMonth)) + 
  geom_boxplot()

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

# Looking for correlation between alcohol and drugs

# Exploratory analisys
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
    "MethanfetamineLast30d",
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

# STIs

dataset_STIs <- dataset %>% select("AlcoholAmountAvgPerMonth","HadHPV", "HadHerpes", "HadGenitalWarts", "HadGonorrhea", "HadChlamydia", "HadHIV")
dataset_STIs$HadHIV[dataset_STIs$HadHIV == 3] <- NA
dataset_STIs <- na.omit(dataset_STIs)

# turning illnesses from 1 and 2 to True and False
vars.to.replace <- 
  c("HadHPV", 
    "HadHerpes", 
    "HadGenitalWarts", 
    "HadGonorrhea",
    "HadChlamydia",
    "HadHIV")
df2 <- dataset_STIs[vars.to.replace]
df2[df2 == 1] <- T
df2[df2 == 2] <- F
dataset_STIs[vars.to.replace] <- df2

dataset_STIs$HadSTI <- 
  (
    dataset_STIs$HadHPV | 
      dataset_STIs$HadHerpes | 
      dataset_STIs$HadGenitalWarts | 
      dataset_STIs$HadGonorrhea | 
      dataset_STIs$HadChlamydia | dataset_STIs$HadHIV)

# Mean of average alcohol consumption per month of the people with and without STIs
df_sti <- dataset_STIs %>% 
  group_by(HadSTI) %>% 
  summarize(AlcoholAmountAvgPerMonthMean = mean(AlcoholAmountAvgPerMonth))

ggplot(df_sti, aes(x = HadSTI, y = AlcoholAmountAvgPerMonthMean)) + 
  geom_col() + labs(x = "STI", y = "Average monthly alcohol consumption")

# chisq.test on drugs
tbl <- table(dataset_drug$AlcoholAmountAvgPerMonth, dataset_drug$Drug_CigsLast30d)
chisq.test(tbl)

# chisq.test on STI
tbl_2 <- table(dataset_STIs$AlcoholAmountAvgPerMonth, dataset_STIs$HadSTI)
chisq.test(tbl_2)

# chisq.test on ThoughtSuicide last 2 week
tbl_3 <- table(dataset$AlcoholAmountAvgPerMonth,dataset$ThoughtSuicideLast2w)
chisq.test(tbl_3)

# Average alcohol by gender
meanAlcoholAmountAvgPerMonth_Male <- 
  dataset %>% 
  filter(Gender == "Male") %>% 
  summarize(mean(AlcoholAmountAvgPerMonth))

meanAlcoholAmountAvgPerMonth_Female <- 
  dataset %>% 
  filter(Gender == "Female") %>% 
  summarize(mean(AlcoholAmountAvgPerMonth))

df_mf <- data.frame(Gender = c("Male", "Female"), 
                    MeanAlcoholAmountAvgPerMonth = c(meanAlcoholAmountAvgPerMonth_Male[[1]], 
                                                     meanAlcoholAmountAvgPerMonth_Female[[1]]))

ggplot(df_mf, aes(x = Gender, y = MeanAlcoholAmountAvgPerMonth, fill = Gender)) + 
  geom_col() + labs(x = "Gender", y = "Average monthly alcohol consumption") +
  theme(legend.position = "none")

#### Brief research with drugs again
convert_to_class <- function(drug, cig) {
  new_column <- drug
  for (index in seq_along(drug)) {
    if (drug[index] == T && cig[index] == T) {
      new_column[index] <- "Drugs and Cig"
    }
    else if (drug[index] == T) {
      new_column[index] <- "Drugs"
    }
    else if (cig[index] == T) {
      new_column[index] <- "Cig"
    }
    else {
      new_column[index] <- "Nothing"
    }
  }
  new_column
}

dataset_drug_mean <- dataset_drug %>%
  group_by(DrugLast30d, Drug_CigsLast30d) %>%
  mutate(
    Class = convert_to_class(DrugLast30d, SmokedCigsLast30d)
  ) %>% 
  group_by(Class) %>% 
  summarise(Mean = mean(AlcoholAmountAvgPerMonth), Count = length(AlcoholAmountAvgPerMonth))

# Mean of Alcohol consumption per drug usage class
ggplot(dataset_drug_mean, aes(x = Class, y = Mean, fill =Class)) + 
  geom_col() + 
  ggtitle("Average monthly alcohol consumption - Drug Usage Class") + 
  theme_minimal() +
  fancy_plot_no_legend

## Density per class
ggplot(dataset_drug_mean, aes(x = Class, y = Count, fill = Class)) + 
  geom_col() + 
  ggtitle("Average monthly alcohol consumption - Drug Usage Class") + 
  theme_minimal() +
  fancy_plot_no_legend

###########################
#Logistic regression attempt
training_labels <- dataset

# Create a set of training indices
trainIndex <- createDataPartition(
  training_labels$AlcoholAmountAvgPerMonth, # Sample proportionally based on the outcome variable
  p = .8,           # Percentage to be used for training
  list = FALSE,     # Return the indices as a vector (not a list)
  times = 1         # Only create one set of indices
)

# Subset your data into training and testing set
training_set <- training_labels[ trainIndex, ] # Use indices to get training data
test_set <- training_labels[ -trainIndex, ]    # Remove train indices to get test data

logit <- glm(AlcoholAmountAvgPerMonth ~ Gender * MaritalStatus * FamilyPovertyIndex, data=training_set, family="gaussian")

summary(logit)
anova(logit)

p<- predict(logit,test_set)

lm1 <- lm(AlcoholAmountAvgPerMonth ~ Gender + Age + FamilyPovertyIndex + HighestEducationLevel, dataset)
summary(lm1)

glm1 <- glm(AlcoholAmountAvgPerMonth ~ Gender + Age + FamilyPovertyIndex + HighestEducationLevel, data =dataset, family="gaussian")
summary(glm1)

lm2 <- lm(AlcoholAmountAvgPerMonthCubeRoot ~ Gender + Age + FamilyPovertyIndex + HighestEducationLevel + HighestEducationLevel * FamilyPovertyIndex, dataset)
summary(lm2)
