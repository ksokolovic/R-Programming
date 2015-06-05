# R Programming 
* * *

This repository contains the solutions to assignments given in the Coursera **R Programming** course. This course is
just a part of the **Data Science Specialization**. 

# Running the assignments
* * *

Before trying to test the code, you first need to install [R](http://www.r-project.org/) on your system. 

To clone the repository containing the source, type in the following:

```sh
$ git clone https://sokolovic@bitbucket.org/sokolovic/r-programming.git
```

After cloning the repository, you can load the functions into your current R workspace using ```source(path/to/source.R)```
and invoke them.

## Assignment 01

To run the functions from *Assignment 01* I recommend you first set the working directory to the root of the cloned
repository. 

```sh
> setwd("r-programming")	# We first set the working directory to the root of the cloned repository
```

```sh
> source("assignment01/pollutantmean.R")	# Load the function so it can be used
>
> pollutantmean("assignment01/specdata", "sulfate", 1:10)
[1] 4.064
>
> pollutantmean("specdata", "nitrate", 70:72)
[1] 1.706
>
> pollutantmean("specdata", "nitrate", 23)
[1] 1.281
``` 

```sh
> source("assignment01/complete.R")		# Load the function so it can be used
>
> complete("specdata", 1)
  id nobs
1  1  117
>
> complete("specdata", c(2, 4, 8, 10, 12))
  id nobs
1  2 1041
2  4  474
3  8  192
4 10  148
5 12   96
>
> complete("specdata", 30:25)
  id nobs
1 30  932
2 29  711
3 28  475
4 27  338
5 26  586
6 25  463
>
> complete("specdata", 3)
  id nobs
1  3  243
```

```sh
> source("assignment01/corr.R")			# Load the function so it can be used
> source("assignment01/complete.R")             # Load the complete() function since it's used in the corr()
> 
> cr <- corr("specdata", 150)
> head(cr)
[1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
> summary(cr)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
-0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630
>
> cr <- corr("specdata", 5000)
> summary(cr)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
> length(cr)
[1] 0
>
> cr <- corr("specdata")
> summary(cr)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
-1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000
> length(cr)
[1] 323
```

## Assignment 03

To run the functions from *Assignment 03* I recommend you first set the working directory to the root of the 
cloned repository.

```sh
> setwd("r-programming")	# We first set the working directory to the root of the cloned repository
```

```sh
> source("assignment03/best.R")		# Load the function so it can be used
>
> best("TX", "heart attack")
[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
>
> best("TX", "heart failure")
[1] "FORT DUNCAN MEDICAL CENTER"
>
> best("MD", "pneumonia")
[1] "GREATER BALTIMORE MEDICAL CENTER"
>
> best("MD", "heart attack")
[1] "JOHNS HOPKINS HOSPITAL, THE"
>
> best("BB", "heart attack")
Error in best("BB", "heart attack") : invalid state
>
> best("NY", "hert attack")
Error in best("NY", "hert attack") : invalid outcome
```

```sh
> source("assignment03/rankhospital.R")		# Load the function so it can be used
> source("assignment03/best.R")			# Load the best() function since it's used in the rankhospital()
>
> rankhospital("TX", "heart failure", 4)
[1] "DETAR HOSPITAL NAVARRO"
>
> rankhospital("MD", "heart attack", "worst")
[1] "HARFORD MEMORIAL HOSPITAL"
>
> rankhospital("MN", "heart attack", 5000)
[1] NA
```

# Copyright
* * *

> *Copyright (c) 2015 Kemal Sokolović <kemal DOT sokolovic AT gmail DOT com>*
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of
> this software and associated documentation files (the "Software"), to deal in the
> Software without restriction, including without limitation the rights to use,
> copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
> Software, and to permit persons to whom the Software is furnished to do so,
> subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
> IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
> DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN THE SOFTWARE.
