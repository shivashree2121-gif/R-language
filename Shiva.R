
#name <- "R Language"    
#age <- 22               
#marks <- 84.6           
#result <- TRUE          

print(name)
print(age)
print(marks)
print(result)

#a <- 12
#b <- 2

print(a + b)   
print(a - b)  
print(a * b)   
print(a / b)   
print(a %% b) 
print(a ^ b)

#a <- 52
#b <- 35

print(a > b)
print(a < b)
print(a == b)
print(a != b)

x <- FALSE
y <- TRUE

print(x & y)
print(x | y)
print(!y)

#name <- readline(prompt = "Enter student name: ")
#mark <- as.numeric(readline(prompt = "Enter mark: "))

print(name)
print(mark)

age <- 21

if(age >= 18)

{

print("Eligible to Vote")

}

else

{

 print("Not Eligible")

}

age <- 70

if(age >= 90)
  
{
  print("Super senior citizen")
  
}

else if(age >= 60)
  
{
  
  print("senior citizen")
  
}else
  
{
  print("Fail")
}

sub <- "mat"

result <- switch(sub,
                 sci = "science",
                 soc = "social",
                 mat = "maths",
                 "Invalid sub")

print(result)

l <- c(12,55,22)
print(sum(l))


for(i in 1:5)
{
  print(i)
}
  
for(i in 1:20) {
  
  if(i == 12) {
    break
  }
  
  print(i)
}


i <- 6
repeat
  
{
  print(i)
  
  i <- i + 1
  
  if(i > 10)
    
  {
    
    break
    
  }
  
}

mark <- c(65,88,91)
print(mean(mark))

a <- c(122,666,549,899)

print(max(a))
print(min(a))

hello <- "shiva"
print(paste("Welcome", hello))

x <- c(4,6,7,1)
print(sort(x))

print(toupper("hi"))
print(tolower("BRO"))

print(rep("hii", "3"))

print(seq(1, 18, by = 2.5))

display <- function() {
  print("heloww")
}

display()

add <- function(a, b) {
  print(a + b)
}

add(50,20)

getNumber <- function() {
  num <- 9
  return(num)
}
result <- getNumber()
print(result)

multiply <- function(a, b) {
  result <- a * b
  return(result)
}

answer <- multiply(199,6)
print(answer)

#module ggplot
install.packages("ggplot2")
library(ggplot2)
x <- c(1,2,3,4,5)
y <- c(10,20,30,40,50)
data <- data.frame(x,y)
ggplot(data, aes(x,y)) +geom_line()

x <- c(5,3,8,9,4)
y <- c(10,20,30,40,50)
data <- data.frame(x,y)
ggplot(data, aes(x,y)) +geom_point()


x <- c(5,3,8,9,4)
#y <- c(20,5,6,9,12)
data <- data.frame(x)
ggplot(data, aes(x)) +geom_bar()


x <- c(5,3,8,9,4)
#y <- c(20,5,6,9,12)
data <- data.frame(x)
ggplot(data, aes(x)) +geom_histogram()


x <- c(5,3,8,9,4)
y <- c(20,5,6,9,12)
data <- data.frame(x,y)
ggplot(data, aes(x,y)) +geom_smooth()

x <- c(5,3,8,9,4)
y <- c(20,5,6,9,12)
data <- data.frame(x,y)
ggplot(data, aes(x,y)) +geom_col()


x <- c(5,3,8,9,4)
y <- c(20,5,6,9,12)
data <- data.frame(x,y)
ggplot(data, aes(x,y)) +geom_boxplot()

#Module dplyr
install.packages("dplyr")
library(dplyr)
student <- data.frame(name=c("Ram","Sam","Tom"),mark=c(80,45,90))
filter(student, mark > 50)

#module stringr
install.packages("stringr")

library(stringr)
  
name <- "shivashree"
str_length(name)

#module readr
install.packages("readr")
library(readr)
data <- read_csv("C:/Users/shiva/Downloads/StudentPerformanceFactors.csv")
print(data)

#module lubridate
install.packages("lubridate")
library(lubridate)
today()

#module caret
install.packages("caret")
library(caret)
data(iris)
print(head(iris))

#module randomForest
install.packages("randomForest")
library(randomForest)
data(iris)
model <- randomForest(Species ~ ., data=iris)
print(model)

#module shiny
install.packages("shiny")
library(shiny)
ui <- fluidPage(
  "Hello R Shiny")
server <- function(input, output){}
shinyApp(ui, server)

#module tidyr
install.packages("tidyr")
library(tidyr)
data <- data.frame(
  name = c("Ram", NA, "Tom")
)
drop_na(data)
replace_na(data, list(name = "Unknown"))

#module tidyverse
install.packages("tidyverse")
library(tidyverse)

data <- tibble(
  name = c("A", "B"),
  mark = c(70, 90)
)

print(data)
 


