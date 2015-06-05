pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## A function calculates the mean of a pollutant (sulfate or
    ## nitrate) across a specified list of monitors. 
    ##
    ## Args:
    ##  'directory' : a character vector of length 1 indicating
    ##                the location of the CSV files
    ##  'pollutant' : a character vector of length 1 indicating
    ##                the name of the pollutant for which we will 
    ##                calculate the mean
    ##  'id' : an integer vector indicating the monitor ID numbers
    ##         to be used
    ##
    ## Returns:
    ##  The mean of the pollutant across all monitors list
    ##  in the 'id' vector (ignoring NA values)
    
    # Get a list of CSV files to process
    files_list <- list.files(directory, full.names = TRUE)
    
    # Initialize empty data frame
    data <- data.frame()

    # Iterate over each of the specified monitor results and merge them into
    # one frame
    for(i in id) {
        temp_data <- read.csv(files_list[i])
        data <- rbind(data, temp_data)
    }
    
    # Extract the column for which the mean is being calculated
    values <- data[[pollutant]]
    # Calculate the mean of the given column, ignoring the missing values
    result <- mean(values, na.rm=TRUE)
    
    # Return the result
    result
}