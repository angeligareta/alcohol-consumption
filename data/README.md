# National health and nutrition examination survey

## Data Source

- Source: [Kaggle.com](https://www.kaggle.com/cdc/national-health-and-nutrition-examination-survey#questionnaire.csv)

## Final selected variables from multiple datasets

### [Demographics variables](https://wwwn.cdc.gov/nchs/nhanes/2011-2012/DEMO_G.htm)

- DMDEDUC2 - HighestEducationLevel
  - 1: Less than 9th grade
  - 2: 9-11th grade
  - 3: High School
  - 4: College
  - 5: College graduate or above
  - 7, 9: Set to NA
- DMDBORN4 - CountryBorn
  - 1: US
  - 2: Other
  - 77, 99: NA
- DMDFMSIZ - NoPeopleFamily
  - 1 to 6: Range of people in family
  - 7: 7+ people
- DMDMARTL - MartialStatus
  - 1: Married
  - 2: Widowed
  - 3: Divorced
  - 4: Separated
  - 5: Never Married
  - 6: Living with partner
  - 77, 99: Set to NA
- RIAGENDR - Gender
  - 1: M
  - 2: F
- RIDAGEYR - Age
  - 0 to 79: Range of years
  - 80: 80+ years

### [Sex situation](https://wwwn.cdc.gov/Nchs/Nhanes/2009-2010/SXQ_F.htm)

- SXQ292 - SexualOrientationM
  - 1: Heterosexual
  - 2: Homosexual
  - 3: Bisexual
  - 4: Other
  - 5: Not sure
  - 7, 9: Set to NA
- SXQ294 - SexualOrientationF
  - 1: Heterosexual
  - 2: Homosexual
  - 3: Bisexual
  - 4: Other
  - 5: Not sure
  - 7, 9: Set to NA
- SXQ490: woman sex 12 months.
- SXQ550: men sex 12 months.
- SXQ410: men sex lifetime
- SXQ130: women sex lifetime.
- SXQ260: had you herpes?
- SXQ265: had you had genital warts?
- SXQ270: had you have gonorrea?
- SXQ272: had you have chlamydia?
- LBDHI: you have HIV // laboratory dataset

### Mental illnesses

- MCQ380: problems remembering things during the last 7 days.
- DLQ040: difficulties remebering things.
- MCQ084: have you experienced memory lost (12)
- BPQ020: hypertension
- MCQ080: overweight
- MCQ160e: had a heart attack
- MCQ160f: had a stroke
- MCQ203: ever had jaundice
- HUD080: how many days have you been in hospital?
- PAD660: how much time do you spend doing vigorous activities?
- CSQ240: ever had a lost of concientiousness?

### Mental situation

- DPQ020: feel down or depressed in the last two weeks.
- DPQ070: problems concentrating in the last 2 weeks
- DPQ090: how often have you thought in suicide over the last two weeks.
- SLD010H: how much sleep do you have in workdays.

### Economic situation

- SMD641: on how many of the past 30 days do you have smoked a cigarrete?
- IND235: monthly family incomes.
- INDFMMPI: family poverty index.

### Drugs variables

- DUQ230: marijuana in last 30 days.
- DUQ280: how many days you used cocaine in the last 30 days?
- DUQ320: how many days did you used heroine in the las 30 days?
- DUQ360: methanfetamine in last 30 days.
- OCQ180: how many hours do you spend per week working?
- OCQ210: usually work 35 hours or more?

### Alcohol variables

- SMQ866: during the last 7 days, did you spend time in a bar?
- ALQ120Q: how often drink alcohol over past 12 mos + ALQ120U unit
- ALQ130: alcoholic drinks/day - past 12 mos
- ALQ160: days have 4/5 or more drinks in 2 hrs
- ALQ151: ever have 4/5 or more drinks every day?

##### Alcohol variables for young people are not the same, so we discard them

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
    "OCQ180" = "OCQ180",
    "OCQ210" = "OCQ210",
    "SMQ866" = "SMQ866",
    "ALQ120Q" = "ALQ120Q",
    "ALQ120U", "ALQ120U",
    "ALQ130" = "ALQ130",
    "ALQ160" = "ALQ160",
    "ALQ151" = "ALQ151"
    )
```
