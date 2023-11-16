# Exercises of R Jupyter Notebook 
# Chapter 3
# Noemi Carolina Guerra Montiel
# November 2023

# 1. What will this conditional expression return?
x <- c(1,2,-3,4)

if(all(x>0)){
  print("All Postives")
} else{
  print("Not all positives")
}

# 2. Which of the following expressions is always FALSE when at least one 
# entry of a logical vector x is TRUE?
x <- c(TRUE, FALSE, FALSE)
all(x)
any(x)
any(!x)
all(!x)

# 3. The function nchar tells you how many characters long a character vector is. 
# Write a line of code that assigns to the object new_names the state abbreviation 
# when the state name is longer than 8 characters.

# TRAD APPROACH

# Function to evaluate what names are longer than 8 characters
state_name_len <- function(x, i){
  if (nchar(x) > 8){
    new_names <- murders$abb[i]
  }
  else{
    new_names <- murders$state[i]
  }
}

name_state = murders$state # Select the states name
ind = 1:length(name_state) # Select indices
res <- c() # Create an empty vector for the result

# Apply a for loop to go through the list of states
for (i in ind){
  res <- append(res, state_name_len(name_state[i], i))
}
res

# OTHER APPROACH
new_names <- ifelse(nchar(murders$state) > 8, murders$abb, murders$state)
new_names

# 4. Create a function sum_n that for any given value, say n
# , computes the sum of the integers from 1 to n (inclusive). 
# Use the function to determine the sum of integers from 1 to 5,000.
sum_n <- function(n){
  x <- 1:n
  sum(x)
}
sum_n(5000)

# 5. Create a function altman_plot that takes two arguments, x and y, and plots 
# the difference against the sum.
altman_plot <- function(x, y){
  dif <- x-y
  s <- x+y
  plot(dif, s)
}
altman_plot(5,3)

# 6. After running the code below, what is the value of x?
x <- 3
my_func <- function(y){
  x <- 5
  y+5
}
# x = 3

# 7. Write a function compute_s_n that for any given n computes the sum 
# Sn = 1^2 + 2^2 + 3^2 + n^2
# Report the value of the sum when n = 10.
compute_s_n <- function(n){
  x <- 1:n
  n2  = x^2
  Sn = sum(n2)
}
r <- compute_s_n(10)
r

# 8. Define an empty numerical vector s_n of size 25 using s_n <- vector("numeric",
# 25) and store in the results of using a for-loop.
n <- 25
s_n <- vector("numeric", n)
for(i in 1:n){
  s_n[i] <- compute_s_n(i)
}
s_n

# 9. Repeat exercise 8, but this time use sapply.
sapply(1:25, compute_s_n)

# 10. Repeat exercise 8, but this time use map_dbl.
library(purrr)
map_dbl(1:25, compute_s_n)

# 11. Plot Sn versus n. Use points defined by n = 1,...,25.
n <- 1:25
s_n <- sapply(1:25, compute_s_n)
plot(n, s_n)

# 12 Confirm that the formula for this sum is Sn = n(n+1)(2n+1) / 6
Sn <- (n * (n+1) * (2*n+1)) / 6
Sn

