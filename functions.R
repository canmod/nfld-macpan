plot_forecast = function(forecast, variable, data, fit_end_date = max(data$date)) {
  (forecast
   %>% filter(var == variable)
   %>% ggplot(aes(x = date))
   + geom_vline(aes(xintercept = fit_end_date),
                colour = "grey60", linetype = "dashed")
   + geom_ribbon(aes(ymin = lwr,
                     ymax = upr),fill="dodgerblue",
                 alpha = 0.3)
   + geom_line(aes(y = value),col="dodgerblue")
   + geom_point(data = filter(data, var == variable),
                aes(x = date, y = value),
                fill = "white", pch=21)
   + labs(y = variable)
   +  scale_x_date(date_breaks = "7 day", date_labels = "%d %b")+
      theme(axis.text.x = element_text(angle = 90),legend.position = "none")
   + theme(axis.title.x = element_blank())
  )
}

