library(plyr)
library(dplyr)
library(ggplot2)

# Loading datasets (there are no duplicates)
d1=read.csv("./data/student_alcohol_consumption/student-mat.csv",sep=",",header=TRUE)
print(nrow(d1)) # 395
print(nrow(na.omit(d1))) # 395
d2=read.csv("./data/student_alcohol_consumption/student-por.csv",sep=",",header=TRUE)
print(nrow(d2)) # 649
print(nrow(na.omit(d2))) # 649

# List of features
# school Student's school (binary: 'GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)
# sex Student's sex (binary: 'F' - female or 'M' - male)
# age Student's age (numeric: from 15 to 22)
# address Student's home address type (binary: 'U' - urban or 'R' - rural)
# famsize Family size (binary: 'LE3' - less or equal to 3 or 'GT3' - greater than 3)
# Pstatus Parent's cohabitation status (binary: 'T' - living together or 'A' - living apart)
# Medu Mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 - 5th to 9th grade, 3 - secondary education, or 4 - higher education)
# Fedu Father's education (numeric: 0 - none, 1 - primary education (4th grade), 2 - 5th to 9th grade, 3 - secondary education, or 4 - higher education)
# Mjob Mother's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
# Fjob Father's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
# reason Reason to choose this school (nominal: close to 'home', school 'reputation', 'course' preference or 'other')
# guardian Student's guardian (nominal: 'mother', 'father' or 'other')
# traveltime Home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
# studytime Weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
# failures Number of past class failures (numeric: n if 1<=n<3, else 4)
# schoolsup Extra educational support (binary: yes or no)
# famsup Family educational support (binary: yes or no)
# paid Extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)
# activities Extra-curricular activities (binary: yes or no)
# nursery Attended nursery school (binary: yes or no)
# higher Wants to take higher education (binary: yes or no)
# internet Internet access at home (binary: yes or no)
# romantic With a romantic relationship (binary: yes or no)
# famrel Quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
# freetime Free time after school (numeric: from 1 - very low to 5 - very high)
# goout Going out with friends (numeric: from 1 - very low to 5 - very high)
# Dalc Workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
# Walc Weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)
# health Current health status (numeric: from 1 - very bad to 5 - very good)
# absences Number of school absences (numeric: from 0 to 93)
# G1 First period grade (numeric: from 0 to 20)
# G2 Second period grade (numeric: from 0 to 20)
# G3 Final grade (numeric: from 0 to 20, output target)


# Merging process provided by default
# but we obtain duplicate features
d3=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))
print(nrow(d3)) # 382 students

# Appending the 2 datasets gives more rows but some students are duplicated but with different attributes depending on the subject (mat-por)
d4 = merge(d1,d2, all = T)
print(nrow(d4)) # 1044
print(nrow(na.omit(d4))) # 1044

# Chosen: using only student-por dataset as it has more records
student_por <- d2
# View(student_por)

# Some correlations
# Workday vs Weekend alcohol consumption
cor(student_por$Dalc, student_por$Walc) # 0.6165614

ggplot(data = student_por, aes(x = Dalc, y = Walc, color = sex)) + 
  geom_point() +
  geom_jitter()

ggplot(data = student_por, aes(x = Dalc, y = Walc)) + 
  geom_point() +
  geom_jitter() +
  geom_smooth(se = FALSE)

# Workday alcohol consumption vs Father education (from 1 to 4)
cor(student_por$Dalc, student_por$Fedu) # 6.07749e-05

# Weekend alcohol consumption vs Father education (from 1 to 4)
cor(student_por$Walc, student_por$Fedu) # 0.0384447

# Workday alcohol consumption vs Mother education (from 1 to 4)
cor(student_por$Dalc, student_por$Medu) # -0.007018319

# Weekend alcohol consumption vs Mother education (from 1 to 4)
cor(student_por$Walc, student_por$Medu) # -0.01976579

# Weekend alcohol consumption vs Quality of family relationships (from 1 to 5)
cor(student_por$Walc, student_por$famrel) # -0.09351081

ggplot(data = student_por, aes(x = Walc, y = famrel)) + 
  geom_point() +
  geom_jitter() +
  geom_smooth()

# Workday alcohol consumption vs Mother education (from 1 to 5)
cor(student_por$Dalc, student_por$famrel) # -0.07576723

# Changes Weekend and Workday alcohol consumption from numbers (1:5) to words ("Very Low", "Low", "Medium", "High", "Very High")
# student_por$Dalc <- as.factor(student_por$Dalc)      
# student_por$Dalc <- mapvalues(student_por$Dalc, 
#                               from = 1:5, 
#                               to = c("Very Low", "Low", "Medium", "High", "Very High"))
# 
# student_por$Walc <- as.factor(student_por$Walc)      
# student_por$Walc <- mapvalues(student_por$Walc, 
#                               from = 1:5, 
#                               to = c("Very Low", "Low", "Medium", "High", "Very High"))


# Some simple graphs

# Females and Males
ggplot(data = student_por, aes(x = sex, fill = sex)) + 
  geom_bar(position = "dodge")

# Workday alcohol consumption Females vs Male percentage.
ggplot(data = student_por, aes(x = Dalc, fill = sex)) + 
  geom_bar(position = "dodge") + 
  scale_x_continuous(name="Workday Alcohol consumption")
  # scale_y_continuous(labels=scales::percent)

# Weekend alcohol consumption Females vs Male percentage.
ggplot(data = student_por, aes(x = Walc, fill = sex)) + 
  geom_bar(position = "fill") +
  scale_x_continuous(name="Weekend Alcohol consumption")


#Families with more than 3 people and Families with less or equal to 3
ggplot(data = student_por, aes(x = famsize, fill = famsize)) + 
  geom_bar(position = "dodge")

# Weekend alcohol consumption per family size.
ggplot(data = student_por, aes(x = Walc, fill = famsize)) + 
  geom_bar(position = "fill")

# Workday alcohol consumption per family size.
ggplot(data = student_por, aes(x = Dalc, fill = famsize)) + 
  geom_bar(position = "fill")


#Parents status
ggplot(data = student_por, aes(x = Pstatus)) + 
  geom_bar(position = "dodge") +
  scale_x_discrete(breaks=c("A","T"),
                   labels=c("Apart", "Together"))

# Weekend alcohol consumption per family size.
ggplot(data = student_por, aes(x = Walc, fill = Pstatus)) + 
  geom_bar(position = "dodge")

# Workday alcohol consumption per family size.
ggplot(data = student_por, aes(x = Dalc, fill = Pstatus)) + 
  geom_bar(position = "dodge")


# Parents education (can they be combined?)
ggplot(data = student_por, aes(x = Fedu)) + 
  geom_bar()

ggplot(data = student_por, aes(x = Medu)) + 
  geom_bar()

ggplot(data = student_por, aes(x = Dalc, y = freetime)) + 
  geom_point() +
  geom_jitter()

ggplot(data = student_por, aes(x = Walc, y = freetime)) + 
  geom_point() +
  geom_jitter()

ggplot(student_por, aes(x=age, fill=Dalc))+
  geom_histogram(binwidth=1, colour="black")+
  facet_grid(~Dalc)+
  theme_bw()+
  theme(legend.position="none")+
  ggtitle("Workday alcohol consumption per age")+
  xlab("Student's age")

ggplot(student_por, aes(x=age, fill=Walc))+
  geom_histogram(binwidth=1, colour="black")+
  facet_grid(~Walc)+
  theme_bw()+
  theme(legend.position="none")+
  ggtitle("Weekend alcohol consumption per age")+
  xlab("Student's age")
