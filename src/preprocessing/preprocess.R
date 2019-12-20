if (!require(plyr)) {
  install.packages("plyr")
  library(plyr)
}
if (!require(DataCombine)) {
  install.packages("DataCombine")
  library(DataCombine)
}
if (!require(e1071)) {
  install.packages("DataCombine")
  library(e1071)
}
if (!require(kader)) {
  install.packages("kader")
  library(kader) # cuberoot transformation
}
library(dplyr)

# Import utils
source("./utils/utils.R")

print("Reading datasets...")
# Read datasets from relative path (check working directory in case of error) ----
demographic <-
  read.csv("../data/demographic.csv", stringsAsFactors = T)
diet <- read.csv("../data/diet.csv", stringsAsFactors = T)
examination <-
  read.csv("../data/examination.csv", stringsAsFactors = T)
labs <- read.csv("../data/labs.csv", stringsAsFactors = T)
questionnaire <-
  read.csv("../data/questionnaire.csv", stringsAsFactors = T)

# Select datasets were the selected variables can be found and merge them in a new dataset
print("Merging datasets...")
datasets_to_merge <- list(demographic, questionnaire, labs)
dataset <- plyr::join_all(datasets_to_merge, "SEQN")

# Keep only selected columns
preprocessed_dataset <-
  dataset %>% select(one_of(names(selected_variables)))

# Rename them
preprocessed_dataset <-
  preprocessed_dataset %>% plyr::rename(replace = selected_variables)

## Transform 7, 9, 77, 99... into NA (except 77 in age)
for (na_values in na_values_per_column) {
  ### Neccessary unlist to retrieve vectors contained within it
  preprocessed_dataset <- preprocessed_dataset %>%
    mutate_at(unlist(na_values[2]), function(column) {
      substitute_column_if(column, unlist(na_values[1]))
    })
}

## Convert some variables into readable factors
print("Converting variables to custom readable factors...")
transformed_dataset = preprocessed_dataset
# HighestEducationLevel Transformation 1-2 => Basic, 3 => Intermediate, 4-5 => Advanced
transformed_dataset$HighestEducationLevel <-
  cut(
    transformed_dataset$HighestEducationLevel,
    br = c(0, 2, 3, 6),
    labels = c("Basic", "Intermediate", "Advanced")
  )

# CountryBorn Transformation 1 => US, 2 => NoUS
transformed_dataset$CountryBorn <-
  factor(
    transformed_dataset$CountryBorn,
    levels = c(1, 2),
    labels = c("US", "NoUS")
  )

transformed_dataset$MaritalStatus <-
  factor(
    transformed_dataset$MaritalStatus,
    levels = c(1, 2, 3, 4, 5, 6),
    labels = c(
      "Married",
      "Widowed",
      "Divorced",
      "Separated",
      "NeverMarried",
      "LivingWithPartner"
    )
  )

transformed_dataset$MaritalStatus <-
  forcats::fct_explicit_na(transformed_dataset$MaritalStatus, na_level = "NA")

transformed_dataset$Gender <-
  factor(
    transformed_dataset$Gender,
    levels = c(1, 2),
    labels = c("Male", "Female")
  )

transformed_dataset$SpendTimeBar7d <-
  factor(
    transformed_dataset$SpendTimeBar7d,
    levels = c(1, 2),
    labels = c("Yes", "No")
  )

# Preprocesing, choosing the right variables and handling NA Values. ----

## Mental situation variables.
print("Processing mental situation variables...")

transformed_dataset$DifficultyConcentrating <-
  factor(
    transformed_dataset$DifficultyConcentrating,
    levels = c(1, 2),
    labels = c(
      "Yes",
      "No"
    )
  )

transformed_dataset$ProblemsRememberingThingsLast30d <-
  factor(
    transformed_dataset$ProblemsRememberingThingsLast30d,
    levels = c(0, 1, 2, 3, 4),
    labels = c(
      "Never",
      "AboutOnce",
      "TwoOrThreeTimes",
      "NearlyEveryday",
      "SeveralTimesADay"
    )
  )

transformed_dataset$FeelDownDepressedLast2W <-
  factor(
    transformed_dataset$FeelDownDepressedLast2W,
    levels = c(0, 1, 2, 3),
    labels = c("Not", "SeveralDays", "MoreThanHalfDays", "NearlyEveryday")
  )

