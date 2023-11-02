# Loading libraries
library(tidyverse)


# Loading dataset
marks_data <- read_csv("Clean data set.csv")

# Graphs

# Bar chart of students attendance per lecture
marks_data_g1 <- marks_data %>% select(9:15) %>% 
  pivot_longer(cols = 1:7, names_to = "Lecture.Number", values_to = "Attendance") %>%
  filter(Attendance == 1)

ggplot(marks_data_g1, aes(x=Lecture.Number)) + geom_bar(fill = "darkgray") + 
  labs(title = "Students attendance per lecture", x = "Lecture", 
       y = "Total attendace") + 
  geom_text(aes(label=after_stat(count)),stat='count',position=position_dodge(0.9),
            vjust=-0.2)

# Bar chart of Total attendance
ggplot(marks_data, aes(x=Total_Attendance)) + geom_bar(fill = "darkgray") + 
  labs(title = "Total count of student's attendance for lectures", 
       x = "Number of lectures", 
       y = "Total attendace") + 
  geom_text(aes(label=after_stat(count)),stat='count',position=position_dodge(0.9),
            vjust=-0.2) + scale_x_continuous(breaks = seq(0,7,1))

# Histogram for Mid marks (original marks for paper)
ggplot(marks_data, aes(x = Mid_34)) + 
  geom_histogram(aes(y = ..density..), fill = "gray", color = "darkgray", bins = 30) +
  geom_density(alpha = 0.3, fill = "blue") +
  labs(title = "Distribution of mid exam marks", 
       x = "Mid exam marks (out of 34)", 
       y = "Frequency") 

# Histogram for Final marks (original marks for paper)
ggplot(marks_data, aes(x = Grand_Final)) + 
  geom_histogram(aes(y = ..density..), fill = "gray", color = "darkgray", bins = 30) +
  geom_density(alpha = 0.3, fill = "blue") +
  labs(title = "Distribution of final exam marks", 
       x = "Final exam marks (out of 100)", 
       y = "Frequency") 








