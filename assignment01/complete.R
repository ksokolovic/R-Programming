complete <- function(directory, id = 1:332) {
    ## A function reads a directory full of files and reports
    ## the number of completely observed cases in each data file.
    ##
    ## Args:
    ##  'directory' : a character vector of length 1 indicating
    ##                the location of the CSV files
    ##  'id' : an integer vector indicating the monitor ID numbers
    ##         to be used
    ##
    ## Returns:
    ##  A data frame where the first column is the id of the file 
    ##  and the second column is the number of complete cases. 
    
    # Get a list of CSV files to process
    files_list <- list.files(directory, full.names = TRUE)
    
    # Initialize the resulting frame to all zeros
    result <- data.frame(id, nobs = 0)
    
    # Iterate over each file and filter the missing values
    for(i in id) {
        data <- read.csv(files_list[i])
        # Extract only the complete cases
        complete_cases <- data[complete.cases(data),]
        # Count the number of the above
        nobs <- nrow(complete_cases)
        
        # Put the results in the resulting frame
        result$nobs[result$id == i] <- nobs
    }
    
    # Return the result
    result
}