transformed_dataset$ProblemsConcentratingLast2w <-
  factor(
    transformed_dataset$ProblemsConcentratingLast2w,
    levels = c(0, 1, 2, 3),
    labels = c("Not", "SeveralDays", "MoreThanHalfDays", "NearlyEveryday")
  )

transformed_dataset$ThoughtSuicideLast2w <-
  factor(
    transformed_dataset$ThoughtSuicideLast2w,
    levels = c(0, 1, 2, 3),
    labels = c("Not", "SeveralDays", "MoreThanHalfDays", "NearlyEveryday")
  )

transformed_dataset$GreaterEqual35HoursWorkPerWeek <-
  factor(
    transformed_dataset$GreaterEqual35HoursWorkPerWeek,
    levels = c(1, 2),
    labels = c("Yes", "No")
  )

## Normalizing ----
print("Reading NA Values in alcohol variables...")
alcohol_variables <-
  list(
    transformed_dataset$SpendTimeBar7d,
    transformed_dataset$AlcoholDrink5Last30d,
    transformed_dataset$AlcoholAmountAvgPerMonth,
    transformed_dataset$AlcoholAmountUnitPerMonth
  )
alcohol_variables_labels <-
  c("SpendTimeBar7d",
    "AlcoholDrink5Last30d",
    "AlcoholAmountAvg",
    "AlcoholAmountUnit")
for (index in seq_along(alcohol_variables)) {
  print(alcohol_variables_labels[index])
  print(sum(is.na(alcohol_variables[[index]])))
}

## We can not take AlcoholDrink5Last30d because it has lot of NA values, we will try to transform
## AlcoholAmountAvg with AlcoholAmountUnit to make an alcohol amount per month
## as now it can be in years and days too which AlcoholAmountUnit explains
transformed_dataset <-
  DataCombine::DropNA(transformed_dataset, Var = "AlcoholAmountAvg")

# There are 882 people that answer they didnt drink at all
transformed_dataset %>% filter(AlcoholAmountAvg == 0) %>% count()

## Normalize to all units of AlcoholAmountAvg to month
print("Normalizing NA Values...")
transformAlcoholAmountAvgPerMonth <-
  function(amountRows, unitRows) {
    newColumn <- amountRows
    
    for (column_index in seq_along(amountRows)) {
      alcohol_amount <- amountRows[column_index]
      alcohol_unit <- unitRows[column_index]
      # If NA or unit is month asign to amount
      if (is.na(alcohol_unit) || alcohol_unit == 2) {
        newColumn[column_index] = alcohol_amount
      }
      # If unit is week, multiply by for
      else if (alcohol_unit == 1) {
        newColumn[column_index] = alcohol_amount * 4
      }
      else {
        newColumn[column_index] = alcohol_amount / 12
      }
    }
    
    newColumn
  }

transformed_dataset <-
  transformed_dataset %>% mutate(AlcoholAmountAvgPerMonth = transformAlcoholAmountAvgPerMonth(AlcoholAmountAvg, AlcoholAmountUnit))



## Transformations ----
print("Transformation of data, adding new variables...")
# Distribution of AlcoholAmountAvgPerMonth
# dataset %>% ggplot(aes(AlcoholAmountAvgPerMonth)) + geom_histogram(fill = "brown") + ylab("Number of People") + xlab("Mothly Alcohol Consumption")

# AlcoholAmountAvg month has a high right skewness of 2.0 (normal between -0.5 and 0.5)
print("Skewness for AlcoholAmountAvgPerMonth")
skewness(transformed_dataset$AlcoholAmountAvgPerMonth)

## Try possible transformations
print("Skewness for cuberoot of AlcoholAmountAvgPerMonth")
skewness(kader:::cuberoot(transformed_dataset$AlcoholAmountAvgPerMonth))

# Plot after transformation
# dataset %>% ggplot(aes(kader:::cuberoot(dataset$AlcoholAmountAvgPerMonth))) + geom_histogram(fill = "brown") + ylab("Number of People") + xlab("Mothly Alcohol Consumption")
print("Adding new column AlcoholAmountAvgPerMonthCubeRoot...")
transformed_dataset <-
  transformed_dataset %>% mutate(
    AlcoholAmountAvgPerMonthCubeRoot = kader:::cuberoot(transformed_dataset$AlcoholAmountAvgPerMonth)
  )

preprocessed_dataset <- transformed_dataset
