# Loading libraries
library(tidyverse)
library(GGally)
library(psych)
library(plotly)

# Loading dataset
marks_data <- read_csv("Clean data set.csv")

################################################################################
################################################################################

### Graphs

# Bar chart of students attendance per lecture
marks_data_g1 <- marks_data %>% select(9:15) %>% 
  pivot_longer(cols = 1:7, names_to = "Lecture.Number", values_to = "Attendance") %>%
  filter(Attendance == 1)

ggplot(marks_data_g1, aes(x=Lecture.Number)) + geom_bar(fill = "#189bb5") + 
  labs(title = "Students attendance per lecture", x = "Lecture", 
       y = "Total attendace") + 
  geom_text(aes(label=after_stat(count)),stat='count',position=position_dodge(0.9),
            vjust=-0.2)

# Bar chart of Total attendance
ggplot(marks_data, aes(x=Total_Attendance)) + geom_bar(fill = "#189bb5") + 
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

# Distribution of mid marks by attendance
marks_data %>%
  mutate(Total_Attendance = as.factor(Total_Attendance)) %>%
  ggplot(aes(y = Mid_34, x = Total_Attendance, fill = Total_Attendance)) + 
  geom_boxplot() +
  labs(title = "Distribution of final exam marks by attendance", 
       x = "Mid exam marks (out of 34)", 
       y = "Total Attendance") 

# Distribution of final marks by attendance
marks_data %>%
  mutate(Total_Attendance = as.factor(Total_Attendance)) %>%
  ggplot(aes(y = Grand_Final, x = Total_Attendance, fill = Total_Attendance)) + 
  geom_boxplot() +
  labs(title = "Distribution of final exam marks by attendance", 
       x = "Total Attendance", 
       y = "Final exam marks (out of 100)") 

# Scatter plot matrix (Total attendance as a factor)
marks_data$Total_Attendance <- as.factor(marks_data$Total_Attendance)
ggpairs(marks_data, columns = c("Mid_34", "Marks_2", "Grand_Final", "Total_Attendance"), 
        columnLabels = c("Mid Marks", "Final Marks", "Grand Final Marks", "Total Attendance"))

# Scatter plot matrix (Total attendance as a numeric)
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
        lower = list(continuous = wrap(my_fn, method="lm", colour = "red")),
        diag = list(continuous = wrap("barDiag", fill = "#189bb5", colour = "black")))


# Other Scatter plot matrices
marks_data_g2 <- marks_data %>% select("Mid_34", "Marks_2", "Grand_Final", "Total_Attendance")
pairs.panels(marks_data_g2, 
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE, # show density plots
             ellipses = FALSE)

# scatter plot for mid marks (out of 34) vs final marks (out of 100 for paper)
ggplot(marks_data, aes(x=Mid_34, y=Marks_2))+ 
  geom_point()+  geom_smooth(method=lm , color="red", se=FALSE) +
  xlim(0,34)+ 
  ylim(0,100) + 
  labs( 
    x = "Mid exam marks (out of 34)", 
    y = "Final exam marks (out of 100)") 

# scatter plot for mid marks (out of 20) vs final marks (out of 80 for paper)
ggplot(marks_data, aes(x=Mid_20, y=Final_80))+ 
  geom_point()+  geom_smooth(method=lm , color="red", se=FALSE) +
  xlim(0,20)+ 
  ylim(0,80) +
  labs(
    x = "Mid exam marks (out of 20)", 
    y = "Final exam marks (out of 80)") 

# Total attendance vs Final grand mark
p1 <- ggplot(marks_data, aes(x=Total_Attendance, y=Grand_Final))+ 
  geom_point()+  geom_smooth(method=lm , color="red", se=FALSE) +
  labs(
    x = "Total Attendance", 
    y = "Grand final exam marks") 

ggplotly(p1)

################################################################################
################################################################################

### Summary Measures

################################################################################

## Attendance per lecture (mean and standard deviation)

# lecture 1
mean(marks_data$Lec_1)
sd(marks_data$Lec_1)

# lecture 2
mean(marks_data$Lec_2)
sd(marks_data$Lec_2)

# lecture 3
mean(marks_data$Lec_3)
sd(marks_data$Lec_3)

# lecture 4
mean(marks_data$Lec_4)
sd(marks_data$Lec_4)

# lecture 5
mean(marks_data$Lec_5)
sd(marks_data$Lec_5)

# lecture 6
mean(marks_data$Lec_6)
sd(marks_data$Lec_6)

# lecture 7
mean(marks_data$Lec_7)
sd(marks_data$Lec_7)

################################################################################

## Average Attendance for all lectures (mean and standard deviation)

mean(as.numeric(marks_data$Total_Attendance))
sd(as.numeric(marks_data$Total_Attendance))








