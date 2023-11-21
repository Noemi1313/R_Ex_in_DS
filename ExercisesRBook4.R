# Exercises of R Jupyter Notebook 
# Chapter 4
# Noemi Carolina Guerra Montiel
# November 2023

########## CHAPTER 4.2

# 1. Examine the built-in dataset co2. Which of the following is true:
data("co2")
co2
class(co2)
# d. co2 is not tidy: to be tidy we would have to wrangle it to have three columns 
# (year, month and value), then each co2 observation would have a row.

# 2. Examine the built-in dataset ChickWeight. Which of the following is true:
data("ChickWeight")
ChickWeight
class(ChickWeight)
# b. ChickWeight is tidy: each observation (a weight) is represented by one row. 
# The chick from which this measurement came is one of the variables.

# 3. Examine the built-in dataset BOD. Which of the following is true:
data("BOD")
BOD
class(BOD)
# c. BOD is tidy: each row is an observation with two values (time and demand)

# 4. Which of the following built-in datasets is tidy (you can pick more than one):
data("BJsales")
BJsales
# BJSales NO
data("EuStockMarkets")
EuStockMarkets
class(EuStockMarkets)
# EuStockMarkets NO
data("DNase")
DNase
class(DNase)
# DNase YES
data("Formaldehyde")
Formaldehyde
class(Formaldehyde)
# Formaldehyde YES
data("Orange")
Orange
class(Orange)
# Orange YES
data("UCBAdmissions")
UCBAdmissions
class(UCBAdmissions)
# UCBAdmissions NO

########## CHAPTER 4.4

# 1. Use the function mutate to add a murders column named rate with the per 
# 100,000 murder rate as in the example code above. 
library(dplyr)
library(dslabs)
murders <- mutate(murders, rate = total / population * 100000)
murders

# 2. Use the function mutate to add a column rank containing the rank, 
# from highest to lowest murder rate
murders <- mutate(murders, rank = rank(-rate))
murders

# 3. Use select to show the state names and abbreviations in murders.
select(murders, state, abb) |> head()

# 4. Use filter to show the top 5 states with the highest murder rates. 
# After we add murder rate and rank, do not change the murders dataset, just show the result. 
filter(murders, rank < 6)

# 5. Create a new data frame called no_south that removes states from the South region. 
# How many states are in this category? You can use the function nrow for this.
no_south <- filter(murders, region != 'South')
nrow(no_south)
no_south

# 6. Create a new data frame called murders_nw with only the states from the 
# Northeast and the West. How many states are in this category?
murders_nw <- filter(murders, region %in% c("Northeast", "West"))
nrow(murders_nw)
murders_nw

# 7. Create a table called my_states that contains rows for states satisfying 
# both the conditions: it is in the Northeast or West and the murder rate is less than 1. 
# Use select to show only the state name, the rate, and the rank.
my_states <- filter(murders, region %in% c("Northeast", "West") & rate < 1)
select(my_states, state, rate, rank)

########## CHAPTER 4.6
# Without pipe operator
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))
my_states <- filter(murders, region %in% c("Northeast", "West") & rate < 1)
select(my_states, state, rate, rank)

# With pipe operator, only one variable
my_states <- murders |> mutate (rate =  total / population * 100000, rank = rank(-rate)) |> filter (region %in% c("Northeast", "West") & rate < 1) |> select (state, rate, rank)
my_states

########## CHAPTER 4.10
# Install NHANES package
install.packages("NHANES")
# Access the data
library(NHANES)
data("NHANES")

# 1. We will provide some basic facts about blood pressure. 
# First let’s select a group to set the standard. 
# We will use 20-to-29-year-old females. 
# AgeDecade is a categorical variable with these ages. 
# Note that the category is coded like ” 20-29”, with a space in front! 
# What is the average and standard deviation of systolic blood pressure as saved 
# in the BPSysAve variable? 
# Save it to a variable called ref.
ref <- NHANES |> filter(AgeDecade == " 20-29") |> summarize(average = mean(BPSysAve, na.rm = TRUE), standard_deviation = sd(BPSysAve, na.rm = TRUE))
ref

# 2. Using a pipe, assign the average to a numeric variable ref_avg.
ref_avg <- ref |> pull(average)
ref_avg

# 3. Now report the min and max values for the same group.
NHANES |> filter(AgeDecade == " 20-29") |> summarize(minimum = min(BPSysAve, na.rm = TRUE), maximum = max(BPSysAve, na.rm = TRUE))

# 4. Compute the average and standard deviation for females, 
# but for each age group separately rather than a selected decade as in 
# question 1. Note that the age groups are defined by AgeDecade.
NHANES |> filter(Gender == "female") |> group_by(AgeDecade) |> summarize(average = mean(BPSysAve, na.rm = TRUE), standard_deviation = sd(BPSysAve, na.rm = TRUE))

# 5. Repeat exercise 4 for males.
NHANES |> filter(Gender == "male") |> group_by(AgeDecade) |> summarize(average = mean(BPSysAve, na.rm = TRUE), standard_deviation = sd(BPSysAve, na.rm = TRUE))

# 6. We can actually combine both summaries for exercises 4 and 5 into one 
# line of code. This is because group_by permits us to group by more than one 
# variable. Obtain one big summary table using group_by(AgeDecade, Gender).
NHANES |> group_by(AgeDecade, Gender) |> summarize(average = mean(BPSysAve, na.rm = TRUE), standard_deviation = sd(BPSysAve, na.rm = TRUE))

# 7. For males between the ages of 40-49, compare systolic blood pressure 
# across race as reported in the Race1 variable. Order the resulting table 
# from lowest to highest average systolic blood pressure.
NHANES |> filter(Gender == "male" & AgeDecade == " 40-49") |> group_by(Race1) |> summarize(average = mean(BPSysAve, na.rm = TRUE)) |> arrange(average)

########## CHAPTER 4.15
# 1. Load the murders dataset. Which of the following is true?
data(murders)
murders
# b. murders is in tidy format and is stored in a data frame.

# 2. Use as_tibble to convert the murders data table into a tibble 
# and save it in an object called murders_tibble.
murders_tibble <- as_tibble(murders)
murders_tibble

#3. Use the group_by function to convert murders into a tibble 
# that is grouped by region.
murders |> group_by(region)

# 4. Write tidyverse code that is equivalent to this code:
exp(mean(log(murders$population)))
# Write it using the pipe so that each function is called 
# without arguments. Use the dot operator to access the population.
library(purrr)
murders |> pull(population) |> log() |> mean() |> exp()

# 5. Use the map_df to create a data frame with three columns named n, 
# s_n, and s_n_2. The first column should contain the numbers 1 
# through 100. The second and third columns should each contain the 
# sum of 1 through n with n the row number.
create_df <- function(x){
  n <- x
  s_n <- 1 + x
  s_n_2 <- 1 + (x)^2
  data.frame(n = n, s_n = s_n, s_n_2 = s_n_2)
}
df <- map_df(1:100, create_df)
df

