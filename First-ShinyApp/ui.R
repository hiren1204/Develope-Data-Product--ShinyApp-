#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Learning ShinyApp"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            print("**********part 0 ***************\n\n\n"),
            
            #sliderInput("name","slider title","from 0","to 100","default selected value")
            sliderInput("slider2","Slide and Select the value to show",0,100,0),
            
            #to take input from user (to select the number)
            numericInput(  "numeric_value", label = "How many random number you want to plot ?", 
                          value = 1000,
                          min = 1, max = 1000 ),
            
            br(),
            print("*********part 1 ****************"),
            br(),
            
            #slider for x-axis
            sliderInput("sliderX" , "Pick min and max value for x-axis" ,
                        min = -100, max = 100,
                        value=c(-50,50)),
            
            #slider for y-axis
            sliderInput("sliderY" , "Pick min and max value for y-axis" ,
                        min = -100, max = 100,
                        value=c(-50,50)),
            
            #check box for showing title or not 
            checkboxInput("show_title","show/hide title"),
            
            br(),
            print("**********part 2 ***************"),
            
            
            #slider for selecting MPG 
            sliderInput("sliderMPG" , "what is the MPG of the car?" , 10, 35 , value = 20),
            
            #check box for we want to show model line or not
            checkboxInput("showModel1" , "show/hide model1" , value = TRUE),
            checkboxInput("showModel2" , "show/hide model2" , value = TRUE),
           
            #whenever we clicked on the button then only action will perfrom 
            #just un-comment and it will work
            #submitButton("SUBMIT")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            print("**********************************  part 0  ******************************************************************"),
            br(),
            print("Selected value is "),
            
            #printed slider value
            textOutput("slider2_text"),
            
            br(),
            print("**********************************  part 1  ******************************************************************"),
            #to plot selected slider values = 
            plotOutput("manual_plot"),
            
            print("**********************************  part 2  ****************************************************************"),
            plotOutput("car_data_plot_with_model1"),
            
            h3("Predicted HoursePower from model 1 :"),
            textOutput("pred1"),
            
            h3("Predicted HoursePower from model 2 :"),
            textOutput("pred2"),
         
        )
    )
))
