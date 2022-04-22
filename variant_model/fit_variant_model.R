library(tidyr)
library(dplyr)
library(McMasterPandemic)
library(ggplot2)
setwd("/Users/ahurford/Desktop/Work/Research/Research_Projects/2022/nfld-macpan")
devtools::source_gist("98cc4db25867bd18cc42b6568b4c6848", sha1 = "3cc333562e")
source('get_data.R')
source('functions.R')
source('/Users/ahurford/Desktop/Work/Research/Research_Projects/2022/nfld-macpan/initial_model/fit_no_variant_model.R')
fit = readRDS('/Users/ahurford/Desktop/Work/Research/Research_Projects/2022/nfld-macpan/initial_model/initial_model_files/fit.rds')
fitted_data = readRDS('/Users/ahurford/Desktop/Work/Research/Research_Projects/2022/nfld-macpan/initial_model/initial_model_files/fitted_data.rds')

fitted_cases = filter(fitted_data,var=="report")
# The fraction of BA.2 cases
BA.2 = var.frac(fitted_cases$date)
i=which(BA.2$dates ==tail(as.Date(fit$forecast_args$time_args$params_timevar$Date),1))
# Mean BA.2. frequency during fitted after last time break
BA.2.mean = mean(BA.2$var.frac[i:length(BA.2$dates)])
beta.BA.2 = tail(coef(fit, 'fitted')$time_params,1)/BA.2.mean


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

forecast.days = 14
end_date = max(observed_data$date)+forecast.days
start_date_offset = 15
start_date = min(observed_data$date) - start_date_offset

forecast.dates = as.Date(seq(max(observed_data$date)+1,max(observed_data$date)+forecast.days,by="days"))
BA.2 = var.frac(seq(start_date,end_date,by="days"))
i = which(BA.2$dates == forecast.dates[1])
forecast.values = BA.2$var.frac[i:length(BA.2$dates)]*beta.BA.2

params_timevar2 = data.frame(
  Date = c(as.Date(fit$forecast_args$time_args$params_timevar$Date), forecast.dates), # dates of breakpoints
  Symbol = "beta0",                     # parameters to vary
  Value = c(coef(fit, 'fitted')$time_params,forecast.values),                    # NA means calibrate to data
  Type = "abs"                          # abs = change to value in Value col
)

params_timevar = data.frame(
  Date = c(as.Date(fit$forecast_args$time_args$params_timevar$Date)), # dates of breakpoints
  Symbol = "beta0",                     # parameters to vary
  Value = c(NA,NA),                    # NA means calibrate to data
  Type = "abs"                          # abs = change to value in Value col
)

opt_pars = list(
  params = c(
    log_beta0 = log(params[["beta0"]]),    # transmission rate on log scale
    logit_mu = qlogis(params[['mu']]),     # fraction of cases that are mild on logit scale
    logit_phi1 = qlogis(params[['phi1']])  # hospitalization rate (kind of) on logit scale
  ),
  log_time_params = rep(log(params[["beta0"]]), nrow(params_timevar))
)

model = make_base_model(
  params = params,
  start_date = start_date,
  end_date = end_date,
  params_timevar = params_timevar2,
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
saveRDS(fit, "variant_model/variant_model_files/fit_var.rds")
saveRDS(fitted_data, "variant_model/variant_model_files/fitted_data_var.rds")
