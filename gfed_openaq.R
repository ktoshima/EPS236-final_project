## ACF analysis on the GFED and OpenAQ dataset
setwd("~/projects/EPS236-final_project/")
df_gfed = read.csv('./gfed_fire_term/-112.5--110.0_42.5-40.0_248-272.csv')
df_aq = read.csv('./openAQ_term_pm25/-112.5--110.0_42.5-40.0_248-272.csv')

file_lst = list.files('./gfed_fire_term/')

for (filename in file_lst) {
  df_gfed = read.csv(file.path('gfed_fire_term', filename))
  df_aq = read.csv(file.path('openAQ_term_pm25', filename))
  ozone = df_aq$value
  emission = df_gfed$emission[1:length(ozone)]
  png(paste("pm25", filename, ".png", sep = ""), width = 300, height = 300)
  ccf(emission, ozone, lag.max=30, plot=TRUE, main="ozone & emission", na.action=na.pass)
  dev.off()                
}

df_aq_denver = read.csv('denver_o3.csv')
ozone = df_aq_denver$value

file_lst = list.files('./gfed_august/')

for (filename in file_lst) {
  df_gfed = read.csv(file.path('gfed_august', filename))
  emission = df_gfed$emission
  if (all(emission == 0)) {
    next
  } else {
    png(paste("ccf-pm25", filename, ".png", sep = ""), width = 300, height = 300)
    ccf(emission, ozone, lag.max=30, plot=TRUE, main="ozone & emission", na.action=na.pass)
    dev.off()
  }
}


