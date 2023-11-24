# Exercises of R Jupyter Notebook 
# Chapter 5
# Noemi Carolina Guerra Montiel
# November 2023

########## CHAPTER 5.3
# 1. Use the read_csv function to read each of the files that the following 
# code saves in the files object:
path <- system.file("extdata", package = "dslabs")
files <- list.files(path)
files

library(readr)
library(readxl)

read_xls(paste(path,"/2010_bigfive_regents.xls", sep=''))

read_lines(paste(path,"/carbon_emissions.csv", sep=''), n_max=3)
read_csv(paste(path,"/carbon_emissions.csv", sep=''))

read_lines(paste(path,"/fertility-two-countries-example.csv", sep=''), n_max=3)
read_csv(paste(path,"/fertility-two-countries-example.csv", sep=''))

read_lines(paste(path,"/HRlist2.txt", sep=''), n_max=3)
read_table(paste(path,"/HRlist2.txt", sep=''))

read_lines(paste(path,"/life-expectancy-and-fertility-two-countries-example.csv", sep=''), n_max=3)
read_csv(paste(path,"/life-expectancy-and-fertility-two-countries-example.csv", sep=''))

read_lines(paste(path,"/murders.csv", sep=''), n_max=3)
read_csv(paste(path,"/murders.csv", sep=''))

read_lines(paste(path,"/olive.csv", sep=''), n_max=3)
read_csv(paste(path,"/olive.csv", sep=''))

read_lines(paste(path,"/RD-Mortality-Report_2015-18-180531.pdf", sep=''))
read_csv(paste(path,"/RD-Mortality-Report_2015-18-180531.pdf", sep=''))

read_lines(paste(path,"/ssa-death-probability.csv", sep=''), n_max=3)
read_csv(paste(path,"/ssa-death-probability.csv", sep=''))

# 2. Note that the last one, the olive file, gives us a warning. 
# This is because the first line of the file is missing the header for the first column.
dat <- read_csv(paste(path,"/olive.csv", sep=''), col_names = FALSE)
dat

# 3. A problem with the previous approach is that we don’t know what the columns represent. Type:
names(dat)
# to see that the names are not informative.
# Use the readLines function to read in just the first line (we later learn 
# how to extract values from the output).
readLines(paste(path,"/olive.csv", sep=''), n=1)
