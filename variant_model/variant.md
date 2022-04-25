---
title: "Modelling COVID-19 in Newfoundland and Labrador"
subtitle: Short-term forecasting
author: "Amy Hurford and Steve Walker"
date: "18/04/2022"
output: 
  html_document: 
    keep_md: yes
---



This fits a [compartmental epidemic model](https://mcmasterpandemic.shinyapps.io/mcmasterpandemicshiny/) to Newfoundland and Labrador COVID-19 data. This approach is used to model COVID-19 in [Ontario](https://mac-theobio.github.io/forecasts/outputs/McMasterOntarioForecastsBlog2022-01-26), however, there are differences in the model formulation for Newfoundland and Labrador.

The model is mechanistic, or process-based. This contrasts with pattern-based models, which aim to capture the shape of the data and have parameters that do not readily have epidemiological interpretations. The parameters in the process-based model are:




Relative asymptomatic transmission (or contact) 0.6666667

Relative presymptomatic transmission (or contact) 1

relative mildly symptomatic transmission (or contact) 1

relative severely symptomatic transmission (or contact) 1

Fraction of cases asymptomatic 0.39

Time in exposed class 3.3 days

Time for asymptomatic recovery 7 days

Time for mildly symptomatic recovery 7 days

Time for severely symptomatic transition to hospital/death 5.72 days

Time in pre-symptomatic class 1.2 days

Time in hospital (acute care) 10 days

Population size 5.22453\times 10^{5}

Fraction of ICU cases dying 0.26

Time in ICU to back to acute care 20

Time in ICU to death 8

Time post-ICU to discharge 5

Fraction of incidence reported as positive tests 0.1

Average delay between incidence and test report 11

Coefficient of variation of testing delay 0.25


The software we used can be downloaded [here](https://github.com/mac-theobio/McMasterPandemic).

For an explanation of the assumptions around changes in the transmission rate owing to public health measures, see [here](https://rpubs.com/ahurford/891932).

Further details will be added soon.

















