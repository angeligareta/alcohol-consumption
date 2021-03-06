# Utils
library(ggplot2)

## Select variables that could be useful for alcohol and explanation
## Made use of character vector
selected_variables <-
  c(
    "DMDEDUC2" = "HighestEducationLevel",
    "DMDBORN4" = "CountryBorn",
    "DMDFMSIZ" = "NoPeopleFamily",
    "DMDMARTL" = "MaritalStatus",
    "RIAGENDR" = "Gender",
    "RIDAGEYR" = "Age",
    "DBD905" = "JunkFoodLast30d",
    "PAQ715" = "PlayVideoGamesLast30d",
    "SXQ292" = "SexualOrientationM",
    "SXQ294" = "SexualOrientationF",
    "SXQ410" = "SexWithMenLast12m",
    "SXQ130" = "SexWithWomenLast12m",
    "SXQ753" = "HadHPV",
    "SXQ260" = "HadHerpes",
    "SXQ265" = "HadGenitalWarts",
    "SXQ270" = "HadGonorrhea",
    "SXQ272" = "HadChlamydia",
    "LBDHI" = "HadHIV",
    "MCQ380" = "ProblemsRememberingThingsLast30d",
    "DLQ040" = "DifficultyConcentrating",
    "MCQ084" = "MemoryLossLast12m",
    "BPQ020" = "Hypertension",
    "MCQ080" = "Overweight",
    "MCQ203" = "HadJaundice",
    "HUD080" = "DaysInHospitalLast12m",
    "PAD660" = "TimeVigorousActivitiesPerDay",
    "CSQ240" = "HadLostConcientiousness",
    "DPQ020" = "FeelDownDepressedLast2W",
    "DPQ070" = "ProblemsConcentratingLast2w",
    "DPQ090" = "ThoughtSuicideLast2w",
    "SLD010H" = "SleepHoursWorkdays",
    "OCQ210" = "GreaterEqual35HoursWorkPerWeek",
    "IND235" = "MonthlyFamilyIncome",
    "INDFMMPI" = "FamilyPovertyIndex",
    "SMD641" = "SmokedCigsLast30d",
    "DUQ230" = "MarijuanaLast30d",
    "DUQ280" = "CocaineLast30d",
    "DUQ320" = "HeroineLast30d",
    "DUQ360" = "MethanfetamineLast30d",
    "OCQ180" = "HoursWorkPerWeek",
    "SMQ866" = "SpendTimeBar7d",
    "ALQ160" = "AlcoholDrink5Last30d",
    "ALQ120Q" = "AlcoholAmountAvg",
    "ALQ120U" = "AlcoholAmountUnit"
  )

columns_na_3 <- c(
  "HadHIV"
)

columns_na_7_9 <- c(
  "HighestEducationLevel",
  "SexualOrientationM",
  "SexualOrientationF",
  "HadHPV",
  "HadHerpes",
  "HadGenitalWarts",
  "HadGonorrhea",
  "HadChlamydia",
  "ProblemsRememberingThingsLast30d",
  "DifficultyConcentrating", 
  "MemoryLossLast12m",
  "Hypertension",
  "Overweight",
  "HadJaundice", 
  "HadLostConcientiousness",
  "FeelDownDepressedLast2W", 
  "ProblemsConcentratingLast2w", 
  "ThoughtSuicideLast2w",
  "GreaterEqual35HoursWorkPerWeek",
  "SpendTimeBar7d",
  "AlcoholAmountUnit"
)

columns_na_77_99 <- c(
  "CountryBorn",
  "MaritalStatus",
  "PlayVideoGamesLast30d",
  "SleepHoursWorkdays",
  "MonthlyFamilyIncome",
  "SmokedCigsLast30d",
  "CocaineLast30d",
  "HeroineLast30d",
  "MethanfetamineLast30d"
)

columns_na_777_999 <- c(
  "MarijuanaLast30d",
  "AlcoholDrink5Last30d",
  "AlcoholAmountAvg"
)

columns_na_7777_9999 <- c(
  "JunkFoodLast30d",
  "TimeVigorousActivitiesPerDay"
)

columns_na_77777_99999 <- c(
  "SexWithMenLast12m",
  "SexWithWomenLast12m",
  "DaysInHospitalLast12m",
  "HoursWorkPerWeek"
)

na_values_per_column = list(
  na_3 = list(c(3), columns_na_3),
  na_7_9 = list(c(7, 9), columns_na_7_9),
  na_77_99 = list(c(77, 99), columns_na_77_99),
  na_777_999 = list(c(777, 999), columns_na_777_999),
  na_7777_9999 = list(c(7777, 9999), columns_na_7777_9999),
  na_77777_99999 = list(c(77777, 99999), columns_na_77777_99999)
)

sti_variables <- c("HadHPV",
                   "HadHerpes",
                   "HadGenitalWarts",
                   "HadGonorrhea",
                   "HadChlamydia",
                   "HadHIV")

drug_variables <- 
  c("MarijuanaLast30d", 
    "CocaineLast30d", 
    "HeroineLast30d", 
    "MethanfetamineLast30d",
    "SmokedCigsLast30d")

# Convert to explicit NA
substitute_column_if <- function(column, condition_values) {
  column <- replace(column, column %in% condition_values, NA)
}

transform_continuous_to_boolean <- function(column) {
  boolean_column <- column
  for (index in seq_along(column)) {
    if (column[index] > 0) {
      boolean_column[index] <- T
    }
    else {
      boolean_column[index] <- F
    }
  }
  boolean_column
}

fancy_text_title <- theme(title = element_text(color = "chocolate",
                                                      size = 14, face = "bold", margin = 3, line = 2))

fancy_text_legend <- theme(legend.title = element_text(color = "chocolate",
                                                       size = 14, face = "bold"))

fancy_plot <-
  theme(
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_blank(),
    legend.title = element_blank(),
  ) +
  fancy_text_title

fancy_plot_no_legend <-
  theme(
    axis.ticks = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none",
  ) +
  fancy_text_title
