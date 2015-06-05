corr <- function(directory, threshold = 0) {
    ## A function calculates the correlation between sulfate
    ## and nitrate for monitor locations where the number of
    ## completely observed cases (on all variables) is greater
    ## than the threshold.
    ##
    ## Args:
    ##  'directory' : a character vector of length 1 indicating
    ##                the location of the CSV files
    ##  'threshold' : a numeric vector of length 1 indicating the
    ##                number of completely observed observations
    ##                (on all variables) required to compute the 
    ##                correlation between nitrate and sulfate; 
    ##                the default is 0.
    ## 
    ## Returns:
    ##  A vector of correlations for the monitors that meet the
    ##  threshold requirement. If no monitors meet the threshold
    ##  requirement, then the function should return a numeric 
    ##  vector of length 0.
    
    # Get a list of CSV files to process
    files_list <- list.files(directory, full.names = TRUE)
    # Use the complete() function to get the number of complete cases
    # in the given monitor files; the function returns a data frame
    # holding the 'id' of the monitor as well as the number of complete
    # cases 'nobs'
    complete <- complete(directory)
    # Extract only IDs of the cases that meet the threashold requirement
    ids <- complete[complete$nobs > threshold,]$id
    # Initialize an empty result vector
    result <- numeric()
    
    # Process only the data that meets the requirement
    for(i in ids) {
        data <- read.csv(files_list[i])
        complete_cases <- data[complete.cases(data),]
        
        result <- c(result, cor(complete_cases[["sulfate"]], complete_cases[["nitrate"]]))
    }
    
    # Return result
    result
}