## ACF analysis on the GFED and OpenAQ dataset
setwd("~/projects/EPS236-final_project/")
library(boot)

# GFED vs PM2.5

file_lst = list.files('./openAQ_term_pm25/')

acf_lag_pm25 = rep(NA, length(file_lst))
i = 1
for (filename in file_lst) {
  df_gfed = read.csv(file.path('gfed_fire_term', filename))
  df_aq = read.csv(file.path('openAQ_term_pm25', filename))
  ozone = df_aq$value
  emission = df_gfed$emission[1:length(ozone)]
  png(paste("gfed-pm25/", filename, ".png", sep = ""), width = 300, height = 300)
  ccf_values = ccf(emission, ozone, lag.max=30, plot=TRUE, main="PM2.5 & emission", na.action=na.pass)
  dev.off()            
  acf_lag[i] = ccf_values$lag[which.max(abs(ccf_values$acf))]
  i = i+1
}
# bootstrap on the lag of largest ACF 
boot(acf_lag, statistic=function(x,i) mean(x[i]), length(acf_lag))

# GFED vs Ozone

file_lst = list.files('./openAQ_term_ozone/')

acf_lag_ozone = rep(NA, length(file_lst))
i = 1
for (filename in file_lst) {
  df_gfed = read.csv(file.path('gfed_fire_term', filename))
  df_aq = read.csv(file.path('openAQ_term_ozone', filename))
  ozone = df_aq$value
  emission = df_gfed$emission[1:length(ozone)]
  png(paste("gfed-ozone/", filename, ".png", sep = ""), width = 300, height = 300)
  ccf_values = ccf(emission, ozone, lag.max=30, plot=TRUE, main="ozone & emission", na.action=na.pass)
  dev.off()                
  acf_lag[i] = ccf_values$lag[which.max(abs(ccf_values$acf))]
  i = i+1
}
# bootstrap on the lag of largest ACF
boot(acf_lag, statistic=function(x,i) mean(x[i]), length(acf_lag))

# GFED vs Denver-Aurora Ozone

df_aq_denver = read.csv('denver_o3.csv')
ozone = df_aq_denver$value

file_lst = list.files('./gfed_august/')
acf_lag_denver = rep(NA, length(file_lst))
i = 1
for (filename in file_lst) {
  df_gfed = read.csv(file.path('gfed_august', filename))
  emission = df_gfed$emission
  if (all(emission == 0)) {
    next
  } else {
    png(paste("gfed-ozone-denver/", filename, ".png", sep = ""), width = 300, height = 300)
    ccf_values = ccf(emission, ozone, lag.max=30, plot=TRUE, main="ozone & emission", na.action=na.pass)
    dev.off()
  }
}


