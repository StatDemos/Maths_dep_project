# Loading libraries
library(tidyverse)
library(GGally)
library(psych)
library(plotly)

# Loading dataset
marks_data <- read_csv("Clean data set.csv")

################################################################################
################################################################################

### Summary Measures

################################################################################

## Average Attendance for all lectures (mean and standard deviation)

mean(marks_data$Total_Attendance)
sd(marks_data$Total_Attendance)

################################################################################

## Average Attendance for per lecture (mean and standard deviation)

attend_per_lec_data <- data.frame(
  lec_no = c(1:7),
  total_attendance_lec = c(sum(marks_data$Lec_1),
                           sum(marks_data$Lec_2),
                           sum(marks_data$Lec_3),
                           sum(marks_data$Lec_4),
                           sum(marks_data$Lec_5),
                           sum(marks_data$Lec_6),
                           sum(marks_data$Lec_7))
)

mean(attend_per_lec_data$total_attendance_lec)
sd(attend_per_lec_data$total_attendance_lec)

################################################################################
################################################################################

### Graphs

# Bar chart of students attendance per lecture
marks_data_g1 <- marks_data %>% select(9:15) %>% 
  pivot_longer(cols = 1:7, names_to = "Lecture.Number", values_to = "Attendance") %>%
  filter(Attendance == 1)

ggplot(marks_data_g1, aes(x=Lecture.Number)) + geom_bar(fill = "#189bb5") + 
  labs(title = "Students attendance per lecture", x = "Lecture", 
       y = "Total number of students") + 
  geom_text(aes(label=after_stat(count)),stat='count',position=position_dodge(0.9),
            vjust=-0.2)

# Bar chart of Total attendance
ggplot(marks_data, aes(x=Total_Attendance)) + geom_bar(fill = "#189bb5") + 
  labs(title = "Total count of student's attendance for lectures", 
       x = "Number of lectures", 
       y = "Total number of students") + 
  geom_text(aes(label=after_stat(count)),stat='count',position=position_dodge(0.9),
            vjust=-0.2) + scale_x_continuous(breaks = seq(0,7,1))


# Histogram for Mid marks (original marks for paper)
ggplot(marks_data, aes(x = Mid_34)) + 
  geom_histogram(aes(y = ..count..), fill = "darkblue", alpha = 0.5, color = "darkgray", bins = 30) +
  #geom_density(alpha = 0.3, fill = "blue") +
  labs(title = "Distribution of mid exam marks", 
       x = "Mid exam marks (out of 34)", 
       y = "Number of students") 

# Histogram for Final marks (original marks for paper)
ggplot(marks_data, aes(x = Grand_Final)) + 
  geom_histogram(aes(y = ..count..), fill = "darkblue", alpha = 0.5, color = "darkgray", bins = 30) +
  #geom_density(alpha = 0.3, fill = "blue") +
  labs(title = "Distribution of final exam marks", 
       x = "Final exam marks (out of 100)", 
       y = "Number of students") 

# Distribution of mid marks by attendance
marks_data %>%
  mutate(Total_Attendance = as.factor(Total_Attendance)) %>%
  ggplot(aes(y = Mid_34, x = Total_Attendance, fill = Total_Attendance)) + 
  geom_boxplot() +
  labs(title = "Distribution of mid exam marks by attendance", 
       x = "Total Attendance", 
       y = "Mid exam marks (out of 34)") 

# Distribution of final marks by attendance
marks_data %>%
  mutate(Total_Attendance = as.factor(Total_Attendance)) %>%
  ggplot(aes(y = Grand_Final, x = Total_Attendance, fill = Total_Attendance)) + 
  geom_boxplot() +
  labs(title = "Distribution of final exam marks by attendance", 
       x = "Total Attendance", 
       y = "Final exam marks (out of 100)") 


# Scatter plot matrix 
# Function to return points and geom_smooth
# allow for the method to be changed
my_fn <- function(data, mapping, method="loess", ...){
  p <- ggplot(data = data, mapping = mapping) + 
    geom_point() + 
    geom_smooth(method=method, ...)
  p
}

# Use wrap to add further arguments; change method to lm

ggpairs(marks_data, columns = c("Mid_34", "Marks_2", "Grand_Final", "Total_Attendance"),
        columnLabels = c("Mid Marks", "Final Marks", "Grand Final Marks", "Total Attendance"),
        # lower = list(continuous = wrap(my_fn, method="lm", colour = "red")),
        diag = list(continuous = wrap("barDiag", fill = "#189bb5", colour = "black")))


# scatter plot for mid marks (out of 34) vs final marks (out of 100 for paper)
ggplot(marks_data, aes(x=Mid_34, y=Marks_2))+ 
  geom_point()+  
  # geom_smooth(method=lm , color="red", se=FALSE) +
  xlim(0,34)+ 
  ylim(0,100) + 
  labs( 
    title = "Scatter plot for mid marks (out of 34) vs final marks (out of 100 for paper)",
    x = "Mid exam marks (out of 34)", 
    y = "Final exam marks (out of 100)") 


# Total attendance vs Final grand mark
ggplot(marks_data, aes(x=Total_Attendance, y=Grand_Final))+ 
  geom_point()+  
  # geom_smooth(method=lm , color="red", se=FALSE) +
  labs(
    title = "Scatter plot for total attendance vs final grand mark",
    x = "Total Attendance", 
    y = "Grand final exam marks") 

################################################################################
################################################################################