# Load data

## Reported new cases (daily), hospital occupancy, and cumulative deaths for before March 14, 2022

data4=read.csv('https://raw.githubusercontent.com/ahurford/covid-nl/master/NL-Hub/Prov_stats.csv', fill=TRUE)

## Reported new cases (daily), hospital occupancy, and cumulative deaths for after March 14, 2022

data6 = read.csv('https://raw.githubusercontent.com/ahurford/covid-nl-2022/master/data.csv', fill=TRUE)

## Number of tests performed (from PHAC)

dat=read.csv('https://raw.githubusercontent.com/ahurford/covid-nl/master/covid19-download.csv', fill=TRUE)
datNL = dat[dat$prname=="Newfoundland and Labrador",]

# Data processing

## Format dates

data4$date_of_update=as.Date(data4$date_of_update)

## Splice datahub data together

date = c(data4$date_of_update, data6$date)

in.hospital = c(data4$currently_hospitalized, data6$hosp.occ)

cases = c(data4$new_provincial_cases, data6$cases)


## Change cumulative deaths to new deaths

new.death = diff(c(0,data4$total_deaths, data6$cum.death))

# Make a dataframe and remove entries before Dec 1

NLdatahub = data.frame(date = date, new.death = new.death, in.hospital = in.hospital, cases = cases)

i = which(date=="2021-12-01")

NLdatahub = tail(NLdatahub,-(i-1))

# Making the dataframe for tests, remove data before Dec 1, and remove instances of 0 cases reported

tests = data.frame(date=datNL$date, tests = datNL$numteststoday)

i = which(tests$date=="2021-12-01")

tests = tail(tests,-(i-1))

tests = tests[tests$tests>0,]


# Running the code above gives you the data in two pieces: NLdatahub and tests.
# For NLdatahub, after March 14 new cases are reported every day, but hospital
# occupancy and deaths are only reported MWF. I fill in hospital occupancy with
# NA and new deaths with 0. You'll notice that tests is not as up-to-date as the
# NLdatahub. Sorry that it isn't elegant tidyverse commands and my coding is
# very messy.

# What variables would you like to forecast?
#
# New cases, hospital occupancy and new deaths - if you can. And is it
# possible to consider the impact of BA.2? (i.e. a scenario where
# transmissibilty doesn't change in the future vs. one where there is a
# transition to the added transmissibility of BA.2)?
#
# Potential break points are as shown in
# Figure 1: https://rpubs.com/ahurford/883365
#
# What is known about BA.2 prevalence is here:
# https://www.cbc.ca/news/canada/newfoundland-labrador/covid-19-april1-1.6405170
# 35-40% as reported on April 1. However, that reported % must be very lagged
# (samples sent to Winnipeg, I expect).
