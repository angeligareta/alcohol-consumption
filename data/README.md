# National health and nutrition examination survey

## Data Source

- Source: [Kaggle.com](https://www.kaggle.com/cdc/national-health-and-nutrition-examination-survey#questionnaire.csv)

## Final selected variables from multiple datasets

### Demographics variables

- [DMDEDUC2](https://wwwn.cdc.gov/nchs/nhanes/2011-2012/DEMO_G.htm#DMDEDUC2) - HighestEducationLevel
  - 1: Less than 9th grade
  - 2: 9-11th grade
  - 3: High School
  - 4: College
  - 5: College graduate or above
  - 7, 9: Set to NA
- [DMDBORN4](https://wwwn.cdc.gov/nchs/nhanes/2011-2012/DEMO_G.htm#DMDBORN4) - CountryBorn
  - 1: US
  - 2: Other
  - 77, 99: NA
- [DMDFMSIZ](https://wwwn.cdc.gov/nchs/nhanes/2011-2012/DEMO_G.htm#DMDFMSIZ) - NoPeopleFamily
  - 1 to 6: Range of people in family
  - 7: 7+ people
- [DMDMARTL](https://wwwn.cdc.gov/nchs/nhanes/2011-2012/DEMO_G.htm#DMDMARTL) - MartialStatus
  - 1: Married
  - 2: Widowed
  - 3: Divorced
  - 4: Separated
  - 5: Never Married
  - 6: Living with partner
  - 77, 99: Set to NA
- [RIAGENDR](https://wwwn.cdc.gov/Nchs/Nhanes/2005-2006/DEMO_D.htm#RIAGENDR) - Gender
  - 1: M
  - 2: F
- [RIDAGEYR](https://wwwn.cdc.gov/Nchs/Nhanes/2005-2006/DEMO_D.htm#RIDAGEYR) - Age
  - 0 to 79: Range of years
  - 80: 80+ years

### Sex situation

- [SXQ292](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ292) - SexualOrientationM
  - 1: Heterosexual
  - 2: Homosexual
  - 3: Bisexual
  - 4: Other
  - 5: Not sure
  - 7, 9: Set to NA
- [SXQ294](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ294) - SexualOrientationF
  - 1: Heterosexual
  - 2: Homosexual
  - 3: Bisexual
  - 4: Other
  - 5: Not sure
  - 7, 9: Set to NA
- [SXQ241](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ490) - SexLast30d. Note: Few data
  - 0 to 8: range of values
  - 77777 and 999999: Set to NA
- [SXQ410](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ410) - SexWithMenLast12m
  - 1 to 100: range of values
  - 2000: 2000 or + (outlier)
  - 77777, 99999: Set to NA
- [SXQ130](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ130) - SexWithWomenLast12m
  - 1 to 700: range of values
  - 2000: 2000 or + (outlier)
  - 77777, 99999: Set to NA

## Sexual STIs

- [SXQ753](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ753) - HadHPV
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [SXQ260](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ260) - HadHerpes
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [SXQ265](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ265) - HadGenitalWarts
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [SXQ270](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ270) - HadGonorrhea
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [SXQ272](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm#SXQ272) - HadChlamydia
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [LBDHI](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/HIV_H.htm#LBDHI) - HadHIV
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA

### Mental illnesses

- [MCQ380](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/MCQ_H.htm) - ProblemsRememberingThingsLast30d
  - 0: Never
  - 1: About once
  - 2: Two or three times
  - 3: Nearly every day
  - 4: Several times a day
  - 7, 9: Set to NA
- [DLQ040](https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/DLQ_I.htm) - DifficultyConcentrating
  - 1: Yes
  - 2: No
  - 7,9: Set to NA
- [MCQ084](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/MCQ_H.htm) - MemoryLossLast12m
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [BPQ020](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BPQ_H.htm) - Hypertension
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [MCQ080](https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/MCQ_I.htm) - Overweight
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [MCQ160e](https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/MCQ_I.htm) - HadHeartAttack
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [MCQ160f](https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/MCQ_I.htm) - HadStroke
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [MCQ203](https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/MCQ_I.htm) - HadJaundice
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [HUD080](https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/HUQ_G.htm) - DaysInHospitalLast12m
  - 1 to 5: Range of days
  - 6: 6 or more
  - 77777, 99999: Set to NA
- [PAD660](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/PAQ_H.htm) - TimeVigorousActivitiesPerDay
  - 10 to 600: Range of minutes
  - 7777, 9999: Set to NA
- [CSQ240](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/CSQ_H.htm) - HadLostConcientiousness
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA

### Mental situation

- [DPQ020](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DPQ_H.htm#DPQ020) - FeelDownDepressedLast2w
  - 0: Not at all
  - 1: Several days
  - 2: More than half the days
  - 3: Nearly every day
  - 7, 9: Set to NA
- [DPQ070](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DPQ_H.htm#DPQ070) - ProblemsConcentratingLast2w
  - 0: Not at all
  - 1: Several days
  - 2: More than half days
  - 3: Nearly every day
  - 7, 9: Set to NA
- [DPQ090](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DPQ_H.htm#DPQ090) - ThoughtSuicideLast2w
  - 0: Not at all
  - 1: Several days
  - 2: More than half days
  - 3: Nearly every day
  - 7, 9: Set to NA
- [SLD010H](https://wwwn.cdc.gov/Nchs/Nhanes/2011-2012/SLQ_G.htm#SLD010H) - SleepHoursWorkdays
  - 2 to 11: Range of hours
  - 12: 12 hours or more
  - 77, 99: Set to NA
- [OCQ210](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/OCQ_H.htm#OCQ210) - GreaterEqual35HoursWorkPerWeek
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA

### Economic situation

- [SMD641](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/SMQ_H.htm#SMD641) - SmokedCigsLast30d
  - 0 to 30: Range of days
  - 77, 99: Set to NA
- [IND235](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/INQ_F.htm#IND235) - MonthlyFamilyIncome
  - 1: $0 - $399
  - 2: $400 - $799
  - 3: $800 - $1249
  - 4: $1250 - $1649
  - 5: $1650 - $2099
  - 6: $2100 - $2899
  - 7: $2900 - $3749
  - 8: $3750 - $4599
  - 9: $4600 - $5399
  - 10: $5400 - $6249
  - 11: $6250 - $8399
  - 12: \$8400 and over
  - 77, 99: Set to NA
- [INDFMMPI](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/INQ_F.htm#INDFMMPI) - FamilyPovertyIndex
  - 0 to 4.99: Range of values
  - 5: Value greater or equal to 5.00
  - .: Set to NA

### Drugs variables

- [DUQ230](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DUQ_H.htm#DUQ230) - MarijuanaLast30d
  - 1 to 30: Range of days
  - 777, 999: Set to NA
- [DUQ280](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DUQ_H.htm#DUQ280) - CocaineLast30d
  - 1 to 30: Range of days
  - 77, 99: Set to NA
- [DUQ320](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DUQ_H.htm#DUQ320) - HeroineLast30d
  - 1 to 30: Range of days
  - 77, 99: Set to NA
- [DUQ360](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DUQ_H.htm#DUQ360) - MethanfetamineLast30d
  - 1 to 30: Range of days
  - 77, 99: Set to NA
- [OCQ180](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/OCQ_H.htm#OCQ180) - HoursWorkPerWeek
  - 1 to 79: Range of hours
  - 80: 80 hours or more
  - 77777, 99999: set to NA

### Alcohol variables

- [SMQ866](https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/SMQSHS_I.htm#SMQ866) - SpendTimeBar7d
  - 1: Yes
  - 2: No
  - 7, 9: Set to NA
- [ALQ160](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/ALQ_H.htm#ALQ160): AlcoholDrink5Last30d
  - 0 to 30: range of values
  - 777, 999: Set to NA
- [ALQ120Q](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/ALQ_H.htm#ALQ120Q) - AlcoholAmountAvgPerMonth
  - 0 to 365: range of values
  - 777, 999: set to NA
- [ALQ120U](https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/ALQ_H.htm#ALQ120U) - AlcoholAmountUnitPerMonth
  - 1: Week
  - 2: Month
  - 3: Year
  - 7, 9: Set to NA

Alcohol variables for young people are not the same, so we discard them when analyzig those variables.

### Selected variables possible values

This variables explained in R would be

```R
c(
    "DMDEDUC2" = "HighestEducationLevel",
    "DMDBORN4" = "CountryBorn",
    "DMDFMSIZ" = "NoPeopleFamily",
    "DMDMARTL" = "MartialStatus",
    "RIAGENDR" = "Gender",
    "RIDAGEYR" = "Age",
    "SXQ292" = "SexualOrientationM",
    "SXQ294" = "SexualOrientationF",
    "SXQ490" = "SXQ490",
    "SXQ550" = "SXQ550",
    "SXQ410" = "SXQ410",
    "SXQ130" = "SXQ130",
    "SXQ260" = "SXQ260",
    "SXQ265" = "SXQ265",
    "SXQ270" = "SXQ270",
    "SXQ272" = "SXQ272",
    "LBDHI" = "LBDHI",
    "MCQ380" = "ProblemsRememberingThingsLast30d",
    "DLQ040" = "DifficultyConcentrating",
    "MCQ084" = "MemoryLossLast12m",
    "BPQ020" = "Hypertension",
    "MCQ080" = "Overweight",
    "MCQ160e" = "HadHeartAttack",
    "MCQ160f" = "HadStroke",
    "MCQ203" = "HadJaundice",
    "HUD080" = "DaysInHospitalLast12m",
    "PAD660" = "TimeVigorousActivitiesPerDay",
    "CSQ240" = "HadLostConcientiousness",
    "SMD641" = "SmokedCigsLast30d",
    "DPQ020" = "FeelDownDepressedLast2W",
    "DPQ070" = "ProblemsConcentratingLast2w",
    "DPQ090" = "ThoughtSuicideLast2w",
    "SMQ866" = "SMQ866",
    "IND235" = "IND235",
    "INDFMMPI" = "FamilyPovertyIndex",
    "SLD010H" = "SleepHoursWorkdays",
    "DUQ230" = "MarijuanaLast30d",
    "DUQ280" = "CocaineLast30d",
    "DUQ320" = "HeroineLast30d",
    "DUQ360" = "MethanfetamineLast30d",
    "OCQ180" = "HoursWorkPerWeek",
    "OCQ210" = "GreaterEqual35HoursWorkPerWeek",
    "SMQ866" = "SMQ866",
    "ALQ120Q" = "ALQ120Q",
    "ALQ120U", "ALQ120U",
    "ALQ130" = "ALQ130",
    "ALQ160" = "ALQ160",
    "ALQ151" = "ALQ151"
    )
```
