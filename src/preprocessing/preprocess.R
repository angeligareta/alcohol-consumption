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