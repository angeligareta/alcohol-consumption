library(dplyr)
library(ggplot2)

# Read datasets
demographic <-
  read.csv(
    "https://raw.githubusercontent.com/angeligareta/AlcoholConsumption/master/data/national-health-survey/demographic.csv",
    stringsAsFactors = T
  )

diet <-
  read.csv(
    "https://raw.githubusercontent.com/angeligareta/AlcoholConsumption/master/data/national-health-survey/diet.csv",
    stringsAsFactors = T
  )

examination <-
  read.csv(
    "https://raw.githubusercontent.com/angeligareta/AlcoholConsumption/master/data/national-health-survey/examination.csv",
    stringsAsFactors = T
  )

labs <-
  read.csv(
    "https://raw.githubusercontent.com/angeligareta/AlcoholConsumption/master/data/national-health-survey/labs.csv",
    stringsAsFactors = T
  )

questionnaire <-
  read.csv(
    "https://raw.githubusercontent.com/angeligareta/AlcoholConsumption/master/data/national-health-survey/questionnaire.csv",
    stringsAsFactors = T
  )

# Select datasets were the selected variables can be found and merge them in a new dataset
dataset <- inner_join(demographic, questionnaire, by = "SEQN")
dataset <- inner_join(dataset, labs, by = "SEQN")

# Select variables that could be useful for alcohol and explanation
selected_variables <-
  c("DMDEDUC2" = "DMDEDUC2",
    "DMDBORN4" = "DMDBORN4",
    "DMDFMSIZ" = "DMDFMSIZ",
    "DMDMARTL" = "DMDMARTL",
    "RIAGENDR" = "RIAGENDR",
    "RIDAGEYR" = "RIDAGEYR",
    "SXQ292" = "SXQ292",
    "SXQ294" = "SXQ294",
    "SXQ490" = "SXQ490",
    "SXQ550" = "SXQ550",
    "SXQ410" = "SXQ410",
    "SXQ130" = "SXQ130",
    "SXQ260" = "SXQ260",
    "SXQ265" = "SXQ265",
    "SXQ270" = "SXQ270",
    "SXQ272" = "SXQ272",
    "LBDHI" = "LBDHI",
    "MCQ380" = "MCQ380",
    "DLQ040" = "DLQ040",
    "MCQ084" = "MCQ084",
    "BPQ020" = "BPQ020",
    "MCQ080" = "MCQ080",
    "MCQ160e" = "MCQ160e",
    "MCQ160f" = "MCQ160f",
    "MCQ203" = "MCQ203",
    "HUD080" = "HUD080",
    "PAD660" = "PAD660",
    "CSQ240" = "CSQ240",
    "SMD641" = "SMD641",
    "DPQ020" = "DPQ020",
    "DPQ070" = "DPQ070",
    "DPQ090" = "DPQ090",
    "SMQ866" = "SMQ866",
    "IND235" = "IND235",
    "INDFMMPI" = "INDFMMPI",
    "SLD010H" = "SLD010H",
    "DUQ230" = "DUQ230",
    "DUQ280" = "DUQ280",
    "DUQ320" = "DUQ320",
    "DUQ360" = "DUQ360",
    "OCQ180" = "OCQ180")

# Keep only selected columns and rename them
preprocessed_dataset <- dataset[, (names(dataset) %in% selected_variables)]
preprocessed_dataset <- preprocessed_dataset %>% plyr::rename(selected_variables)
