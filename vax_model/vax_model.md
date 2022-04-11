---
title: "Vax Model"
author: "Steve Walker and Amy Hurford"
date: "11/04/2022"
output: 
  html_document: 
    keep_md: yes
---






```r
plot_forecast(fitted_data, "report", observed_data) +
  ylab("Deaths")+ scale_x_date(date_breaks = "7 day", date_labels = "%d %b")+
  theme(axis.text.x = element_text(angle = 90),legend.position = "none")
```

```
## Warning: Removed 15 row(s) containing missing values (geom_path).
```

![](vax_model_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```r
plot_forecast(fitted_data, "H", observed_data) +
  ylab("Deaths")+ scale_x_date(date_breaks = "7 day", date_labels = "%d %b")+
  theme(axis.text.x = element_text(angle = 90),legend.position = "none")
```

```
## Warning: Removed 16 rows containing missing values (geom_point).
```

![](vax_model_files/figure-html/unnamed-chunk-1-2.png)<!-- -->

```r
plot_forecast(fitted_data, "death", observed_data) +
  ylab("Deaths")+ scale_x_date(date_breaks = "7 day", date_labels = "%d %b")+
  theme(axis.text.x = element_text(angle = 90),legend.position = "none")
```

```
## Warning: Removed 1 row(s) containing missing values (geom_path).
```

![](vax_model_files/figure-html/unnamed-chunk-1-3.png)<!-- -->
