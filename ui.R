# ===================================================================================
# User interface part of the application
# Author: Vinh N. Pham
# NOTE: variables shared between ui.R and server.R is stored in global.R
# ===================================================================================
library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Fuel Efficiency for Car Dummies"),
  sidebarPanel(
    selectInput(inputId = "modelYear",
                label = "Model Year",
                choices = c("All", "2010", "2011", "2012"),
                selected = "All"),
    
    selectInput(inputId = "sizeClass",
                label = "Size Class",
                choices = sizeClassLabel,
                selected = "Compact Cars"),
    
    selectInput(inputId = "driveConfig",
                label = "Drive Configuration",
                choices = driveConfigLabel,
                selected = "Two Wheel Drive Front"),
    
    selectInput(inputId = "numberOfCylinder",
                label = "Number of Cylinders",
                choices = c(2,3,4,5,6,8,10,12,16),
                selected = 4)
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Result",
        h4("Selected vehicle information:"),
        textOutput("valueSelectedMessage"),
        h4("Expected Milage:"),
        textOutput("mpgMessage"),
        textOutput("note"),
        h4("Representative Image"),
        imageOutput("carImage")),
      tabPanel("Author Info",
               p("Author: Vinh N. Pham"),
               p("Coursera - Developing Data Product - Oct 2014")),
      tabPanel("Help",
               p("This application is a mean for absolute car beginners (like myself) to investigate the fuel efficiency \
                 of various car models.  Even though there are other more accurate parameters for predicting the milage, \
                 they are not easily understood by beginners.  The choices in this application are meant to be intuitive \
                 options for consumers, not technical experts.  That is its value."),
               p("The data used in this application is the fuel efficiency of car models of the year 2010, 2011, and 2011.  \
                 These data are taken from the \"AppliedPredictiveModeling\" R package, which in turn collected the data \
                 from website http://fueleconomy.gov."),
               h4("Interface Guide:"),
               p("-  The application is a web page containing of 2 panes.  The sidebar displays the options to specify for \
                 the vehicle, and the main pane displays the fuel efficiency.  A image of the selected model is also \
                 displayed in the main pane.  This image is not the exact configuration but a generic representation of \
                 the select model for use as reference."),
               p("- Select the options and the result in the main pane will show the milage."),
               h5("Options:"),
               p("   - Model Year: Vehicle model year."),
               p("   - Size Class: Compact Cars, Large Cars, Cargo Type Vans, ..."),
               p("   - Drive Configuration: Two Wheel Drive, Four Wheel Drive ..."),
               p("   - Number of Cylinder: Number of cylinder in vehicle engine.  2, 4, 8, ...  The default is 4."),
               h4("Note:"),
               p("  - The represented image correspond to only the Size Class option, which will be blank if the \
                      \"Other\" choice is selected."),
               p("  - If there is no vehicle in the database with the same Size Class and Drive Configuration, a message \
                      \"This model configuration does not exist in the database\" will be displayed instead of the mileage.  \
                      Other than that, fuel efficiency is predicted using linear regression models.")
               ))
  )
))
