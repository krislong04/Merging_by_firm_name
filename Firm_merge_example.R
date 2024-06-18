
# File Info ---------------------------------------------------------------
  # Title: Merge Company Names Example
  # Date: June 2024
  # Author: Kris Long, RA KU Trade War Lab
  # R Version: R version 4.3.3 (2024-02-29) -- "Angel Food Cake"

# Set up ------------------------------------------------------------------

 # clear R
 rm(list = ls())

 # Set working directory (yours will be different)
 setwd("/Users/kristopherlong/Desktop/KU/Research/Trade_War_Lab/USTR_paper")

 # Load packages
 library(dplyr)
 library(tidyverse)
 library(stringr)
 library(readxl)
 library(openxlsx)

 # Load data (yours will be different)
 df1 <- read_excel("List12_testify.xlsx", na = "NA")
 df2 <- read_excel("USTR Lobbying 2016-2021.xlsx", na = "NA", sheet = "2018")
 
 
 # Create keys -------------------------------------------------------------
 
  # Because creating key columns removes information from the company names that
  # is important to have later, it is better to copy the names into a new column 
 # labeled "key" than just change the names directly. 
 
 df1 <- 
   df1 %>%
   mutate(key = Organisation)
 
 df2 <- 
   df2 %>%
   mutate(key = Organization)
 
# Regex expressions to create key column
 
 # These are the list of strings I find useful to take out. You could use any 
 # combination, but make sure the key column of both variables have the same
 # strings removed in the same order. Even if one data set has a key column made this
 # way, it is sometimes safer to create your own key to ensure you have removed the 
 # exact same strings. 
 
 # If you choose your own set of strings, be considerate about the order you run them in.
 # For example, if have code to remove "co" before you remove "company", then all the 
 # string values that were originally "company" will read "mpany," and the code will
 # not work. Start with longer expressions and end with shorter ones. It is
 # always a good idea to remove all punctuation first. It is also important to use an 
 # "ignore.case" argument. This does not make all the strings lowercase (unfortunately 
 # that is not an option with gsub), but it does remove both "LLC" and "llc" equally. 
 
 df1$key <- gsub("[[:punct:]]", "", df1$key)
 df1$key <- gsub("(?i)dba.*", "", df1$key, perl = TRUE,
                          ignore.case = TRUE)
 df1$key <- gsub(" incorporated", "", df1$key, 
                          ignore.case = TRUE)
 df1$key <- gsub(" corporation", "", df1$key,
                          , ignore.case = TRUE)
 df1$key <- gsub(" company", "", df1$key,
                          , ignore.case = TRUE)
 df1$key <- gsub(" corp", "", df1$key,
                          ignore.case = TRUE)
 df1$key <- gsub(" inc", "", df1$key, 
                          ignore.case = TRUE)
 df1$key <- gsub(" llc", "", df1$key, 
                          ignore.case = TRUE)
 df1$key <- gsub(" co", "", df1$key, 
                          ignore.case = TRUE)
 
 # Do the exact same things for your second data frame
 
 df2$key <- gsub("[[:punct:]]", "", df2$key)
 df2$key <- gsub("(?i)dba.*", "", df2$key, perl = TRUE,
                 ignore.case = TRUE)
 df2$key <- gsub(" incorporated", "", df2$key, 
                 ignore.case = TRUE)
 df2$key <- gsub(" corporation", "", df2$key,
                 , ignore.case = TRUE)
 df2$key <- gsub(" company", "", df2$key,
                 , ignore.case = TRUE)
 df2$key <- gsub(" corp", "", df2$key,
                 ignore.case = TRUE)
 df2$key <- gsub(" inc", "", df2$key, 
                 ignore.case = TRUE)
 df2$key <- gsub(" llc", "", df2$key, 
                 ignore.case = TRUE)
 df2$key <- gsub(" co", "", df2$key, 
                 ignore.case = TRUE)

# Join --------------------------------------------------------------------
 # Use a join function to merge the two data frames
 # Full Join
 joined1 <- full_join(df1, df2, by = c("key" = "key"))
 
 # Left join (right join is this in reverse)
 joined2 <- left_join(df1, df2, by = c("key" = "key"))
 
 # If you use a left or right join there are always firms that will still not
 # match over because their names are different in more complicated ways, like
 # misspellings. You can collect data to cross references by hand by doing the 
 # opposite join and filtering out left join matches. 
 check_by_hand <-  right_join(df1, df2, by = c("key" = "key"))
 check_by_hand <-
   check_by_hand %>%
   filter(is.na(variable))
 
 
 
 
  


