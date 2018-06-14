result = tryCatch({
  library('plotly')
}, error = function(e) {
  install.packages('plotly')
  library('plotly')
})

result = tryCatch({
  library('ggplot2')
}, error = function(e) {
  install.packages('ggplot2')
  library('ggplot2')
})


matrix <- function(){
  # generate pairs of x-y values
  nx = 100
  ny = 80
  x = sample(x = 1:nx, size = 90, replace = TRUE)
  y = seq(-1, -ny, length = 90)
  
  # set graphical parameters
  op = par(bg = "black", mar = c(0, 0.2, 0, 0.2))
  
  # plot
  plot(1:nx, seq(-1, -nx), type = "n", xlim = c(1, nx), ylim = c(-ny+10, 1))
  for (i in seq_along(x))
  {
    aux = sample(1:ny, 1)
    points(rep(x[i], aux), y[1:aux], pch = sample(letters, aux, replace = TRUE), 
           col = hsv(0.35, 1, 1, runif(aux, 0.3)), cex = runif(aux, 0.3))
  }
}

exemplo <- function(){
  # Let's use the diamonds data set :
  d <- diamonds[sample(nrow(diamonds), 1000), ]
  
  # Make a basic scatter plot :
  p=plot_ly(d, x = ~carat, y = ~price, type="scatter", text = paste("Clarity: ", d$clarity),
            mode = "markers", color = ~carat, size = ~carat)
  p
}

#Runs:
matrix()
exemplo()
getwd()
setwd("C:/Users/logonrm/Documents")
getwd()
