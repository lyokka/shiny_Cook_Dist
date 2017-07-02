library(shiny)
source("newPlot.R")
shinyServer(function(input, output) {
  set.seed(123)
  x = seq(0, 10, length.out = 20)
  y = 3*x + 2 + + rnorm(20, 0, 3)
  
  mod <- lm(y ~ x)
  modf <- fortify(mod)
  
  max_cook = order(modf$.cooksd,decreasing = T)[1:3]
  
  output$plot1 <- renderPlot({
    plot(x,y, xlim = c(-1, 16), ylim = c(-5, 50))
    lines(x, modf$.fitted, col="blue", lwd = 1.3)
    points(mean(x), mean(y), pch=17, cex=1.5)
    points(modf[max_cook,'x'], modf[max_cook,'y'], pch = 19, col = "red")
    text(modf[max_cook,'x'], modf[max_cook,'y'], max_cook, cex=1, pos=4, col="red") 
  })
  
  output$plot2 <- renderPlot({
    plot(mod, which=5) + points(modf[max_cook,'.hat'], modf[max_cook,'.stdresid'], cex = 1, pch = 19, col = "red")
    text(modf$.hat, modf$.stdresid, c(1:length(x)), cex=1, pos=4, col="red") 
  })
  
  output$plot3 <- renderPlot({
    newPlot(x,y,modf,c(15, 45),tag = 1, 'regression line')
  })
  
  output$plot4 <- renderPlot({
    newPlot(x,y,modf,c(15,45), tag = 0, "low residual high leverage")
  })
  
  output$plot5 <- renderPlot({
    newPlot(x,y,modf,c(5, 25),tag = 1, 'regression line')
  })
  
  output$plot6 <- renderPlot({
    newPlot(x,y,modf,c(5,25), tag = 0, "high residual low leverage")
  })
  
  output$plot7 <- renderPlot({
    newPlot(x,y,modf,c(0, 45),tag = 1, 'regression line')
  })
  
  output$plot8 <- renderPlot({
    newPlot(x,y,modf,c(0,45), tag = 0, "high residual high leverage")
  })
  
  #output$dis <- renderDataTable({})
})