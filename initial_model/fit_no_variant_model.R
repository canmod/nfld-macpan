library(tidyr)
library(dplyr)
library(McMasterPandemic)
library(ggplot2)
setwd("/Users/ahurford/Desktop/Work/Research/Research_Projects/2022/nfld-macpan")
devtools::source_gist("98cc4db25867bd18cc42b6568b4c6848", sha1 = "3cc333562e")
source('get_data.R')
source('functions.R')


# Comments by Dr. Fitzgerald on April 14, and Minister Haggie on April 8, were
# that we may have reach a peak.
# https://vocm.com/2022/04/05/haggie-covid-wave-peak/
# https://www.cbc.ca/news/canada/newfoundland-labrador/covid-nl-april-13-2022-1.6418087
# This calls into question the validity of reported case data so I have not used it for fitting.

observed_data = (NLdatahub
  # convert names to those used by the macpan model
  %>% rename(
    death = new.death,
    H = in.hospital,
  )
  %>% pivot_longer(-date, names_to = "var")
)

params = read_params("PHAC.csv")
params["N"] = 522453  # nfld population
params = fix_pars(params)

end_date = max(observed_data$date)
#Changing from 90 to 15 improves fit substantially
start_date_offset = 15
start_date = min(observed_data$date) - start_date_offset

params_timevar = data.frame(
  Date = c("2022-01-04", "2022-02-17"), # dates of breakpoints
  Symbol = "beta0",                     # parameters to vary
  Value = c(NA,NA),                    # NA means calibrate to data
  Type = "abs"                          # abs = change to value in Value col
)

opt_pars = list(
  params = c(
    log_beta0 = log(params[["beta0"]]),    # transmission rate on log scale
    logit_mu = qlogis(params[['mu']]),     # fraction of cases that are mild on logit scale
    logit_phi1 = qlogis(params[['phi1']]),     # hospitalization rate (kind of) on logit scale #phi1
    logit_nonhosp_mort = qlogis(1e-3),  # hospitalization rate (kind of) on logit scale
    logit_delta = qlogis(1e-3)
  ),
  log_time_params = rep(log(params[["beta0"]]), nrow(params_timevar))
)

model = make_base_model(
  params = params,
  start_date = start_date,
  end_date = end_date,
  params_timevar = params_timevar,
  do_hazard = TRUE,
  do_make_state = TRUE
)

fit = calibrate(
  start_date = start_date,
  start_date_offset = start_date_offset,
  end_date = end_date,
  time_args = list(params_timevar = params_timevar),
  base_params = params,
  data = observed_data,
  opt_pars = opt_pars,
  sim_args = list(flexmodel = model),
  debug = TRUE
)

fitted_data = forecast_ensemble(fit, nsim = 200)

# This is so that that case data can be used for plotting, just not fitting
observed_data2 = (NLdatahub
                 # convert names to those used by the macpan model
                 %>% rename(
                   death = new.death,
                   H = in.hospital,
                   report = cases
                 )
                 %>% pivot_longer(-date, names_to = "var")
)

saveRDS(observed_data, "initial_model/initial_model_files/observed_data.rds")
saveRDS(observed_data2, "initial_model/initial_model_files/observed_data2.rds")
saveRDS(fit, "initial_model/initial_model_files/fit.rds")
saveRDS(fitted_data, "initial_model/initial_model_files/fitted_data.rds")
