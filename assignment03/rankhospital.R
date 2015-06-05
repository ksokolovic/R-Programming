rankhospital <- function(state, outcome, num = "best") {
    ## A function reads the outcome-of-care-measures.csv file and returns
    ## a character vector with the name of the hospital that has the 
    ## ranking specified by the 'num' argument. 
    ##
    ## Args:
    ##  'state' : The 2-character abbreviated name of a state.
    ##  'outcome' : Outcome name.
    ##  'num' : The ranking of a hospital in that state.
    ##
    ## Returns:
    ##  A character vector with the name of the hospital that has the
    ##  ranking specified by the 'num' argument. 
    
    # If the num == "best" then we just invoke the best() function
    hospital <- best(state, outcome)
    
    # Read the outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # Check that state and outcome are valid
    if(!(state %in% data$State)) {
        stop("invalid state")
    }
    if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
        stop("invalid outcome")
    }
    
    # Handle only the data of the specified state
    data <- data[data$State == state, ]
    
    # Get the index of the column containing the data of interest, based 
    # on the outcome specified
    data_col <- colOfInterest(outcome)
    # Switch from character to numeric data type a column of interest
    data[, data_col] <- as.numeric(data[, data_col])
    
    # First remove the rows that contain the missing values in the given column
    data <- data[!is.na(data[, data_col]), ]
    # Sort the data, first by the rate and then alphabetically by hospital name
    # so the correct order is achieved if two hospitals have the same rate
    data <- data[order(data[, data_col], data[, 2]), ]
    
    # If the num == "worst" than the last one is returned
    if(num == "worst") {
        hospital <- data[dim(data)[1], 2]
    }
    # If the 'num' argument is larger than the number of hospitals, NA is returned
    else if(num > dim(data)[1]) {
        hospital <- NA
    }
    # Otherwise the order of the list is respected
    else {
        hospital <- data[num, 2]
    }
    
    # Return the result
    return(hospital)
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
    ##  An index of the column based on the outcome specified
    if(outcome == "heart attack") {
        data_col <- 11     # heart attacks column
    } else if(outcome == "heart failure") {
        data_col <- 17     # heart failure column
    } else if(outcome == "pneumonia") {
        data_col <- 23     # pneumonia column
    } else {
        data_col <- 0      # invalid outcome; cannot occur if invoked from the rankhospital() function
    }
    data_col
}