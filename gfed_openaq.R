## ACF analysis on the GFED and OpenAQ dataset
setwd("~/projects/EPS236-final_project/")
df_gfed = read.csv('./gfed_fire_term/-112.5--110.0_42.5-40.0_248-272.csv')
df_aq = read.csv('./openAQ_term/-112.5--110.0_42.5-40.0_248-272.csv')

file_lst = list.files('./gfed_fire_term/')

for (filename in file_lst) {
  df_gfed = read.csv(file.path('gfed_fire_term', filename))
  df_aq = read.csv(file.path('openAQ_term', filename))
  ozone = df_aq$value
  emission = df_gfed$emission[1:length(ozone)]
  png(paste(filename, ".png", sep = ""), width = 300, height = 300)
  ccf(emission, ozone, lag.max=30, plot=TRUE, main="ozone & emission")
  dev.off()                
}

file.path('gfed_fire_term', lst[1])

ozone = df_aq$value
plot(ozone, type = "l")
emission = df_gfed$emission[1:length(ozone)]
par(new=T)
plot(emission, type = "l")
ccf(emission, ozone, lag.max=30, plot=TRUE, main="ozone & emission")
acf(emission)
acf(ozone)
