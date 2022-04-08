plot_forecast = function(forecast, variable, data, fit_end_date = max(data$date)) {
  (forecast
   %>% filter(var == variable)
   %>% ggplot(aes(x = date))
   + geom_vline(aes(xintercept = fit_end_date),
                colour = "grey60", linetype = "dashed")
   + geom_ribbon(aes(ymin = lwr,
                     ymax = upr),
                 alpha = 0.3)
   + geom_line(aes(y = value))
   + geom_point(data = filter(data, var == variable),
                aes(x = date, y = value),
                shape = 1)
   + labs(y = variable)
   + theme(axis.title.x = element_blank())
  )
}
