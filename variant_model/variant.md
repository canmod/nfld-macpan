---
title: "Modelling COVID-19 in Newfoundland and Labrador"
author: "Amy Hurford and Steve Walker"
date: "18/04/2022"
output: 
  html_document: 
    keep_md: yes
---



\

<div class="figure">
<img src="/Users/ahurford/Desktop/Work/Research/Research_Projects/2022/nfld-macpan/variant_model/variant_model_files/flowchart1.png" alt="**_Diagram by Irena Papst_**" width="60%" />
<p class="caption">**_Diagram by Irena Papst_**</p>
</div>

\

Our modelling approach is to fit a [compartmental epidemic model](https://mcmasterpandemic.shinyapps.io/mcmasterpandemicshiny/) to Newfoundland and Labrador COVID-19 data. This approach is used to model COVID-19 in [Ontario](https://mac-theobio.github.io/forecasts/outputs/McMasterOntarioForecastsBlog2022-01-26), however, there are differences in the model formulation for Newfoundland and Labrador.

This modelling approach is mechanistic, or process-based. Process-based modelling contrasts with pattern-based, or phenomenological modelling, which aims to capture the shape of the data and has parameters that do not readily have epidemiological interpretations.

To understand what is mean by a _process-based_ model, consider some of the model parameters that are fixed, and independent of the Newfoundland and Labrador COVID-19 data. Such parameters may describe epidemiological characteristics that aren't different in different regions, i.e. the recovery rate, or are estimated using other data, i.e., the population size of Newfoundland and Labrador.



\

**<u>Selected fixed parameter values</u>**

- Population size: **522453**

- Relative asymptomatic transmission (or contact): **0.67**

- % of cases asymptomatic: **39%**

- Time in exposed class: **3.3 days**

- Time in pre-symptomatic class: **1.2 days**

- Time for asymptomatic recovery: **7 days**

- Time for severely symptomatic transition to hospital/death: **5.72 days**

- Time in hospital (acute care): **10 days**

- Time in ICU to death: **8 days**

- % of ICU cases dying: **26%**


Aside from the population size of Newfoundland and Labrador, the fixed parameter values are the `PHAC.csv` defaults for the `McMasterPandemic` software package.

Fitted parameters are values that are calibrated to match the Newfoundland and Labrador COVID-19 data.

\

**<u>Fitted parameter values</u>**

- % of symptomatic cases that are mild: **99.7%**

- % of hospitalized cases to acute care: **4.6%**

- % population dying without hospitalization: **2.1**

- The infection transmission rate is fitted and full details are provided [here](https://rpubs.com/ahurford/891932).

\

The software we used can be downloaded [here](https://github.com/mac-theobio/McMasterPandemic).

















