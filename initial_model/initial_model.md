Optimize the following parameters at the following starting values.

    fit$forecast_args$opt_pars$params

    ##  log_beta0   logit_mu logit_phi1 
    ## -0.2873509  3.0785683  1.1526795

Prefixing by `log_` or `logit_` means we are optimizing on these scales.

These parameters have the following meanings (TODO: the description for
phi1 looks wrong).

    ##   symbol value                                                    meaning
    ## 1  beta0  0.75 Baseline (non-intervention) transmission across categories
    ## 2     mu 0.956                Fraction of symptomatic cases that are mild
    ## 3   phi1  0.76                          Fraction of hospital cases to ICU

Use the following time-variation schedule for these parameters.

    fit$forecast_args$time_args$params_timevar

    ##         Date Symbol Value Type
    ## 1 2022-01-04  beta0    NA  abs
    ## 2 2022-02-14  beta0    NA  abs

Here are the fitted coefficients on their original scales.

    coef(fit, 'fitted')

    ## $params
    ##        beta0           mu         phi1 
    ## 0.6227890334 0.9976471311 0.0009304334 
    ## 
    ## $time_params
    ## [1] 0.2135656 0.7366372
    ## 
    ## $nb_disp
    ##        death            H       report 
    ##    0.7988247 1354.5634680    2.7117786

The `time_params` in this particular case refer to changing transmission
rate. The first change in transmission rate is lower than the baseline,
consistent with restrictions being implemented on the associated date.
The second change is higher, which seems to be consistent with lifting
restrictions on that date.

The fits to case reports fits better to the second peak than the first.

    plot_forecast(fitted_data, "report", observed_data)

    ## Warning: Removed 15 row(s) containing missing values (geom_path).

![](initial_model_files/figure-markdown_strict/unnamed-chunk-5-1.png)

The fits to hospital occupancy.

    plot_forecast(fitted_data, "H", observed_data)

    ## Warning: Removed 15 rows containing missing values (geom_point).

![](initial_model_files/figure-markdown_strict/unnamed-chunk-6-1.png)

The fits to deaths is pretty bad – not sure why.

    plot_forecast(fitted_data, "death", observed_data)

    ## Warning: Removed 1 row(s) containing missing values (geom_path).

![](initial_model_files/figure-markdown_strict/unnamed-chunk-7-1.png)
