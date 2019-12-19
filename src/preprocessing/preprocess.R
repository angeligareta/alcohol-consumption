library(plyr)
library(dplyr)

# Import utils
source("./utils/utils.R")

# Read datasets from relative path (check working directory in case of error)
demographic <- read.csv("../data/demographic.csv", stringsAsFactors = T)
diet <- read.csv("../data/diet.csv", stringsAsFactors = T)
examination <- read.csv("../data/examination.csv", stringsAsFactors = T)
labs <- read.csv("../data/labs.csv", stringsAsFactors = T)
questionnaire <- read.csv("../data/questionnaire.csv", stringsAsFactors = T)

# Select datasets were the selected variables can be found and merge them in a new dataset
datasets_to_merge <- list(demographic, questionnaire, labs)
dataset <- plyr::join_all(datasets_to_merge, "SEQN")

# Keep only selected columns
preprocessed_dataset <- dataset %>% select(one_of(names(selected_variables)))

# Rename them
preprocessed_dataset <- preprocessed_dataset %>% plyr::rename(replace = selected_variables)

## Transform 7, 9, 77, 99... into NA (except 77 in age)
for (na_values in na_values_per_column) {
  ### Neccessary unlist to retrieve vectors contained within it
  preprocessed_dataset <- preprocessed_dataset %>%
    mutate_at(unlist(na_values[2]), function(column) {
      substitute_column_if(column, unlist(na_values[1]))
    })
}

## Convert some variables into readable factors
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

transformed_dataset$Gender <-
  factor(
    transformed_dataset$Gender,
    levels = c(1, 2),
    labels = c("Male", "Female")
  )

preprocessed_dataset = transformed_dataset

