
# Libraries

library(ggplot2)
library(tidyverse)
library(plotly)
library(flexdashboard)
library(readr)

# Load data set
Lin_marks <- read_csv("Stat Send Linear Algebra Final Marks.csv")
colnames(Lin_marks)

# Rename column names
Lin_marks <- Lin_marks %>% rename(Index_No = "Dummy\n Index Numbers", 
Mid_34 = "Mid Exam Marks\n(Out of 34)",
Mid_20 = "Mid Exam Marks\n(Out of 20)",
Final_80 = "Final Exam Marks\n(Out of 80)",
Marks_1 = "Marks 1 \n(Mid+Final)\n(Out of 100)",
Marks_2 = "Marks 2\n(Final/80*100)\n(Out of 100)",    
Grand_Final = "Max(Mark 1,Mark 2)\n(Out of 100)",
Lec_1 =  "5/26/2023",
Lec_2 = "6/16/2023",
Lec_3 = "6/23/2023",
Lec_4 = "7/7/2023",
Lec_5 = "7/14/2023",
Lec_6 = "8/4/2023",
Lec_7 = "8/18/2023")                                    

# Drop columns
Lin_marks <- Lin_marks %>% select(-c("Grand Final Marks\nAfter Rounding","Final Exam Attendance\nPresent(1)/\nAbsent(ab)","...10" ))

# Create Total Attendance variable
Lin_marks <- Lin_marks %>% mutate(Total_Attendance = Lec_1 + Lec_2 + Lec_3 +Lec_4 + Lec_5 + Lec_6 + Lec_7)

# Save data set
write.csv(Lin_marks,"Clean data set.csv")
