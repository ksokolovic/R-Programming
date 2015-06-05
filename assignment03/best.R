best <- function(state, outcome) {
    ## A function reads the outcome-of-core-measures.csv file
    ## and returns a character vector with the name of the 
    ## hospital that has the best (i.e. lowest) 30-day mortality 
    ## for the specified outcome in that state. 
    ## The hospital name is the name provided in the "Hospital.Name"
    ## variable; the outcomes can be one of "heart attack", "heart
    ## failure" or "pneumonia". Hospitals that do not have data
    ## on a particular outcome are excluded from the set of hospitals
    ## when deciding the ranking.
    ## NOTE: If there is a tie for the best hospital for a given outcome
    ## then the hospital names should be sorted in alphabetical order and 
    ## the first hospital in that set should be chosen. 
    ##
    ## Args:
    ##  'state' : The 2-character abbreviated name of a state.
    ##  'outcome' : Outcome name.
    ## 
    ## Returns:
    ##  A character vector with the name of the hospital that has the
    ##  best 30-day mortality for the specified outcome in the given
    ##  state.
    
    # Read the outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # Check that state and outcome are valid
    if(!(state %in% data$State)) {
        stop("invalid state")
    }
    if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
        stop("invalid outcome")
    } 
    
    # Handle only the data of the required state
    data <- data[data$State == state, ]
    
    # Get the index of the column containing the data of interest, based 
    # on the outcome specified
    data_col <- colOfInterest(outcome)
    # Switch from character to numeric data type a column of interest
    data[, data_col] <- as.numeric(data[, data_col])
    
    # Return hospital name in that state with lowest 30-day death
    # rate
    # data[which(data[, data_col] == min(data[, data_col], na.rm = TRUE)), ]
    min_rate <- min(data[, data_col], na.rm = TRUE)
    min_rate_row <- data[which(data[, data_col] == min_rate), ]
    
    # Hospital name is stored in the second column
    hospital <- min_rate_row[2][[1]]
    
    hospital
}

colOfInterest <- function(outcome) {
    ## A function returns the index of the column containing the data of interest
    ## based on the outcome specified and knowing the structure of the CSV data 
    ## file.
    ##
    ## Args:
    ##  'outcome' : Outcome name.
    ##
    ## Returns:
    ##  An index of the column based on the outcome specified. 
    if(outcome == "heart attack") {
        data_col <- 11    # heart attacks column
    } else if(outcome == "heart failure") {
        data_col <- 17    # heart failure column
    } else if(outcome == "pneumonia") {
        data_col <- 23    # pneumonia column
    } else {
        data_col <- 0     # invalid outcome; cannot occur if invoked from the best() function
    }
    data_col
}