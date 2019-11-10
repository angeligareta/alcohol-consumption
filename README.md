<h1 align="center">Alcohol Consumption</h1>
<h4 align="center">Research about consequences of the recent increase in Alcohol Consumption. </h4>

<p align="center">
  <img alt="UPM" src="https://img.shields.io/badge/EIT%20Digital-UPM-blue?style=flat-square">
  <img alt="GitHub contributors" src="https://img.shields.io/github/contributors/angeligareta/AlcoholConsumption?style=flat-square">
</p>

## Domain of interest - Alcohol Consumption

### Interest in the field

We are interested in the causes and consequences of alcohol consumption especially in young people because this is something that affects our peers. Some research questions stem from pure curiosity, while others could actually lead us to information that would be useful for us personally. For instance, we are curious to relate this topic with other domains such as education and health and we are also looking forward to find out if the causes of alcohol consumption is due to facts like the economical situation or Human Development Index of the countries.

### Examples of related data driven projects

#### Project 1: [How common is alcohol and drug dependency across the world?](https://ourworldindata.org/alcohol-and-drug-dependency)

This project from the website **_Our World in Data_** presents the trends in Alcohol Consumption and Substance Use in countries all over the world, with data from 1990 to 2016. The aim is to give a better understanding of the global prevalence of substance use disorders.

Some of the conclusions in the research are:

- Across most countries, the number of alcohol use disorders is higher than other drug use disorders.
- Substance use disorders are more common among men than women.

#### Project 2: [SDR, selected alcohol-related causes, per 100 000](https://gateway.euro.who.int/en/indicators/hfa_293-1970-sdr-selected-alcohol-related-causes-per-100-000/)

This project carried out by the World Health Organization provide an interactive graph where we can see the age-standardized death rate per 100 000 related to alcohol. The study includes causes such as cancer of esophagus and larynx, alcohol dependence syndrome, chronic liver disease, cirrhosis etc.

#### Project 3: [Alcohol as a risk factor for type 2 diabetes](https://care.diabetesjournals.org/content/32/11/2123.full-text.pdf)

This study by the University of Toronto tries to measure the relation between alcohol consumption and the presence of type 2 diabetes. For obtaining the data, the researchers have found several data sources both from public sources or from previous articles.

The main conclusion of this study is that a relationship exists between alcohol consumption and the presence or diabetes in an _u-shaped_ way, both for men and women.

### Data driven research questions

- **Question 1:** How is the alcohol consumption related with the economical situation of a country? Does it get affected by the per capita income indicators and the development status of the countries?
- **Question 2:** Are drinking habits in students related to the family situation, the amount of free time, health and other related factors?
- **Question 3:** Which is the relation between alcohol consumption and mental illnesses, such as depression or weight disorders? Does this results change depending on age?

## Data Sources

### Data Source 1: [Life Expectancy (WHO)](https://www.kaggle.com/augustus0498/life-expectancy-who)

- **Data source:** The source of this data is the Open Dataset platform Kaggle, it is public and available to use. The path to downloaded the data: [/data/life-expectancy/](./data/life-expectancy/)
- **Data collection:** The data was originally collected from WHO (World Health Organization) and United Nations website with the support of Deeksha Russell and Duan Wang. This dataset is a merge of the WHO dataset, which is related to life expectancy and health factors for 193 countires and the corresponding economic data collected from the United Nations website.
- **Dataset description:** This dataset includes information such as details of the health history for the population of 193 countries from 2000 to 2015. The data allows us to relate several factors such as demographics, mortality and economics to life expectancy. Some of the columns that could be used are: Country, Status (developed or developing), Life Expectancy, Alcohol Consumption per capita, HIV and GDP.
- **Observations number:** The final merged dataset consists of 22 features and 2938 rows.
- **Questions that could be answered in our domain:** As our goal is to relate factors with alcohol consumption, this dataset could be very useful to associate how alcohol relates with adult mortality, GDP, years of schooling and life expectancy. For this reason this dataset could be helpful to answer the first research question.

### Data Source 2: [Student Alcohol Consumption](https://www.kaggle.com/uciml/student-alcohol-consumption)

- **Data source:** The data were obtained in a survey of students of Math and Portuguese language courses in secondary school.
- **Data collection:** Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7
- **Dataset description:** It contains a lot of interesting social, gender and study information about students.
- **Observations number:** The "students math dataset" has 395 observations and "the student portuguese language" has 649 observations. Both on them have 33 features
- **Questions that could be answered in our domain:** With this dataset we think we can understand how drinking habits change among students based on their characteristics.

### Data Source 3: [National health and nutrition examination survey](https://www.kaggle.com/cdc/national-health-and-nutrition-examination-survey)

- **Data source:** This data was obtained by the United States center of health statistics. It is an annual survey done for the civilian resident population of the United States. This is the public dataset corresponding for the period 2013-2014, and it was saved in the following folder: [/data/national-health-survey/](./data/national-health-survey/)
- **Data collection:** The data collection of this survey was a complex task that involved several parts, starting with body measurements to questionnaires to evaluate the mental health. A further description of the methodology can be found [here](https://www.cdc.gov/nchs/data/series/sr_01/sr01_056.pdf).
- **Dataset description:** The dataset is divided in several sections: demographic, medications or questionnaires. For our study, we are going to focus on the questionnaire section which is a dataset composed of several columns, where each one is a response to a certain question, such as: _In the past 12 months, how often did you drink any type of alcoholic beverage?_
- **Observations number:** The questionnaire dataset is composed by 10175 rows and 953 columns. 15 of those columns are the answers for questions related with alcohol consumption and 22 are related with mental health.
- **Questions that could be answered in our domain:** The relation between alcohol consumption and mental health is the main topic we are trying to examine here. But due to the amount of columns that the dataset contains we can also raise other interesting questions such as the relation between alcohol and addiction to other types of drugs.
