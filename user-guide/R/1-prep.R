# load libraries ----
# load the functions I need to process the data
library(stevedata) # has the raw data

# "load" the data ----
# Note: in your case, you can load raw data from wherever, even outside the project directory
# For example, if you're analyzing ANES data, you're not ask to stick it in your project directory
# If you can share the raw data, create a directory called "data-raw" in the main project directory
# Then, load it from there.
data(ESS9GB, package="stevedata")

# "prep" the data ----
# I can do anything I want here. I can recode things, transform variables, or whatever
# Here, let's just create a stupid noise variable

Data <- ESS9GB

set.seed(8675309)
Data$noise <- rnorm(nrow(Data))

# in {tidyverse}
# set.seed(8675309)
# ESS9GB %>%
#   mutate(noise = rnorm(nrow(.))) -> Data

# ^ Notice that I "finished" my data prep into a new object, titled "Data"
# Now: I save it to data/Data.rds
saveRDS(Data, "user-guide/data/Data.rds")
