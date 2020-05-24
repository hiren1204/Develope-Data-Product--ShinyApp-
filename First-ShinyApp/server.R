#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    #taking input for slider value and send it to "slider2_text" to print
    output$slider2_text <- renderText(input$slider2)
    
    output$manual_plot <- renderPlot({
        
        #taking input for numeric value 
        numeric_input <- input$numeric_value
        
        minX <- input$sliderX[1]
        maxX <- input$sliderX[2]
        
        minY <- input$sliderY[1]
        maxY <- input$sliderY[2]

        dataX <- runif(numeric_input, minX, maxX )
        dataY <- runif(numeric_input, minY, maxY )
                       
        main <- ifelse(input$show_title , "Title" , "")
        
        plot(dataX, dataY , 
             main = main ,
             xlim = c(-100,100), ylim =  c(-100,100))
        
    })
    
    
    
    #selected values which are greter than 20 
    mtcars$mpgsp <- ifelse(mtcars$mpg -20 > 0 , mtcars$mpg -20 , 0)
    
    model1 <- lm(hp ~ mpg , data = mtcars)
    
    #in this model, there is a break point at 20
    model2 <- lm(hp ~ mpgsp + mpg , data = mtcars)
    
    #prediction for model1 
    modelPred1 <- reactive({
        
        #we have to take value of MPG to predict HP
        mpgInput <- input$sliderMPG
        predict(model1 , newdata = data.frame(mpg = mpgInput))
        
    })
    
    #prediction for model2
     modelPred2 <- reactive({
         
         #we have to take value of MPG to predict HP
         mpgInput <- input$sliderMPG
         predict(model2 , newdata = data.frame(mpg = mpgInput,
                                               mpgsp = ifelse(mpgInput - 20 > 0 , 
                                                             mpgInput - 20 , 
                                                             0)))
         
     })
    
    #plotting a plot
    output$car_data_plot_with_model1 <- renderPlot({
        
        mpgInput <- input$sliderMPG
        
        #plot mpg vs hp
        plot(mtcars$mpg , mtcars$hp , 
             xlab = "Miles Per Gallon " , ylab = "HorsePower",
             xlim = c(10,35) , ylim = c(50,350),
             bty = "n", pch = 16)
        
        #if checkbox for model1 is selected then show
        if(input$showModel1){
            abline(model1 , col = "red" , lwd = 2)
        }
        
        #if checkbox for model2 is selected then show
         if(input$showModel2){
             
             model2lines <- predict(model2 , 
                                    newdata = data.frame(mpg = 10:35
                                                         ,mpgsp = ifelse(10:35 -20 > 0 , 
                                                                         10:35 -20 , 
                                                                       0)) )
             lines(10:35 , model2lines , col = "blue" , lwd = 2)
         }
         
         legend(25,250 , c("model1 prediction" , "model2 prediction ") , col = c("red" , "blue") , 
                bty = "n", pch = 16 , cex = 1.2)
        
        points(mpgInput , modelPred1() , col = "red" ,pch=16 , cex = 2) 
        points(mpgInput , modelPred2() , col = "blue" ,pch=16 , cex = 2) 
    })
    
     output$pred1 <- renderText({
         modelPred1()
     })
     
     output$pred2 <- renderText({
         modelPred2()
     })
  
    
    
})
