library(tidyr)
library(dplyr)
library(McMasterPandemic)
library(ggplot2)
Sys.unsetenv("GITHUB_PAT")
devtools::source_gist("98cc4db25867bd18cc42b6568b4c6848", sha1 = "3cc333562e")
source('get_data.R')
source('functions.R')

observed_data = readRDS('initial_model/observed_data.rds')
fit = readRDS('initial_model/fit.rds')
fitted_data = readRDS('initial_model/fitted_data.rds')

forecast_period = 14 # days

params = coef(fit)
params_timevar = fit$forecast_args$time_args$params_timevar
params_timevar$Value = coef(fit, 'fitted')$time_params
start_date = fit$forecast_args$sim_args$flexmodel$start_date
end_date = fit$forecast_args$sim_args$flexmodel$end_date + forecast_period

model = make_base_model(
  params = params,
  start_date = start_date,
  end_date = end_date,
  params_timevar = params_timevar,
  do_hazard = TRUE,
  do_make_state = TRUE
)

fit$forecast_args$sim_args$flexmodel = model

forecast_data = forecast_ensemble(fit, nsim = 200)
saveRDS(forecast_data, 'initial_model/forecast_data.rds')
saveRDS(forecast_period, 'initial_model/forecast_period.rds')

plot_forecast(forecast_data, "H", observed_data) +
  ylab("Deaths")+ scale_x_date(date_breaks = "7 day", date_labels = "%d %b")+
  theme(axis.text.x = element_text(angle = 90),legend.position = "none")
