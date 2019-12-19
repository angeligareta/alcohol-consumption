library(ggplot2)
library(tidyr)
library(DataCombine)

source("./preprocessing/preprocess.R")

# Show summary of preprocessed dataset
summary(preprocessed_dataset)

# Use preprocessed dataset as main one
dataset <- preprocessed_dataset

# Start with researches related with alcohol

## Alcohol and Sex ----
## TODO: Handle NA values
dataset %>% ggplot(aes(x = Age, y = log(AlcoholDrink5Last30d))) + ylim(0, 5) + geom_boxplot(aes(color = MaritalStatus))

# Relation beween mental situation, mental illnesses, economic situation and alcohol consumption ----

# Preprocesing, choosing the right variables and handling NA Values.

na.omit(dataset, cols="AlcoholAmountAvgPerMonth")

q1_dataset <- DataCombine::DropNA(dataset, Var="AlcoholAmountAvgPerMonth")

q1_dataset <- dataset  %>% drop_na(AlcoholAmountAvgPerMonth)




