---
title: "Variant Model"
author: "Amy Hurford"
date: "13/04/2022"
output: 
  html_document: 
    keep_md: yes
---









```r
cases = filter(observed_data2,var=="report")
fitted_cases = data.frame(date=scenario$date,value=scenario$report)
p = var.frac(fitted_cases$date)$var.frac
output = data.frame(date = fitted_cases$date, cases=fitted_cases$value, BA.2 = p*fitted_cases$value)

g.var = ggplot()+
  geom_line(data=cases,aes(x= as.Date(date),y=value), col = "blue", lwd=0.2)+
  geom_line(data=scenario, aes(x=as.Date(date), y=report), col = "red")+
  geom_point(data=cases,aes(x= as.Date(date),y=value), col = "blue", pch=21, fill = "white")+
geom_ribbon(data= output, aes(x= as.Date(date), ymax = cases,ymin=0),fill = "darkblue", alpha = 0.3)+
geom_ribbon(data= output, aes(x= as.Date(date), ymax = BA.2,ymin=0),fill = "blue", alpha = 0.3)+
  annotate("text", x = as.Date("2022-03-08"), y = 200, label = "BA.1", col = "blue")+
    annotate("text", x = as.Date("2022-03-28"), y = 100, label = "BA.2", col="darkblue")+
  ylab("Reported new cases")+ scale_x_date(date_breaks = "7 day", date_labels = "%d %b", limits = c(as.Date("2021-12-01"), tail(as.Date(end_date),1)))+
  theme(axis.text.x = element_text(angle = 90),legend.position = "none")+xlab("")
```

