plot_forecast = function(forecast, variable, data, fit_end_date = max(data$date)) {
  (forecast
   %>% filter(var == variable)
   %>% ggplot(aes(x = date))
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

# Variant fraction
var.frac <- function(dates){
   # 35-40% samples were BA.2 on April 1.
   # Assumes a 7 day lag.
   # This paramterization gives 40% on March 25.
   # Assumes 11% selective advantage - BC modelling group slides
   # https://bccovid-19group.ca/post/2022-04-06-report/COVID19group-2022-04-06.pdf
   # April 6, 2022
   # https://www.cbc.ca/news/canada/newfoundland-labrador/covid-19-april1-1.6405170
   t0="2022-02-16"
   i = which(dates==t0)
   L = length(dates)
   p = rep(0,length(dates))
   p0 = 0.01
   s = 0.11
   t = seq(1,length(seq(i:L)))
   p[i:L] = exp(s*t)*p0/(1-p0+exp(s*t)*p0)
   var.frac = data.frame(dates=dates, var.frac = p)
   return(var.frac)
} 



