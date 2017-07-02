newPlot <- function(x,y,modf,p_new,tag=0, title_tex){
  x_new = append(x, p_new[1])
  y_new = append(y, p_new[2])
  mod_new = lm(y_new~x_new)
  modf_new = fortify(mod_new)
  max_cook_new = order(modf_new$.cooksd,decreasing = T)[1:3]
  
  if(tag){
    plot(x,y, xlim = c(-1, 16), ylim = c(-5, 50)) # original data
    title(title_tex)
    lines(x, modf$.fitted, col="blue", lwd = 3, lty=2) # original reg line
    lines(x_new, modf_new$.fitted, col="red", lwd = 1.3)  # new reg line
    points(mean(x_new), mean(y_new), pch=17, cex=1.5) # average
    points(p_new[1],p_new[2], pch = 19, cex = 1.5, col="green") # new point
    text(p_new[1], # add text on top 3 cooks' dist
         p_new[2],
         "21", cex=1, pos=4, col="red") 
    
    points(modf_new[max_cook_new,'x_new'], # top 3 cooks' dist
           modf_new[max_cook_new,'y_new'],
           pch = 19, col = "red")
    text(modf_new[max_cook_new,'x_new'], # add text on top 3 cooks' dist
         modf_new[max_cook_new,'y_new'],
         max_cook_new, pos=4, col="red") 
  }
  else{
    plot(mod_new, which=5)
    points(modf_new[max_cook_new,'.hat'],
           modf_new[max_cook_new,'.stdresid'],
           cex = 1, pch = 19, col = "red")
    points(modf_new[21,".hat"],
           modf_new[21,".stdresid"],
           cex = 1.5, pch = 19, col = "green")
    text(modf_new[21,".hat"],
         modf_new[21,".stdresid"],
         "21", pos=1)
    text(modf_new[21,".hat"],
         modf_new[21,".stdresid"],
         title_tex, pos=3)
  }
}