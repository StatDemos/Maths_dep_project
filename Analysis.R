# Loading libraries
library(tidyverse)


# Loading dataset
marks_data <- read_csv("Clean data set.csv")

# Graphs

# Bar chart
marks_data_g1 <- marks_data %>% select(9:15) %>% 
  pivot_longer(cols = 1:7, names_to = "Lecture.Number", values_to = "Attendance") %>%
  filter(Attendance == 1)

ggplot(marks_data_g1, aes(x=Lecture.Number)) + geom_bar() + 
  labs(title = "Students attendance per lecture", x = "Lecture number", 
       y = "Total attendace") + 
  geom_text(aes(label=after_stat(count)),stat='count',position=position_dodge(0.9),
            vjust=-0.2)


# Histogram

ggplot(marks_data) + geom_histogram(aes(Total_Attendance))

ggplot(marks_data) + geom_histogram(aes(Mid_34))

ggplot(marks_data) + geom_histogram(aes(Grand_Final))




