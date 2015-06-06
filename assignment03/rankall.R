rankall <- function(outcome, num = "best") {
    ## A function reads the outcome-of-care-measures.csv file and
    ## returns a 2-column data frame containing the hospital 
    ## in each state that has the ranking specified in 'num'.
    ## The function returns a value for every state, even if some 
    ## of them are NA (missing values).
    ## The first column in the data frame is named 'hospital', 
    ## which contains the hospital name; the second column is 
    ## named 'state' and it contains the 2-character abbreviation
    ## for the state name. Hospitals that do not have data on a
    ## particular outcome are excluded from the set of hospitals 
    ## when deciding the rankings. 
    ##
    ## Args:
    ##  'outcome' : Outcome name.
    ##  'num' : The ranking of the hospital.
    ##
    ## Returns:
    ##  A 2-column data frame containing the hospital in each
    ##  state that has the ranking specified by the 'num'.
    
    # Read the outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # Initialize the resulting frame
    results <- data.frame(hospital = character(), state = character())
    
    # Check that outcome is valid
    if(!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
        stop("invalid outcome")
    }
    
    # Get the index of the column containing the data of interest, based 
    # on the outcome specified
    data_col <- colOfInterest(outcome)
    # Switch from character to numeric data type a column of interest
    data[, data_col] <- as.numeric(data[, data_col])
    # Remove the rows that contain the missing values in the given column
    data <- data[!is.na(data[, data_col]), ]
    
    # Extract unique state values
    states <- unique(data[, 7])
    # Sort the states alphabetically 
    states <- states[order(states)]
    
    # Iterate over states and obtain the values for each state that will 
    # be appended to the final result
    for(state in states) {
        state_data <- data[data$State == state, ]
        result_part <- rankbystate(state_data, data_col, state, outcome, num)
        
        # Append the partial result to the resulting frame
        results <- rbind(results, result_part)
    }
    
    # Return the results
    results
}

rankbystate <- function(data, data_col, state, outcome, num) {
    ## A function manipulates the given state 'data' and returns
    ## a data frame containing the name of the hospital and abbreviated
    ## state name of the hospital that has the ranking specified by the 
    ## 'num' argument.
    ## 
    ## Args:
    ##  'data' : Data frame with the data of the given state.
    ##  'data_col' : Index of the data column used for ranking.
    ##  'state' : The 2-character abbreviated name of a state.
    ##  'outcome' : Outcome name.
    ##  'num' : The ranking of the hospital in that state.
    ##
    ## Returns:
    ##  A data frame containing the name of the hospital and abbreviated
    ##  state name of the hospital that has the ranking specified by
    ##  the 'num' argument.
    
    # Sort the data, first by rate and then alphabetically by hospital
    # name so the correct order is achieved if two hospitals have the same rate
    data <- data[order(data[, data_col], data[, 2]), ]
    
    # If the num == "best" than the first one is returned
    if(num == "best") {
        hospital <- data[1, 2]
    }
    # If the num == "worst" than the last one is returned
    else if(num == "worst") {
        hospital <- data[dim(data)[1], 2]
    }
    # If the 'num' argument is larger than the number of hospitals, NA
    # is returned
    else if(num > dim(data)[1]) {
        hospital <- NA
    }
    # Otherwise the order of the list is respected
    else {
        hospital <- data[num, 2]
    }
    
    # Return the resulting frame part
    data.frame("hospital" = hospital, "state" = state)
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
        data_col <- 11     # heart attack column
    } else if(outcome == "heart failure") {
        data_col <- 17     # heart failure column
    } else if(outcome == "pneumonia") {
        data_col <- 23     # pneumonia column
    } else {
        data_col <- 0      # invalid outcome; cannot occur if invoked from the rankall() function
    }
    data_col
}
